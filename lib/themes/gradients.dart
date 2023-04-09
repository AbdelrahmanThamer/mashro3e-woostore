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

import 'package:flutter/material.dart';

import 'theme.dart';

abstract class AppGradients {
  static LinearGradient linearGradient(BuildContext context) {
    final theme = Theme.of(context);
    return LinearGradient(
      colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
      begin: Alignment.bottomLeft,
      end: const Alignment(0.8, 0.0),
    );
  }

  /// The main `LinearGradient` with blue and green color.
  static const LinearGradient mainGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary],
    begin: Alignment.bottomLeft,
    end: Alignment(0.8, 0.0),
  );

  /// The main `LinearGradient` with blue and green color.
  static const LinearGradient mainGradientDarkMode = LinearGradient(
    colors: [AppColors.primaryDark, AppColors.secondaryDark],
    begin: Alignment.bottomLeft,
    end: Alignment(0.8, 0.0),
  );

  /// The `LinearGradient` for tabbar icons. The colors used are
  /// app colors light blue and white
  static const LinearGradient tabbarIconGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.5, 0],
    colors: <Color>[
      AppColors.tabbar,
      AppColors.mWhite,
    ],
    tileMode: TileMode.mirror,
  );

  /// The `LinearGradient` for tabbar icons. The colors used are
  /// app colors light blue and white
  static const LinearGradient tabbarIconGradientDarkMode = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.5, 0],
    colors: <Color>[
      AppColors.tabbarDark,
      AppColors.mWhite,
    ],
    tileMode: TileMode.mirror,
  );
}
