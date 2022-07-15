// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:foda/models/result.dart';
import 'package:foda/models/user.dart';
import 'package:foda/services/authentication_service.dart';
import 'package:foda/utils/common.dart';

import '../models/food.dart';

class UserRepository {
  final _authService = AuthenicationService.instance;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  ValueNotifier<User?> currentUserNotifier = ValueNotifier<User?>(null);

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userStreamSubscriptions;

  StreamSubscription? _authStreamSubscription;

  String? get currentUserUID => _authService.auth.currentUser?.uid;

  set setCurrentUser(User? user) {
    currentUserNotifier.value = user;
    currentUserNotifier.notifyListeners();
  }

  UserRepository() {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authStreamSubscription?.cancel();
    _authStreamSubscription = null;

    _authStreamSubscription = _authService.authStates().listen((firebaseUser) {
      if (firebaseUser != null) {
        final String uid = firebaseUser.uid;
        getCurrentUser(uid);
        fodaPrint("CURRENT USER -> $uid");
      } else {
        fodaPrint("NO CURRENT USER");
      }
    });
  }

  Future<Either<ErrorHandler, User>> registerUser(User user, String password) async {
    try {
      final firebaseUser = await _authService.signUp(user.email, password);

      if (firebaseUser != null) {
        final newUser = user.copyWith(uid: firebaseUser.uid);
        await usersCollection.doc(firebaseUser.uid).set(newUser.toMap());
        await getCurrentUser(firebaseUser.uid);
        return Right(user);
      }

      return const Left(ErrorHandler(message: "Could'nt register user"));
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, User>> getCurrentUser(String uid) async {
    try {
      final userSnapshot = await usersCollection.doc(uid).get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final User user = User.fromMap(data);
        setCurrentUser = user;

        listenToCurrentUser(user.uid);
        return Right(user);
      } else {
        return const Left(ErrorHandler(message: "User does not exist"));
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, User>> login(String email, String password) async {
    try {
      final firebaseUser = await _authService.logIn(email, password);

      if (firebaseUser != null) {
        final getCurrentUserData = await getCurrentUser(firebaseUser.uid);
        if (getCurrentUserData.isRight) {
          return Right(getCurrentUserData.right);
        } else {
          return Left(getCurrentUserData.left);
        }
      }
      return const Left(ErrorHandler(message: "Could'nt login user"));
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Stream<User?> listenToCurrentUser(String uid) async* {
    try {
      final snapshots = usersCollection.doc(uid).snapshots();
      _userStreamSubscriptions?.cancel();
      _userStreamSubscriptions = null;
      _userStreamSubscriptions = snapshots.listen((document) {
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;
          final user = User.fromMap(data);
          setCurrentUser = user;
        }
      });
    } catch (e) {
      fodaPrint(e);
    }

    yield currentUserNotifier.value;
  }

  Future<Either<ErrorHandler, User>> googleSignIn() async {
    try {
      final firebaseUser = await _authService.googleSignIn();
      if (firebaseUser == null) return const Left(ErrorHandler(message: "Could not signin"));
      final snapshot = await usersCollection.doc(firebaseUser.uid).get();
      if (!snapshot.exists) {
        final newUser = User(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? "",
          phone: firebaseUser.phoneNumber ?? "",
          profileImageUrl: firebaseUser.photoURL ?? "",
          createdAt: timeNow(),
          updatedAt: timeNow(),
          isActive: true,
          dob: 0,
        );

        await usersCollection.doc(firebaseUser.uid).set(newUser.toMap());
        final getUser = await getCurrentUser(firebaseUser.uid);
        if (getUser.isRight) {
          return Right(getUser.right);
        } else {
          return const Left(ErrorHandler(message: "Could not signin"));
        }
      } else {
        final user = User.fromMap(snapshot.data() as Map<String, dynamic>);
        listenToCurrentUser(user.uid);
        return Right(user);
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, bool>> addFoodToFavorite(String uid, Food food, {bool isAdding = true}) async {
    try {
      await usersCollection.doc(uid).update({
        "favorites": isAdding ? FieldValue.arrayUnion([food.id]) : FieldValue.arrayRemove([food.id]),
      });
      return Right(isAdding);
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<void> logout() async {
    setCurrentUser = null;
    await _authService.logout();
  }
}
