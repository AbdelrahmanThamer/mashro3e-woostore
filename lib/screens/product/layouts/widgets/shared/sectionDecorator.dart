// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import '../../../../../themes/theme.dart';

class SectionDecorator extends StatelessWidget {
  const SectionDecorator({
    Key key,
    this.child,
    this.padding,
    this.margin,
    this.color,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).disabledColor.withAlpha(10),
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: child,
    );
  }
}
