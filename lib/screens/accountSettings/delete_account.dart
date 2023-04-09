// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:am_common_packages/am_common_packages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quiver/strings.dart';

import '../../constants/wooConfig.dart';
import '../../controllers/authController.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${lang.delete} ${lang.account}'),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool isLoading = false;
  bool checkboxSelected = false;
  String? email = '';
  String? password;
  String? errorMessage;

  final GlobalKey<FormBuilderState> fKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    email = LocatorService.userProvider().user.email;
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (isNotBlank(email))
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                    'You are about to delete all the account related data including the posts, saved addresses, email, name, etc linked to'),
                const SizedBox(height: 10),
                Text(
                  email!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        CheckboxListTile(
          value: checkboxSelected,
          title: const Text('I understand'),
          onChanged: (val) => setState(() {
            checkboxSelected = val ?? false;
          }),
        ),
        FormBuilder(
          key: fKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'email',
                  initialValue: email,
                  enabled: isBlank(email) && checkboxSelected,
                  onChanged: (val) => email = val,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(labelText: lang.emailLabel),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'password',
                  initialValue: password,
                  enabled: checkboxSelected,
                  obscureText: true,
                  onChanged: (val) => password = val,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(labelText: lang.passwordLabel),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ],
            ),
          ),
        ),
        if (isNotBlank(errorMessage))
          Container(
            padding: ThemeGuide.padding16,
            margin: ThemeGuide.marginH10,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0x20EF5350),
              borderRadius: ThemeGuide.borderRadius10,
            ),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        const SizedBox(height: 10),
        Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: checkboxSelected ? onSubmit : null,
                  child: Text('${lang.delete} ${lang.account}'),
                ),
        ),
      ],
    );
  }

  Future<void> onSubmit() async {
    if (fKey.currentState!.validate()) {
      try {
        FocusScope.of(context).unfocus();
        if (mounted) {
          setState(() {
            isLoading = true;
            errorMessage = null;
          });
        }

        final result = await Dio().post(
          '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api/flutter_user/delete_user',
          data: {
            'email': email,
            'password': password,
          },
        );

        Dev.info(result.data);
        if (result.statusCode == 200) {
          // render success
          if (result.data != null &&
              result.data is Map &&
              (result.data as Map).containsKey('success') &&
              (result.data['success'] as bool) == true) {
            // perform success functions
            AuthController.logout();
            return;
          }
        }

        // if result is not a success, then render error
        throw DioError(
          requestOptions: RequestOptions(
            path:
                '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api/flutter_user/delete_account',
            method: 'POST',
            data: {
              'email': email,
              'password': password,
            },
          ),
          response: result,
        );
      } catch (e, s) {
        if (e is DioError) {
          if (e.response?.data != null) {
            if (e.response!.data! is Map &&
                (e.response!.data as Map).containsKey('message')) {
              errorMessage = e.response!.data['message'];
              Dev.error(
                'Delete account onSubmit error',
                error: e.response!.data,
                stackTrace: s,
              );
            }
          } else {
            Dev.error('Delete account onSubmit error',
                error: e.response, stackTrace: s);
            errorMessage =
                e.response?.statusMessage ?? S.of(context).somethingWentWrong;
          }
        } else {
          Dev.error('Delete account onSubmit error', error: e, stackTrace: s);
          errorMessage = ExceptionUtils.renderException(e);
        }

        isLoading = false;
        if (mounted) {
          setState(() {});
        }
      }
    }
  }
}
