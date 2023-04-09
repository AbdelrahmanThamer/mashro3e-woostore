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

import '../../../themes/themeGuide.dart';
import '../../../utils/style.dart';

class StatusBuilder extends StatelessWidget {
  final Color color, bgColor;
  final String text;

  const StatusBuilder.completed({
    Key key,
    this.color = const Color(0xFF66BB6A),
    this.bgColor = const Color(0xFFE8F5E9),
    @required this.text,
  }) : super(key: key);

  const StatusBuilder.processing({
    Key key,
    this.color = const Color(0xFF42A5F5),
    this.bgColor = const Color(0xFFE3F2FD),
    @required this.text,
  }) : super(key: key);

  const StatusBuilder.cancelled({
    Key key,
    this.color = const Color(0xFF616161),
    this.bgColor = const Color(0xFFE0E0E0),
    @required this.text,
  }) : super(key: key);

  const StatusBuilder.pending({
    Key key,
    this.color = const Color(0xFFF9A825),
    this.bgColor = const Color(0xFFFFF9C4),
    @required this.text,
  }) : super(key: key);

  const StatusBuilder.failed({
    Key key,
    this.color = const Color(0xFFEF5350),
    this.bgColor = const Color(0xFFFFEBEE),
    @required this.text,
  }) : super(key: key);

  const StatusBuilder.undefined({
    Key key,
    this.color = const Color(0xFFF57C00),
    this.bgColor = const Color(0xFFFFE0B2),
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: ThemeGuide.borderRadius,
        color: UIStyle.isDarkMode(context) ? Colors.transparent : bgColor,
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: color, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
