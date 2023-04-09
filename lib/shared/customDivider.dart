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

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
    this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return Divider(
        height: height,
        thickness: 2,
      );
    }
    return const Divider(
      height: 20,
      thickness: 2,
    );
  }
}
