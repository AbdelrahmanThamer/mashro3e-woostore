// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is, and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/customer_download.dart';
import 'package:woocommerce/models/wooPoints.dart';

/// Model class to store `User` information
class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl = '',
    this.gender,
    this.dob,
    this.phone,
    this.wooCustomer,
    this.points,
    this.downloads,
  });

  String id;
  String? name;
  String? phone;
  String? email;
  String? gender;
  String? dob;
  String? profileImageUrl;
  WooCustomer? wooCustomer;
  WooPoints? points;
  List<WooCustomerDownload>? downloads;

  User.fromFAuthUser(FAuthUser user)
      : id = user.uid,
        email = user.email;

  /// Creates a User instance from wooCustomer object
  factory User.fromWooCustomer(WooCustomer wooCustomer) {
    return User(
      id: wooCustomer.id.toString(),
      name: wooCustomer.firstName,
      email: wooCustomer.email,
      profileImageUrl: wooCustomer.avatarUrl ?? '',
      wooCustomer: wooCustomer,
      phone: wooCustomer.phone,
    );
  }

  factory User.empty() {
    return User(
      id: '',
      name: '',
      email: '',
      profileImageUrl: '',
      gender: '',
      dob: '',
      phone: '',
      wooCustomer: WooCustomer(),
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final WooCustomer customer = WooCustomer.fromJson(map['wooCustomer']);
    final _user = User.fromWooCustomer(customer);
    _user.dob = map['dob'];
    _user.gender = map['gender'];
    _user.phone = map['phone'];
    return _user;
  }

  /// Updates the new values from woo customer into the
  /// already available instance
  void updateWooCustomerInformation(WooCustomer customer) {
    id = customer.id.toString();
    name = customer.firstName;
    email = customer.email;
    profileImageUrl = customer.avatarUrl ?? '';
    wooCustomer = customer;
    phone = customer.phone;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'gender': gender,
      'dob': dob,
      'phone': phone,
      'wooCustomer': wooCustomer?.toJson(),
    };
  }
}

///
/// ## `Description`
///
/// Model class for the firebase user.
/// Only takes the `id` and `email` of the user.
///
/// Note: Do not use for storing user info except to check if user is present.
///
class FAuthUser {
  const FAuthUser({
    required this.uid,
    required this.email,
  });

  final String uid, email;
}
