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

import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../locator.dart';
import '../shared/customDialog.dart';
import '../themes/gradients.dart';
import '../themes/themeGuide.dart';

export 'package:another_flushbar/flushbar.dart';

abstract class UiController {
  /// Creates a modal screen
  static void showModal({
    required BuildContext context,
    required Widget child,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return child;
      },
    );
  }

  /// Create a modal bottom sheet.
  static void modalBottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
  }

  static void showSnackBar(
    BuildContext context,
    String text, {
    String? actionLabel,
    required Function actionFun,
  }) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: actionLabel ?? '',
          onPressed: () => actionFun(),
        ),
      ),
    );
  }

  /// Displays a custom alert box with blurred background
  static void showCustomDialog(
    BuildContext context,
    Widget child, {
    bool showCloseButton = true,
  }) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return CustomDialog(
          showCloseButton: showCloseButton,
          child: Opacity(
            opacity: a1.value,
            child: IgnorePointer(child: child),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      },
    );
  }

  /// Displays a dialog with blurred background
  static void showBlurredDialog({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        barrierColor: Colors.black26,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: child,
          );
        });
  }

  static void showNotification({
    required BuildContext context,
    required String title,
    required String message,
    FlushbarPosition? position,
    Color? color,
    Duration? duration,
  }) {
    Flushbar(
      title: title,
      message: message,
      barBlur: 10,
      animationDuration: const Duration(milliseconds: 600),
      backgroundColor: color?.withAlpha(150) ?? Colors.black.withAlpha(150),
      duration: duration ?? const Duration(seconds: 2),
      borderRadius: ThemeGuide.borderRadius10,
      margin: ThemeGuide.padding10,
      flushbarPosition: position ?? FlushbarPosition.TOP,
    ).show(context);
  }

  static void showErrorNotification({
    required BuildContext context,
    required String title,
    required String message,
    FlushbarPosition? position,
  }) {
    Flushbar(
      title: title,
      message: message,
      barBlur: 10,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
      animationDuration: const Duration(milliseconds: 1000),
      backgroundColor: Colors.red.withAlpha(150),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 5),
      borderRadius: ThemeGuide.borderRadius10,
      margin: ThemeGuide.padding10,
      flushbarPosition: position ?? FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  /// Show this notification when there is some processing and user wants to
  /// perform that action which will result in termination of the processing.
  static void showProcessingNotification({
    required BuildContext context,
    required String title,
    required String message,
    Color color = Colors.red,
  }) {
    Flushbar(
      title: title,
      message: message,
      barBlur: 10,
      animationDuration: const Duration(milliseconds: 600),
      backgroundColor: color.withAlpha(150),
      duration: const Duration(seconds: 2),
      borderRadius: ThemeGuide.borderRadius10,
      margin: ThemeGuide.padding10,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  /// Show a Flushbar notification with internal use of context
  /// Pass the context by parameter or set it as an Application Global Context
  /// using the [Application.setContext] method
  static void showRawNotification({
    required BuildContext context,
    required Flushbar flushbar,
  }) {
    flushbar.show(context);
  }

  /// Show `item added to cart` notification
  static void itemAddedNotification({required BuildContext context}) {
    Flushbar(
      message: S.of(context).itemAddedToCart,
      barBlur: 10,
      animationDuration: const Duration(milliseconds: 600),
      duration: const Duration(seconds: 2),
      borderRadius: ThemeGuide.borderRadius,
      margin: ThemeGuide.padding10,
      padding: ThemeGuide.padding20,
      backgroundColor: Colors.transparent.withAlpha(150),
      backgroundGradient: AppGradients.linearGradient(context),
    ).show(context);
  }
}
