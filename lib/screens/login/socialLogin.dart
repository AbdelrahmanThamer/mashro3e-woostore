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

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../app_builder/app_builder.dart';
import '../../controllers/authController.dart';
import '../../core/network/network.dart';
import '../../developer/dev.log.dart';
import '../../generated/l10n.dart';
import '../../shared/socialButtons/socialButtons.dart';
import '../../themes/theme.dart';
import '../../utils/utils.dart';
import 'otp_login/otp_login.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({
    Key? key,
    this.onSuccess,
  }) : super(key: key);

  /// Function to call after the login is successful
  final Function? onSuccess;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          if (Platform.isIOS)
            if (ParseEngine.enabledAppleLogin)
              _decorator(
                theme,
                SocialButtons.apple(onPress: () => loginApple(context, lang)),
              ),
          if (ParseEngine.enabledGoogleLogin)
            _decorator(
              theme,
              SocialButtons.google(onPress: () => loginGoogle(context, lang)),
            ),
          if (ParseEngine.enabledFacebookLogin)
            _decorator(
              theme,
              SocialButtons.facebook(
                onPress: () => loginFacebook(context, lang),
              ),
            ),
          if (ParseEngine.enableOTPLogin)
            _decorator(
              theme,
              IconButton(
                onPressed: () => _openOtpLoginModal(context),
                icon: const Icon(EvaIcons.messageCircle, size: 35),
              ),
            ),
        ],
      ),
    );
  }

  void loginApple(BuildContext context, S lang) {
    // Create a loading notification
    final notification = LoginStatusNotifier.loading(
      title: lang.processing,
      message: lang.requestProcessingMessage,
    );
    AuthController.loginApple().listen((event) {
      if (event.type == NetworkEventStatusType.Loading) {
        notification.show(context);
      }

      if (event.type == NetworkEventStatusType.Failed) {
        // Important to dismiss the notification modal route
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}
        final error = event.response;
        LoginStatusNotifier.error(
          context: context,
          title: '${lang.login} ${lang.failed}',
          message: error,
        );
      }

      if (event.type == NetworkEventStatusType.Successful) {
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}

        if (onSuccess != null) {
          onSuccess!();
        } else {
          AuthController.navigateToTabbar();
        }
      }
    }).onError((e, s) {
      // Important to dismiss the notification modal route
      try {
        if (notification.isShowing() || notification.isAppearing()) {
          notification.dismiss();
        }
      } catch (_) {}
      final error = Utils.renderException(e);
      LoginStatusNotifier.error(
        context: context,
        title: '${lang.login} ${lang.failed}',
        message: error,
      );
      Dev.error('Login Apple', error: e);
    });
  }

  void loginGoogle(BuildContext context, S lang) {
    // Create a loading notification
    final notification = LoginStatusNotifier.loading(
      title: lang.processing,
      message: lang.requestProcessingMessage,
    );
    AuthController.loginGoogle().listen((event) {
      if (event.type == NetworkEventStatusType.Loading) {
        notification.show(context);
      }

      if (event.type == NetworkEventStatusType.Failed) {
        // Important to dismiss the notification modal route
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}
        final error = event.response;
        LoginStatusNotifier.error(
          context: context,
          title: '${lang.login} ${lang.failed}',
          message: error,
        );
      }

      if (event.type == NetworkEventStatusType.Successful) {
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}

        if (onSuccess != null) {
          onSuccess!();
        } else {
          AuthController.navigateToTabbar();
        }
      }
    }).onError((e, s) {
      // Important to dismiss the notification modal route
      try {
        if (notification.isShowing() || notification.isAppearing()) {
          notification.dismiss();
        }
      } catch (_) {}
      final error = Utils.renderException(e);
      LoginStatusNotifier.error(
        context: context,
        title: '${lang.login} ${lang.failed}',
        message: error,
      );
      Dev.error('Login Google', error: e);
    });
  }

  void loginFacebook(BuildContext context, S lang) {
    // Create a loading notification
    final notification = LoginStatusNotifier.loading(
      title: lang.processing,
      message: lang.requestProcessingMessage,
    );
    AuthController.loginFacebook().listen((event) {
      if (event.type == NetworkEventStatusType.Loading) {
        notification.show(context);
      }

      if (event.type == NetworkEventStatusType.Failed) {
        // Important to dismiss the notification modal route
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}
        final error = event.response ?? '';
        LoginStatusNotifier.error(
          context: context,
          title: '${lang.login} ${lang.failed}',
          message: error,
        );
      }

      if (event.type == NetworkEventStatusType.Successful) {
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}

        if (onSuccess != null) {
          onSuccess!();
        } else {
          AuthController.navigateToTabbar();
        }
      }
    }).onError((e, s) {
      // Important to dismiss the notification modal route
      try {
        if (notification.isShowing() || notification.isAppearing()) {
          notification.dismiss();
        }
      } catch (_) {}
      final error = Utils.renderException(e);
      LoginStatusNotifier.error(
        context: context,
        title: '${lang.login} ${lang.failed}',
        message: error,
      );
      Dev.error('Login Facebook', error: e);
    });
  }

  void loginPhone({
    required BuildContext context,
    required S lang,
    required String phone,
    required String phoneNumber,
    String? countryCode,
  }) {
    // Create a loading notification
    final notification = LoginStatusNotifier.loading(
      title: lang.processing,
      message: lang.requestProcessingMessage,
    );

    AuthController.loginPhone(
      phone: phone,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
    ).listen((event) {
      if (event.type == NetworkEventStatusType.Loading) {
        notification.show(context);
      }

      if (event.type == NetworkEventStatusType.Failed) {
        // Important to dismiss the notification modal route
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}
        final error = event.response ?? '';
        LoginStatusNotifier.error(
          context: context,
          title: '${lang.login} ${lang.failed}',
          message: error,
        );
      }

      if (event.type == NetworkEventStatusType.Successful) {
        try {
          if (notification.isShowing() || notification.isAppearing()) {
            notification.dismiss();
          }
        } catch (_) {}

        if (onSuccess != null) {
          onSuccess!();
        } else {
          AuthController.navigateToTabbar();
        }
      }
    }).onError((e, s) {
      // Important to dismiss the notification modal route
      try {
        if (notification.isShowing() || notification.isAppearing()) {
          notification.dismiss();
        }
      } catch (_) {}
      final error = Utils.renderException(e);
      LoginStatusNotifier.error(
        context: context,
        title: '${lang.login} ${lang.failed}',
        message: error,
      );
      Dev.error('Login Phone', error: e, stackTrace: s);
    });
  }

  Widget _decorator(ThemeData theme, Widget child) {
    return Container(
      height: 80,
      width: 80,
      padding: ThemeGuide.padding16,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius16,
      ),
      child: Center(child: child),
    );
  }

  void _openOtpLoginModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return OtpLoginScreen(onSuccess: (phoneInfo) async {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          // Start the login through WooStore Pro API
          loginPhone(
            context: context,
            lang: S.of(context),
            phone: phoneInfo.phone,
            phoneNumber: phoneInfo.phoneNumber,
            countryCode: phoneInfo.countryCode,
          );
        });
      },
    );
  }
}

