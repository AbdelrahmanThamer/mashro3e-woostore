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

import 'package:flutter/foundation.dart';

@immutable
class VendorCardVendorData {
  final String id;
  final String name;
  final String displayImage;
  final String? price;
  final String? regularPrice;
  final int? ratingCount;
  final String? averageRating;
  final String? type;
  final bool onSale;

  const VendorCardVendorData({
    required this.id,
    required this.name,
    required this.displayImage,
    this.price,
    this.regularPrice,
    this.ratingCount,
    this.averageRating,
    this.type,
    this.onSale = false,
  });
}
