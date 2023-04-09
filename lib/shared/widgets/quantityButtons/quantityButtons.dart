// @dart=2.9

import 'package:flutter/material.dart';

import '../../../themes/theme.dart';

class QuantityButtonPositive extends StatelessWidget {
  const QuantityButtonPositive({
    Key key,
    @required this.productId,
    @required this.onPressed,
  }) : super(key: key);

  final String productId;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onPressed(productId);
      },
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: _theme.colorScheme.primary,
          ),
          borderRadius: ThemeGuide.borderRadius5,
        ),
        child: Icon(
          Icons.add,
          color: _theme.colorScheme.primary,
          size: 18,
        ),
      ),
    );
  }
}

class QuantityButtonNegative extends StatelessWidget {
  const QuantityButtonNegative({
    Key key,
    @required this.productId,
    @required this.onPressed,
  }) : super(key: key);

  final String productId;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onPressed(productId);
      },
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: _theme.colorScheme.primary,
          ),
          borderRadius: ThemeGuide.borderRadius5,
        ),
        child: Icon(
          Icons.remove,
          color: _theme.colorScheme.primary,
          size: 18,
        ),
      ),
    );
  }
}
