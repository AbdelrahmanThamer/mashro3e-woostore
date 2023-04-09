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

import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  const StyledContainer({
    Key? key,
    this.padding = const EdgeInsets.all(10),
    this.margin,
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.child,
  }) : super(key: key);

  final EdgeInsets padding;
  final EdgeInsets? margin;
  final Color? color;
  final BorderRadius borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.background,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
