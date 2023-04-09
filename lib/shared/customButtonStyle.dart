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

import 'package:flutter/material.dart';

import '../themes/themeGuide.dart';

class CustomButtonStyle extends StatelessWidget {
  const CustomButtonStyle({
    Key? key,
    this.child,
    this.color,
    this.padding,
    this.border,
  }) : super(key: key);

  final Widget? child;
  final Color? color;
  final EdgeInsets? padding;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? ThemeGuide.padding10,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColorLight,
        borderRadius: ThemeGuide.borderRadius,
        border: border,
      ),
      child: child,
    );
  }
}
