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
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/wooConfig.dart';
import '../../../controllers/authController.dart';
import '../../../developer/dev.log.dart';
import '../../../generated/l10n.dart';
import '../../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../../themes/themeGuide.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  String? email;
  String? password;
  bool _isLoading = false;
  String errorText = '';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  ///
  /// ## Description
  ///
  /// Triggers methods to handle:
  ///
  /// - Form validation
  /// - Firebase Authentication
  ///
  /// ### Functional Flow:
  ///
  /// 1. Show the loading indicator
  /// 2. Start authenticating service
  ///
  /// `Note`: Always wrap an authentication request in a try-catch block
  ///
  Future<void> buttonFun() async {
    if (_formKey.currentState!.validate()) {
      // Start the indicator
      setState(() => _isLoading = !_isLoading);

      // Authenticate
      try {
        // Enter your login logic here or call to a login function from a
        // service
        final result = await AuthController.login(email!, password!);
        // log('${result.uid}', name: 'Login user uid');

        // If userId is not empty then set the userId in the provider
        if (result?.id != null) {
          // Navigate to tabbar
          AuthController.navigateToTabbar();
          return;
        }

        errorText = '';
      } on FormatException catch (e, s) {
        errorText = S.of(context).somethingWentWrong;
        Dev.error('Login Error Format Exception', error: e, stackTrace: s);
      } on PlatformException catch (e, s) {
        errorText = e.message.toString().replaceFirst('Exception: ', '');
        Dev.error('Login Error Platform Exception', error: e, stackTrace: s);
      } catch (e, s) {
        errorText = e.toString().replaceFirst('Exception: ', '');
        Dev.error('Login Error', error: e, stackTrace: s);
      }

      // Stop the indicator
      setState(() => _isLoading = !_isLoading);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final ThemeData _theme = Theme.of(context);
    return Container(
      padding: ThemeGuide.padding20,
      margin: ThemeGuide.padding16,
      decoration: BoxDecoration(
        color: _theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius16,
      ),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: <Widget>[
            FormBuilderTextField(
              name: lang.emailLabel,
              onChanged: (val) => email = val,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: lang.emailLabel,
                fillColor: _theme.scaffoldBackgroundColor,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: lang.errorEmptyInput,
                ),
                FormBuilderValidators.maxLength(50),
                FormBuilderValidators.email(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: lang.passwordLabel,
              obscureText: true,
              maxLines: 1,
              onChanged: (val) => password = val,
              decoration: InputDecoration(
                hintText: lang.passwordLabel,
                fillColor: _theme.scaffoldBackgroundColor,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: lang.errorEmptyInput,
                ),
                FormBuilderValidators.maxLength(40),
                AuthController.validatePassword,
              ]),
            ),
            const SizedBox(height: 20),
            Submit(
              onPress: buttonFun,
              isLoading: _isLoading,
              label: lang.login,
            ),
            ShowError(text: errorText),
            const ForgotPassword(),
          ],
        ),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  Future<void> _launchURL() async {
    const url = '${WooConfig.wordPressUrl}/my-account/lost-password/';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _launchURL,
      child: Text(S.of(context).forgotPassword),
    );
  }
}
