import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String profileImageUrl;
  final int createdAt;
  final int updatedAt;
  final bool isActive;
  final int dob;
  final List<String> favorites;

  const User({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.dob,
    required this.favorites,
  });

  @override
  List<Object> get props {
    return [
      uid,
      email,
      name,
      phone,
      profileImageUrl,
      createdAt,
      updatedAt,
      isActive,
      dob,
      favorites,
    ];
  }

  User copyWith({
    String? uid,
    String? email,
    String? name,
    String? phone,
    String? profileImageUrl,
    int? createdAt,
    int? updatedAt,
    bool? isActive,
    int? dob,
    List<String>? favorites,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      dob: dob ?? this.dob,
      favorites: favorites ?? this.favorites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'dob': dob,
      'favorites': favorites,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
      isActive: map['isActive'] ?? false,
      dob: map['dob'] ?? 0,
      favorites: List<String>.from(map['favorites'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, name: $name, phone: $phone, profileImageUrl: $profileImageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, dob: $dob, favorites: $favorites)';
  }
}
