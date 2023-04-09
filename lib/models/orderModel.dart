// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/foundation.dart';

class Order {
  Order({
    @required this.orderId,
    @required this.transactionId,
    @required this.status,
    this.imageUrl,
    this.name,
    this.date,
    this.price,
    this.quantity,
    this.address,
  })  : assert(orderId != null),
        assert(status != null);

  String orderId,
      name,
      date,
      status,
      price,
      imageUrl,
      quantity,
      transactionId,
      address;
}
