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

// import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../generated/l10n.dart';
import '../../models/address.model.dart';
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../shared/widgets/textInput/label.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.addNewAddress),
      ),
      body: const _AddAddressForm(),
    );
  }
}

class _AddAddressForm extends StatefulWidget {
  const _AddAddressForm({Key key}) : super(key: key);

  @override
  __AddAddressFormState createState() => __AddAddressFormState();
}

class __AddAddressFormState extends State<_AddAddressForm> {
  final GlobalKey<FormBuilderState> _fKey = GlobalKey<FormBuilderState>();

  final Address newAddress = const Address.empty();

  bool isLoading = false;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBuilder(
        key: _fKey,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 50),
          children: <Widget>[
            TextInputLabel(label: '${lang.address}1'),
            FormBuilderTextField(
              name: '${lang.address}1',
              maxLines: 1,
              onChanged: (val) => newAddress.copyWith(address1: val),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.min(2),
                FormBuilderValidators.maxLength(50),
              ]),
            ),
            const SizedBox(height: 16),
            TextInputLabel(label: '${lang.address}2'),
            FormBuilderTextField(
              name: '${lang.address}2',
              maxLines: 1,
              onChanged: (val) => newAddress.copyWith(address2: val),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.min(2),
                FormBuilderValidators.maxLength(50),
              ]),
            ),
            const SizedBox(height: 16),
            TextInputLabel(label: lang.city),
            FormBuilderTextField(
              name: lang.city,
              maxLines: 1,
              onChanged: (val) => newAddress.copyWith(city: val),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.min(2),
                FormBuilderValidators.maxLength(50),
              ]),
            ),
            const SizedBox(height: 16),
            TextInputLabel(label: lang.state),
            FormBuilderTextField(
              name: lang.state,
              maxLines: 1,
              onChanged: (val) => newAddress.copyWith(state: val),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.min(2),
                FormBuilderValidators.maxLength(50),
              ]),
            ),
            const SizedBox(height: 16),
            TextInputLabel(label: lang.postCode),
            FormBuilderTextField(
              name: lang.postCode,
              maxLines: 1,
              onChanged: (val) => newAddress.copyWith(postCode: val),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.min(2),
                FormBuilderValidators.maxLength(50),
              ]),
            ),
            const SizedBox(height: 16),
            TextInputLabel(label: lang.country),
            FormBuilderTextField(
              name: lang.country,
              maxLines: 1,
              onChanged: (val) => newAddress.copyWith(country: val),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.min(2),
                FormBuilderValidators.maxLength(50),
              ]),
            ),
            if (errorText.isNotEmpty)
              ShowError(text: errorText)
            else
              const SizedBox(height: 20),
            Submit(
              isLoading: isLoading,
              onPress: onSubmit,
              label: lang.addNewAddress,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (_fKey.currentState.saveAndValidate()) {
      setState(() {
        isLoading = true;
      });

      // Perform some actions
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLoading = false;
      });
    }
  }
}
