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

import '../../../themes/colors.dart';
import '../../../themes/themeGuide.dart';

class BottomSheetDecorator extends StatelessWidget {
  const BottomSheetDecorator({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: ThemeGuide.padding20,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadiusBottomSheet,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const _Notch(),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  const _Notch({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.15,
      child: Container(
        height: 5,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: ThemeGuide.borderRadius10,
        ),
      ),
    );
  }
}
