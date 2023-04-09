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

/// All the colors used in the application are defined here
///
/// Update the colors as desired with their dark mode variations below them.
abstract class AppColors {
  static const Color primary = Color(0xFF497FF3);
  static const Color primaryDark = Colors.green;

  static const Color secondary = Color(0xFF0CA8B0);
  static const Color secondaryDark = Color(0xFF0CA8B0);

  static const Color tabbar = Color(0xFF24AAF0);
  static const Color tabbarDark = Color(0xFF66BB6A);

  static const Color accent = Color(0xFF24AAF0);
  static const Color accentDark = Color(0xFF66BB6A);

  static const Color buttonColor = Color(0xFF24AAF0);
  static const Color buttonColorDark = Color(0xFF24AAF0);

  static const Color buttonHighlightColor = Color(0xFF7EA5FF);
  static const Color buttonHighlightColorDark = Color(0xFF7EA5FF);

  static const Color buttonSplashColor = Color(0xFF7EA5FF);
  static const Color buttonSplashColorDark = Color(0xFF7EA5FF);

  // Product On Sale Banner color
  static const Color productItemCardOnSaleBanner = Color(0xCC4CAF50);
  static const Color productItemCardOnSaleBannerDark = Color(0xCC4CAF50);

  // Disabled Color
  static const Color mDisabledColor = Color(0xFFD2D2D2);

  static const Color mWhite = Color(0xFFF4F5FA);
  static const Color errorText = Color(0xFFEF5350);
  static const Color lightGrey = Color(0xFFA8A8A8);
  static const Color backgroundDark = Color.fromRGBO(42, 42, 42, 1);
  static const Color backgroundLight = Color.fromRGBO(248, 248, 248, 1);
}
