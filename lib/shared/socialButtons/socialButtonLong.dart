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

import '../../themes/themeGuide.dart';
import 'socialButtons.dart';

class SocialButtonLong extends StatelessWidget {
  const SocialButtonLong({
    this.buttonType,
    @required this.label,
    @required this.onPress,
  });

  const SocialButtonLong.google({
    this.buttonType = SocialButtonType.GOOGLE,
    @required this.label,
    @required this.onPress,
  });

  const SocialButtonLong.facebook({
    this.buttonType = SocialButtonType.FACEBOOK,
    @required this.label,
    @required this.onPress,
  });

  const SocialButtonLong.apple({
    this.buttonType = SocialButtonType.APPLE,
    @required this.label,
    @required this.onPress,
  });

  final SocialButtonType buttonType;
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    Widget _renderButton = const SizedBox();

    switch (buttonType) {
      case SocialButtonType.GOOGLE:
        _renderButton = SocialButtons.google(onPress: onPress);
        break;

      case SocialButtonType.FACEBOOK:
        _renderButton = SocialButtons.facebook(onPress: onPress);
        break;

      case SocialButtonType.APPLE:
        _renderButton = SocialButtons.apple(onPress: onPress);
        break;

      default:
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: _theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius16,
      ),
      child: Row(
        children: <Widget>[
          _renderButton,
          Expanded(
            child: Text(
              label,
              style: _theme.textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
