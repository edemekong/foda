import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:foda/models/order.dart';
import 'package:foda/models/result.dart';

class OrderRepository {
  final ordersCollection = FirebaseFirestore.instance.collection("orders");
  ValueNotifier<List<Order>> ordersNotifier = ValueNotifier<List<Order>>([]);

  Future<Either<ErrorHandler, bool>> createOrder(String uid, Order order) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      Map<String, dynamic> orderMap = order.toMap();
      for (final item in order.orderItems) {
        batch.delete(FirebaseFirestore.instance.collection('users').doc(uid).collection('cart').doc(item.foodId));
      }

      batch.set(ordersCollection.doc(order.orderId), orderMap);
      await batch.commit();

      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(ErrorHandler(message: e.message ?? ''));
    }
  }
}
