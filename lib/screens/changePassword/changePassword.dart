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
import 'package:woocommerce/woocommerce.dart';

import '../../controllers/uiController.dart';
import '../../developer/dev.log.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../shared/widgets/textInput/label.dart';
import '../../themes/theme.dart';
import '../../utils/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormBuilderState> _fKey = GlobalKey<FormBuilderState>();

  bool isLoading = false;
  String errorText = '';

  String newPassword, oldPassword = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.change + ' ' + lang.passwordLabel),
      ),
      body: Padding(
        padding: ThemeGuide.padding20,
        child: FormBuilder(
          key: _fKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: TextInputLabel(label: lang.oldPassword),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: lang.oldPassword,
                onChanged: (val) => oldPassword = val,
                obscureText: true,
                maxLines: 1,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: lang.errorEmptyInput,
                  ),
                  FormBuilderValidators.minLength(6),
                  FormBuilderValidators.maxLength(40),
                ]),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: TextInputLabel(label: lang.newPassword),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: lang.newPassword,
                onChanged: (val) => newPassword = val,
                obscureText: true,
                maxLines: 1,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: lang.errorEmptyInput,
                  ),
                  FormBuilderValidators.minLength(6),
                  FormBuilderValidators.maxLength(40),
                ]),
              ),
              ShowError(text: errorText),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: Submit(
                  isLoading: isLoading,
                  onPress: _save,
                  label: lang.save,
                ),
              ),
              // if (errorText != null && errorText.isNotEmpty)
              //   const SizedBox(height: 20),
              // if (errorText != null && errorText.isNotEmpty)
              //   Text(
              //     lang.passwordResetFailedNotice,
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(
              //       fontSize: 14,
              //       color: Colors.grey,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    final lang = S.of(context);
    if (_fKey.currentState.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
          errorText = '';
        });

        await LocatorService.userProvider().updatePassword(
          newPassword: newPassword,
          oldPassword: oldPassword,
        );

        setState(() {
          isLoading = false;
          errorText = '';
        });

        UiController.showNotification(
          context: context,
          title: '${lang.passwordLabel} ${lang.updated}',
          message: lang.passwordUpdateMessage,
          color: Colors.green,
        );

        _fKey.currentState.reset();
      } catch (e, s) {
        Dev.error('_save change password', error: e, stackTrace: s);
        setState(() {
          isLoading = false;
          errorText =
              e is WooCommerceError ? e?.message : Utils.renderException(e);
        });
      }
    }
  }
}
