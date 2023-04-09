// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/foundation.dart';

@immutable
class RecentProduct {
  final String id;
  final String name;
  final String displayImage;

  const RecentProduct({
    required this.id,
    required this.name,
    required this.displayImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'displayImage': displayImage,
    };
  }

  factory RecentProduct.fromMap(Map<String, dynamic> map) {
    return RecentProduct(
      id: ModelUtils.createStringProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      displayImage: ModelUtils.createStringProperty(map['displayImage']),
    );
  }
}
