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

import '../../../../generated/l10n.dart';
import '../../../../shared/animatedButton.dart';
import '../../../../themes/theme.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key key,
    this.next,
    this.back,
    this.nextLabel,
    this.backLabel,
    this.showBack = true,
  }) : super(key: key);

  final Function next;
  final Function back;
  final String nextLabel, backLabel;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final ThemeData _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: _theme.colorScheme.background,
      // ),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            if (showBack)
              Expanded(
                child: AnimButton(
                  onTap: () {
                    if (back != null) {
                      back();
                    }
                  },
                  child: Container(
                    padding: ThemeGuide.padding16,
                    decoration: BoxDecoration(
                      borderRadius: ThemeGuide.borderRadius,
                      color: _theme.disabledColor.withAlpha(40),
                    ),
                    child: Text(
                      backLabel ?? lang.back,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            if (showBack) const SizedBox(width: 10),
            Expanded(
              child: AnimButton(
                onTap: () {
                  if (next != null) {
                    next();
                  }
                },
                child: Container(
                  padding: ThemeGuide.padding16,
                  decoration: BoxDecoration(
                    borderRadius: ThemeGuide.borderRadius,
                    gradient: AppGradients.linearGradient(context),
                  ),
                  child: Text(
                    nextLabel ?? lang.next,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
