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
