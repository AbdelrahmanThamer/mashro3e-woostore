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
import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';

import '../services/storage/localStorage.dart';

class LanguageProvider with ChangeNotifier {
  /// The current selected local of the application
  Locale locale = Locale(Intl.getCurrentLocale(), '');

  LanguageProvider() {
    init();
  }

  Future<void> init() async {
    final String? savedLocale =
        await LocalStorage.getString(LocalStorageConstants.Locale);
    if (isNotBlank(savedLocale)) {
      locale = Locale(savedLocale!, '');
      return;
    }
    locale = Locale(Intl.getCurrentLocale(), '');
  }

  void changeLocale(Locale locale) {
    this.locale = locale;
    notifyListeners();
    if (isNotBlank(locale.languageCode)) {
      LocalStorage.setString(LocalStorageConstants.Locale, locale.languageCode);
    }
  }
}
