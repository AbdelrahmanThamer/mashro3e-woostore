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

import '../../controllers/navigationController.dart';
import '../../generated/l10n.dart';
import '../../services/storage/localStorage.dart';
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../shared/dividerWithText.dart';
import 'form/loginForm.dart';
import 'socialLogin.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    return Theme(
      data: theme.copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const HeaderImage(),
                const SizedBox(height: 20),
                HeaderText(
                  title: lang.login,
                  body: lang.loginTagLine,
                ),
                const LoginForm(),
                const SizedBox(height: 20),
                FooterQuestion(
                  buttonLabel: lang.signup,
                  questionText: lang.loginQues,
                  onPress: _goToSignup,
                ),
                const SizedBox(height: 20),
                DividerWithText(text: lang.or),
                const SizedBox(height: 20),
                const SocialLoginRow(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _goToTabbar,
                      child: Text(
                        lang.continueWithoutLogin,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _goToSignup() {
    NavigationController.navigator.push(const SignupRoute());
  }

  static void _goToTabbar() {
    LocalStorage.setInt(LocalStorageConstants.shouldContinueWithoutLogin, 1);
    NavigationController.navigator.replaceAll([const TabbarNavigationRoute()]);
  }
}
