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
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import 'form/signupForm.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 100,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const HeaderImage(),
              const SizedBox(height: 20),
              HeaderText(
                title: lang.signup,
                body: lang.signUpTagLine,
              ),
              const SignUpForm(),
              const SizedBox(height: 20),
              FooterQuestion(
                buttonLabel: lang.login,
                questionText: lang.signUpQues,
                onPress: _goToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _goToLogin() {
    NavigationController.navigator.pop();
  }
}
