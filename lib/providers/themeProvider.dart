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
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../services/storage/localStorage.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    init();
  }

  // Initial ThemeMode of the app
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    _themeMode =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;

    // check for theme pref
    final int? themeId = await LocalStorage.getInt(LocalStorageConstants.THEME);
    _themeMode =
        themeId == 1 || themeId == null ? ThemeMode.light : ThemeMode.dark;
    if (_themeMode == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
    notifyListeners();
  }

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      notifyListeners();
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ));
      LocalStorage.setInt(
        LocalStorageConstants.THEME,
        LocalStorageConstants.THEME_DARK,
      );
      return;
    }

    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
      notifyListeners();
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ));
      LocalStorage.setInt(
        LocalStorageConstants.THEME,
        LocalStorageConstants.THEME_LIGHT,
      );
      return;
    }
  }
}
