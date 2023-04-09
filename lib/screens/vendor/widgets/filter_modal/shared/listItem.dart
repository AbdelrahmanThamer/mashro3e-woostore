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

class HorizontalListTextItem extends StatelessWidget {
  const HorizontalListTextItem({
    Key key,
    @required this.text,
    @required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    if (text == null) {
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
              : const Border(),
        ),
        child: Center(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
