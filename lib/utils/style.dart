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

class UIStyle {
  /// Renders the light or dark shadow provided based on the theme of the
  /// application
  static List<BoxShadow> renderShadow({
    required BuildContext context,
    required BoxShadow light,
    required BoxShadow dark,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      return [dark];
    } else {
      return [light];
    }
  }

  /// Checks if the theme is in dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == ThemeData.dark().brightness;
  }
}
