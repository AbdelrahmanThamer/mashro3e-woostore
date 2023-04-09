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
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../app_builder/app_builder.dart';
import '../../../constants/config.dart';
import '../../../controllers/authController.dart';
import '../../../generated/l10n.dart';
import '../../../services/verify_otp/verify_otp.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../../shared/widgets/textInput/phone_number_text_input.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? email,
      firstName,
      lastName,
      username,
      password,
      confirmPassword,
      phone;
  bool _isLoading = false;
  String errorText = '';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  /// If the phone value is added then check if the
  /// phone number is verified or not
  bool isPhoneVerified = false;

  Future<bool> verifyPhone() async {
    try {
      final result = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return VerifyOtpScreen(
              phone: phone!,
              onSuccess: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop(true);
                }

                // on success change the isPhoneVerified flag to true
                isPhoneVerified = true;
              });
        },
      );
      if (result == null) {
        return false;
      } else {
        return true;
      }
    } catch (e, s) {
      Dev.error('Verify phone from signup error', error: e, stackTrace: s);
      setState(() {
        _isLoading = false;
        errorText = ExceptionUtils.renderException(e);
      });
      return false;
    }
  }

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
  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      // Authenticate
      try {
        // if phone is verified then move forward else
        // first verify the phone
        if (isNotBlank(phone)) {
          if (!isPhoneVerified) {
            // verify the phone
            if (!(await verifyPhone())) {
              throw Exception('Cannot verify phone number');
            }
          }
        }

        // Start the indicator
        setState(() {
          _isLoading = true;
          errorText = '';
        });

        // If the digits plugin support is enabled
        // then add the extra data to send to the backend
        // for verification
        final _extraData = <String, dynamic>{};

        if (kEnableDigitsPluginSupport) {
          if (phone != null) {
            if (phone!.contains('-')) {
              final tempArr = phone!.split('-');
              _extraData.addAll({'country_code': tempArr[0]});
              _extraData.addAll({'phone_number': tempArr[1]});
            } else {
              _extraData.addAll({'phone_number': phone!});
            }
          }
          _extraData.addAll({'use_digits_plugin': true});
        }

        final WooCustomer? result = await AuthController.signUp(
          email: email,
          password: password,
          username: username,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          extraData: _extraData,
        );

        if (result == null) {
          errorText = S.of(context).failedSignUp;
        }

        if (result!.id != null) {
          // Navigate to tab bar
          AuthController.navigateToTabbar();
          return;
        }

        // Change the error text
        errorText = '';
      } on FormatException catch (e, s) {
        errorText = S.of(context).somethingWentWrong;
        Dev.error('Login Error Format Exception', error: e, stackTrace: s);
      } on PlatformException catch (e, s) {
        if (e.toString().contains('Exception:')) {
          errorText = e.toString().split('Exception:')[1];
        } else {
          errorText = e.toString();
        }
        Dev.error('Platform Exception sign up', error: e, stackTrace: s);
      } catch (e, s) {
        Dev.error('Error sign up', error: e, stackTrace: s);
        if (e.toString().contains('Exception:')) {
          errorText = e.toString().split('Exception:')[1];
        } else {
          errorText = e.toString();
        }
      } finally {
        // Stop the indicator
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    return Container(
      padding: ThemeGuide.padding16,
      margin: ThemeGuide.padding20,
      decoration: BoxDecoration(
        color: _theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius16,
      ),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: <Widget>[
            FormBuilderTextField(
              name: lang.firstName,
              maxLines: 1,
              onChanged: (val) => firstName = val,
              decoration: InputDecoration(
                hintText: lang.firstName,
                fillColor: _theme.scaffoldBackgroundColor,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: lang.errorEmptyInput,
                ),
                FormBuilderValidators.maxLength(20),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: lang.lastName,
              maxLines: 1,
              onChanged: (val) => lastName = val,
              decoration: InputDecoration(
                hintText: lang.lastName,
                fillColor: _theme.scaffoldBackgroundColor,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: lang.errorEmptyInput,
                ),
                FormBuilderValidators.maxLength(20),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: lang.username,
              maxLines: 1,
              onChanged: (val) => username = val,
              decoration: InputDecoration(
                hintText: lang.username,
                fillColor: _theme.scaffoldBackgroundColor,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: lang.errorEmptyInput,
                ),
                FormBuilderValidators.maxLength(20),
              ]),
            ),
            const SizedBox(height: 10),
            PhoneNumberTextField(
              onChange: (val) {
                if (val != phone) {
                  isPhoneVerified = false;
                }
                phone = val;
              },
              fillColor: _theme.scaffoldBackgroundColor,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.numeric(),
                FormBuilderValidators.maxLength(12),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: lang.emailLabel,
              maxLines: 1,
              onChanged: (val) => email = val,
              decoration: InputDecoration(
                hintText: lang.emailLabel,
                fillColor: _theme.scaffoldBackgroundColor,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: lang.errorEmptyInput,
                ),
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
                FormBuilderValidators.minLength(6),
                FormBuilderValidators.maxLength(40),
                AuthController.validatePassword,
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: lang.confirmPasswordLabel,
              obscureText: true,
              maxLines: 1,
              onChanged: (val) => confirmPassword = val,
              decoration: InputDecoration(
                hintText: lang.confirmPasswordLabel,
                fillColor: _theme.scaffoldBackgroundColor,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: lang.errorEmptyInput,
                ),
                FormBuilderValidators.minLength(6),
                FormBuilderValidators.maxLength(40),
                (_) {
                  return AuthController.validateConfirmPassword(
                    confirmPassword!,
                    password!,
                  );
                }
              ]),
            ),
            const SizedBox(height: 20),
            Submit(
              onPress: submit,
              isLoading: _isLoading,
              label: lang.signup,
            ),
            ShowError(text: errorText),
            const FooterLinks(),
          ],
        ),
      ),
    );
  }
}

class FooterLinks extends StatelessWidget {
  const FooterLinks({Key? key}) : super(key: key);

  // Launch the terms of service URL
  Future<void> _launchURL1() async {
    if (await canLaunchUrlString(ParseEngine.termsOfServiceUrl)) {
      await launchUrlString(ParseEngine.termsOfServiceUrl);
    }
  }

  // Launch the privacy policy URL
  Future<void> _launchURL2() async {
    if (await canLaunchUrlString(ParseEngine.privacyPolicyUrl)) {
      await launchUrlString(ParseEngine.privacyPolicyUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    return DefaultTextStyle(
      style: _theme.textTheme.caption!.copyWith(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Wrap(
          runSpacing: 2,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Text(lang.tosPreText),
            GestureDetector(
              onTap: _launchURL1,
              child: Text(
                lang.termsOfService,
                style: TextStyle(color: _theme.colorScheme.primary),
              ),
            ),
            Text(' ${lang.and} '),
            GestureDetector(
              onTap: _launchURL2,
              child: Text(
                lang.privacyPolicy,
                style: TextStyle(
                  color: _theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
