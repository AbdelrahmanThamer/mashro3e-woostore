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

class TextInputLabel extends StatelessWidget {
  const TextInputLabel({Key key, @required this.label}) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      child: Text(
        label,
        style: _theme.textTheme.headline6.copyWith(fontSize: 16),
      ),
    );
  }
}