abstract class LoginStatusNotifier {
  // Returns a loading flush bar
  static Flushbar loading({
    required String title,
    required String message,
  }) {
    return Flushbar(
      showProgressIndicator: true,
      title: title,
      message: message,
      isDismissible: false,
      blockBackgroundInteraction: true,
      routeBlur: 4.0,
      backgroundColor: Colors.black45.withAlpha(150),
      borderRadius: ThemeGuide.borderRadius10,
      margin: ThemeGuide.padding16,
    );
  }

  // Returns a loading flush bar
  static void custom({
    required BuildContext context,
    String? title,
    String? message,
  }) {
    Flushbar(
      title: title ?? '',
      message: message ?? '',
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 10),
      blockBackgroundInteraction: true,
      routeBlur: 4.0,
      backgroundColor: Colors.blue.withAlpha(150),
      borderRadius: ThemeGuide.borderRadius10,
      margin: ThemeGuide.padding10,
    ).show(context);
  }

  // Returns a loading flush bar
  static void error({
    required BuildContext context,
    String? title,
    String? message,
  }) {
    Flushbar(
      title: title ?? S.of(context).error,
      message: message ?? S.of(context).somethingWentWrong,
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      blockBackgroundInteraction: true,
      routeBlur: 4.0,
      backgroundColor: Colors.red.withAlpha(100),
      borderRadius: ThemeGuide.borderRadius10,
      margin: ThemeGuide.padding16,
    ).show(context);
  }
}
