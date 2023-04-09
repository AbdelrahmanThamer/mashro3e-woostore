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

import '../themes/theme.dart';

/// Input Class that renders an Input Text field.
/// Takes in a `placeholder` to label the field.
class CustomInput extends StatelessWidget {
  const CustomInput({
    Key key,
    @required this.placeholder,
    @required this.onChange,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  final String placeholder, initialValue;
  final String Function(String) validator;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    final bool obscureText =
        placeholder.toString().toLowerCase() == 'password' || false;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _theme.colorScheme.primary,
        borderRadius: ThemeGuide.borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(230, 230, 230, 1),
            blurRadius: 20,
            spreadRadius: 5,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        validator: validator,
        onChanged: onChange,
        autocorrect: false,
        obscureText: obscureText,
        textCapitalization: TextCapitalization.none,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: placeholder,
        ),
      ),
    );
  }
}
