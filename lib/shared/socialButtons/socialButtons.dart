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
import 'package:flutter_svg/flutter_svg.dart';

enum SocialButtonType {
  GOOGLE,
  FACEBOOK,
  APPLE,
}

class SocialButtons extends StatelessWidget {
  static const String _svgAssetPath = 'assets/svg/';

  const SocialButtons.google({
    this.buttonType = SocialButtonType.GOOGLE,
    required this.onPress,
  });

  const SocialButtons.facebook({
    this.buttonType = SocialButtonType.FACEBOOK,
    required this.onPress,
  });

  const SocialButtons.apple({
    this.buttonType = SocialButtonType.APPLE,
    required this.onPress,
  });

  final SocialButtonType buttonType;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    if (buttonType == SocialButtonType.APPLE) {
      return InkWell(
        highlightColor: Colors.transparent,
        onTap: onPress,
        child: SvgPicture.asset(
          _svgAssetPath + 'apple.svg',
          height: 40,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      );
    }

    if (buttonType == SocialButtonType.GOOGLE) {
      return InkWell(
        highlightColor: Colors.transparent,
        onTap: onPress,
        child: SvgPicture.asset(
          _svgAssetPath + 'google.svg',
          height: 40,
        ),
      );
    }

    if (buttonType == SocialButtonType.FACEBOOK) {
      return InkWell(
        highlightColor: Colors.transparent,
        onTap: onPress,
        child: SvgPicture.asset(
          _svgAssetPath + 'facebook.svg',
          height: 45,
        ),
      );
    }

    return const SizedBox();
  }
}
