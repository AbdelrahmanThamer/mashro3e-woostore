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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';

abstract class DialogUtils {
  static double height(double height) => height - 100;

  static double width(double width) => width / 1.7;

  static void showLoadingDialog({required BuildContext context}) {
    showDialog(
      routeSettings: const RouteSettings(name: 'loading-dialog'),
      useRootNavigator: true,
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: ThemeGuide.borderRadius10,
        ),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: ThemeGuide.borderRadius10,
          ),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  static void popLoadingDialog({required BuildContext context}) {
    Navigator.of(context, rootNavigator: true).pop();

    // if (ModalRoute.of(context)?.settings.name == 'loading-dialog') {
    //   Navigator.of(context, rootNavigator: true).pop();
    // }
  }
}
