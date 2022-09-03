// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:foda/models/result.dart';

import '../models/food.dart';

class FoodRepository {
  final _firestore = FirebaseFirestore.instance;

  ValueNotifier<List<Food>> foodsNotifier = ValueNotifier<List<Food>>([]);

  StreamSubscription? streamsSubscriptions;

  Future<Either<ErrorHandler, List<Food>>> getFoods() async {
    try {
      final querySnapshot = _firestore.collection("foods").where("isLive", isEqualTo: true).snapshots();
      streamsSubscriptions?.cancel();
      streamsSubscriptions = null;
      streamsSubscriptions = querySnapshot.listen(_listenToFoods);
      return const Right([]);
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, Food>> getFood(String foodId) async {
    try {
      final food = foodsNotifier.value.firstWhere((food) => food.id == foodId);
      return Right(food);
    } catch (e) {
      try {
        if (foodId.isEmpty) {
          return const Left(ErrorHandler(message: 'No food Id found...'));
        }
        final _productSnapshot = await _firestore.doc(foodId).get();
        if (_productSnapshot.exists) {
          final food = Food.fromMap(_productSnapshot.data() as Map<String, dynamic>);
          foodsNotifier.value.add(food);
          foodsNotifier.notifyListeners();
          return Right(food);
        }
        return const Left(ErrorHandler(message: "Error"));
      } on FirebaseException catch (e) {
        return Left(ErrorHandler(message: e.message ?? ''));
      }
    }
  }

  void _listenToFoods(QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (final document in snapshot.docs) {
      final food = Food.fromMap(document.data());

      final index = foodsNotifier.value.indexWhere((element) => element.id == food.id);

      if (index != -1) {
        foodsNotifier.value.removeAt(index);
        foodsNotifier.value.insert(index, food);
      } else {
        foodsNotifier.value.add(food);
      }

      foodsNotifier.notifyListeners();
    }
  }
}
