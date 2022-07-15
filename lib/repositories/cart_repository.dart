// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:foda/models/cart_item.dart';
import 'package:foda/models/result.dart';

import '../models/food.dart';
import '../utils/common.dart';

class CartRepository {
  final _firestoreUser = FirebaseFirestore.instance.collection('users');

  ValueNotifier<List<CartItem>> cartNotifier = ValueNotifier<List<CartItem>>([]);

  StreamSubscription? _cartSnapShotSubscription;

  Future<Either<ErrorHandler, CartItem>> getCartItem(String uid, String foodId) async {
    try {
      final cartItem = cartNotifier.value.firstWhere((item) => item.foodId == foodId);
      return Right(cartItem);
    } catch (e) {
      try {
        final _cartSnapshot = await _firestoreUser.doc(uid).collection('cart').doc(foodId).get();
        if (_cartSnapshot.exists) {
          fodaPrint(_cartSnapshot.data());
          return Right(CartItem.fromMap(_cartSnapshot.data() as Map<String, dynamic>));
        } else {
          return const Left(ErrorHandler(message: 'Failed To get CartItem'));
        }
      } on FirebaseException catch (e) {
        return Left(ErrorHandler(message: e.message ?? ''));
      }
    }
  }

  Future<Either<ErrorHandler, List<CartItem>>> getCart(String uid) async {
    _clearCart();
    try {
      _cartSnapShotSubscription = _firestoreUser.doc(uid).collection('cart').snapshots().listen(_listenToCart);
    } on FirebaseException catch (e) {
      return Left(ErrorHandler(message: e.message ?? ''));
    }

    return Right(cartNotifier.value);
  }

  Future<Either<ErrorHandler, bool>> addOrRemoveFoodFromCart(String uid, Food food, {bool isAdding = true}) async {
    try {
      final dateNow = DateTime.now().toUtc().millisecondsSinceEpoch;

      final cartDocRef = _firestoreUser.doc(uid).collection('cart').doc(food.id);
      final foodExistInCart = cartNotifier.value.where((cartItem) => cartItem.foodId == food.id).isNotEmpty;

      if (foodExistInCart) {
        final oldItem = cartNotifier.value.firstWhere((cartItem) => cartItem.foodId == food.id);
        final newItem = oldItem.copyWith(
          quantity: isAdding ? (oldItem.quantity + 1) : (oldItem.quantity - 1),
          updatedAt: dateNow,
        );
        if (isAdding == false && newItem.quantity < 1) {
          await removeFoodFromCart(uid, food);
        } else {
          await cartDocRef.update(newItem.toMap());
        }

        return const Right(true);
      } else {
        final cartItem = CartItem(
          foodId: food.id,
          quantity: 1,
          createdAt: dateNow,
          updatedAt: dateNow,
          category: food.category,
        );

        await cartDocRef.set(cartItem.toMap());
        return const Right(true);
      }
    } on FirebaseException catch (_) {
      return const Left(ErrorHandler(message: 'Failed to add Item to Basket'));
    }
  }

  Future<Either<ErrorHandler, bool>> removeFoodFromCart(String uid, Food food) async {
    try {
      await _firestoreUser.doc(uid).collection('cart').doc(food.id).delete();
      final foodExistInCart = cartNotifier.value.where((cartItem) => cartItem.foodId == food.id).isNotEmpty;
      if (foodExistInCart) {
        final index = cartNotifier.value.indexWhere((element) => element.foodId == food.id);
        cartNotifier.value.removeAt(index);
        cartNotifier.notifyListeners();
      }
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(ErrorHandler(message: e.message ?? ''));
    }
  }

  Future<Either<ErrorHandler, bool>> clearItemsFromCart(String uid) async {
    try {
      final deleteCartItemBatch = FirebaseFirestore.instance.batch();

      for (CartItem cartItem in cartNotifier.value) {
        deleteCartItemBatch.delete(_firestoreUser.doc(uid).collection('cart').doc(cartItem.foodId));
      }
      await deleteCartItemBatch.commit();
      cartNotifier.notifyListeners();

      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(ErrorHandler(message: e.message ?? ''));
    }
  }

  void _listenToCart(QuerySnapshot<Map<String, dynamic>> snappshot) {
    for (final doc in snappshot.docs) {
      final cartItem = CartItem.fromMap(doc.data());
      final index = cartNotifier.value.indexWhere((element) => element.foodId == cartItem.foodId);
      if (index != -1) {
        cartNotifier.value.removeAt(index);
        cartNotifier.value.insert(index, cartItem);

        if (cartItem.quantity < 1) {
          cartNotifier.value.removeAt(index);
        }
      } else {
        cartNotifier.value.add(cartItem);
      }
    }

    for (final doc in snappshot.docChanges) {
      final cartItem = CartItem.fromMap(doc.doc.data() as Map<String, dynamic>);
      final index = cartNotifier.value.indexWhere((element) => element.foodId == cartItem.foodId);

      if (doc.type == DocumentChangeType.removed) {
        cartNotifier.value.removeAt(index);
      }
    }

    cartNotifier.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    cartNotifier.notifyListeners();
  }

  void _removeCartListener() {
    _cartSnapShotSubscription?.cancel();
  }

  void _clearCart() {
    _removeCartListener();
    cartNotifier.value.clear();
    cartNotifier.notifyListeners();
  }
}
