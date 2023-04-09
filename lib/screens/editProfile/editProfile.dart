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

// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../providers/userProvider.dart';
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../shared/widgets/textInput/label.dart';
import '../../shared/widgets/textInput/phone_number_text_input.dart';
import '../../themes/themeGuide.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.editProfile),
      ),
      body: const SingleChildScrollView(
        child: _EditProfileForm(),
      ),
    );
  }
}

// ignore: unused_element
class _EditProfileForm extends StatelessWidget {
  const _EditProfileForm({Key key}) : super(key: key);
  static final GlobalKey<FormBuilderState> _fKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Padding(
      padding: ThemeGuide.padding16,
      child: FormBuilder(
        key: _fKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextInputLabel(label: lang.firstName),
            Selector<UserProvider, String>(
              selector: (context, d) => d.user.wooCustomer.firstName,
              builder: (context, firstName, _) {
                return FormBuilderTextField(
                  name: lang.firstName,
                  initialValue: firstName,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.perm_identity),
                  ),
                  onChanged: (value) {
                    LocatorService.userProvider().updateFirstName(value);
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(60),
                  ]),
                );
              },
            ),
            const SizedBox(height: 20),
            TextInputLabel(label: lang.lastName),
            Selector<UserProvider, String>(
              selector: (context, d) => d.user.wooCustomer.lastName,
              builder: (context, lastName, _) {
                return FormBuilderTextField(
                  name: lang.lastName,
                  initialValue: lastName,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.perm_identity),
                  ),
                  onChanged: (value) {
                    LocatorService.userProvider().updateLastName(value);
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(60),
                  ]),
                );
              },
            ),
            const SizedBox(height: 20),
            TextInputLabel(label: lang.emailLabel),
            Selector<UserProvider, String>(
              selector: (context, d) => d.user.email,
              builder: (context, email, _) {
                return FormBuilderTextField(
                  name: lang.emailLabel,
                  initialValue: email,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  onChanged: (value) {
                    LocatorService.userProvider().updateEmail(value);
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(60),
                    FormBuilderValidators.email(),
                  ]),
                );
              },
            ),
            const SizedBox(height: 20),
            TextInputLabel(label: lang.phone),
            Selector<UserProvider, String>(
              selector: (context, d) => d.user.phone,
              builder: (context, phone, _) {
                return PhoneNumberTextField(
                  initialValue: phone,
                  onChange: (value) {
                    LocatorService.userProvider().updatePhone(value);
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(),
                  ]),
                );
              },
            ),
            Selector<UserProvider, String>(
              selector: (context, d) => d.errorMessage,
              builder: (context, value, _) {
                if (value == null || value.isEmpty) {
                  return const SizedBox(height: 30);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        value ?? lang.somethingWentWrong,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Selector<UserProvider, bool>(
              selector: (context, d) => d.isLoading,
              builder: (context, value, _) {
                return Submit(
                  isLoading: value,
                  onPress: () {
                    _submit(context);
                  },
                  label: lang.save,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_fKey.currentState.validate()) {
      LocatorService.userProvider().updatedUserData(context);
    }
  }
}
