import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Order extends Equatable {
  final String orderId;
  final String uid;
  final String imageUrl;
  final int createdAt;
  final int updatedAt;
  final int totalPrice;
  final String status;
  final String paymentReference;
  final String deliveryMethods;
  final String paymentTypes;
  final int shippingDate;
  final List<OrderItem> orderItems;

  const Order({
    required this.orderId,
    required this.uid,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrice,
    required this.status,
    required this.paymentReference,
    required this.deliveryMethods,
    required this.paymentTypes,
    required this.shippingDate,
    required this.orderItems,
  });

  @override
  List<Object> get props {
    return [
      orderId,
      uid,
      imageUrl,
      createdAt,
      updatedAt,
      totalPrice,
      status,
      paymentReference,
      deliveryMethods,
      paymentTypes,
      shippingDate,
      orderItems,
    ];
  }

  Order copyWith({
    String? orderId,
    String? uid,
    String? imageUrl,
    int? createdAt,
    int? updatedAt,
    int? totalPrice,
    String? status,
    String? paymentReference,
    String? deliveryMethods,
    String? paymentTypes,
    int? shippingDate,
    List<OrderItem>? orderItems,
  }) {
    return Order(
      orderId: orderId ?? this.orderId,
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      paymentReference: paymentReference ?? this.paymentReference,
      deliveryMethods: deliveryMethods ?? this.deliveryMethods,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      shippingDate: shippingDate ?? this.shippingDate,
      orderItems: orderItems ?? this.orderItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'uid': uid,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'totalPrice': totalPrice,
      'status': status,
      'paymentReference': paymentReference,
      'deliveryMethods': deliveryMethods,
      'paymentTypes': paymentTypes,
      'shippingDate': shippingDate,
      'orderItems': orderItems.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] ?? '',
      uid: map['uid'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
      updatedAt: map['updatedAt']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      status: map['status'] ?? '',
      paymentReference: map['paymentReference'] ?? '',
      deliveryMethods: map['deliveryMethods'] ?? '',
      paymentTypes: map['paymentTypes'] ?? '',
      shippingDate: map['shippingDate']?.toInt() ?? 0,
      orderItems: List<OrderItem>.from(map['orderItems']?.map((x) => OrderItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(orderId: $orderId, uid: $uid, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, totalPrice: $totalPrice, status: $status, paymentReference: $paymentReference, deliveryMethods: $deliveryMethods, paymentTypes: $paymentTypes, shippingDate: $shippingDate, orderItems: $orderItems)';
  }
}

@immutable
class OrderItem extends Equatable {
  final String foodId;
  final String title;
  final int quantity;
  final int price;
  final int createdAt;
  final int updatedAt;
  final String coverImageUrl;
  final String category;

  const OrderItem({
    required this.foodId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.coverImageUrl,
    required this.category,
  });

  @override
  List<Object> get props {
    return [
      foodId,
      title,
      quantity,
      price,
      createdAt,
      updatedAt,
      coverImageUrl,
      category,
    ];
  }

  OrderItem copyWith({
    String? foodId,
    String? title,
    int? quantity,
    int? price,
    int? createdAt,
    int? updatedAt,
    String? coverImageUrl,
    String? category,
  }) {
    return OrderItem(
      foodId: foodId ?? this.foodId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodId': foodId,
      'title': title,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'coverImageUrl': coverImageUrl,
      'category': category,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      foodId: map['foodId'] ?? '',
      title: map['title'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
      createdAt: map['createdAt']?.toInt() ?? 0,
      updatedAt: map['updatedAt']?.toInt() ?? 0,
      coverImageUrl: map['coverImageUrl'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) => OrderItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(foodId: $foodId, title: $title, quantity: $quantity, price: $price, createdAt: $createdAt, updatedAt: $updatedAt, coverImageUrl: $coverImageUrl, category: $category)';
  }
}
