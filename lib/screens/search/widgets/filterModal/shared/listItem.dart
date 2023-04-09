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
import 'package:quiver/strings.dart';

import '../../../../../themes/theme.dart';

class HorizontalListTextItem extends StatelessWidget {
  const HorizontalListTextItem({
    Key? key,
    this.text,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String? text;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (isBlank(text)) {
      return const SizedBox();
    }
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: ThemeGuide.padding10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: theme.disabledColor.withAlpha(10),
          borderRadius: ThemeGuide.borderRadius,
          border: isSelected
              ? Border.all(
                  width: 2,
                  color: theme.colorScheme.primary,
                )
              : const Border.symmetric(
                  vertical: BorderSide(width: 2, color: Colors.transparent),
                  horizontal: BorderSide(width: 2, color: Colors.transparent),
                ),
        ),
        child: Center(
          child: Text(text!),
        ),
      ),
    );
  }
}
