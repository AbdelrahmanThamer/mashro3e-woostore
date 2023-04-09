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

abstract class ThemeGuide {
  /// The aspect ration for the product item card
  static const double productItemCardAspectRatio = 1 / 2;
  static const double horizontalProductListContainerAspectRatio = 1 / 1;

  static const EdgeInsets padding5 = EdgeInsets.all(5);
  static const EdgeInsets padding = EdgeInsets.all(8);
  static const EdgeInsets padding10 = EdgeInsets.all(10);
  static const EdgeInsets padding12 = EdgeInsets.all(12);
  static const EdgeInsets padding16 = EdgeInsets.all(16);
  static const EdgeInsets padding20 = EdgeInsets.all(20);

  // Margins
  static const EdgeInsets margin5 = EdgeInsets.all(5);
  static const EdgeInsets margin10 = EdgeInsets.all(10);
  static const EdgeInsets marginV5 = EdgeInsets.symmetric(vertical: 5);
  static const EdgeInsets marginV10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets marginH5 = EdgeInsets.symmetric(horizontal: 5);
  static const EdgeInsets marginH10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets margin20 = EdgeInsets.all(20);

  /// List padding is equal on `LTR` and extra on `Bottom`
  static const EdgeInsets listPadding = EdgeInsets.fromLTRB(10, 10, 10, 120);

  static const BorderRadius borderRadius5 =
      BorderRadius.all(Radius.circular(5));
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadius10 = BorderRadius.all(
    Radius.circular(10),
  );
  static const BorderRadius borderRadius16 = BorderRadius.all(
    Radius.circular(16),
  );
  static const BorderRadius borderRadius20 = BorderRadius.all(
    Radius.circular(20),
  );

  static const BorderRadius borderRadiusBottomSheet = BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
  );

  /// Primary box shadow - Light Black Shadow
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(255, 230, 230, 230),
    blurRadius: 15,
    spreadRadius: 3,
    offset: Offset(0.0, 3.0),
  );

  /// Primary box shadow - dark Black Shadow
  static const BoxShadow primaryShadowDark = BoxShadow(
    color: Colors.black38,
    blurRadius: 15,
    spreadRadius: 3,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow productItemCardShadow = BoxShadow(
    color: Color.fromARGB(255, 230, 230, 230),
    blurRadius: 5,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow productItemCardShadowDark = BoxShadow(
    color: Colors.black38,
    blurRadius: 5,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow textFieldShadow = BoxShadow(
    color: Color.fromARGB(255, 230, 230, 230),
    blurRadius: 20,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow textFieldShadowDark = BoxShadow(
    color: Colors.black38,
    blurRadius: 20,
    spreadRadius: 2,
    offset: Offset(0.0, 3.0),
  );

  static const BoxShadow darkShadow = BoxShadow(
    color: Color.fromARGB(100, 150, 150, 150),
    spreadRadius: 1,
    blurRadius: 20,
    offset: Offset(0.0, 2.0),
  );

  /// Checks if the theme is in dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == ThemeData.dark().brightness;
  }
}
