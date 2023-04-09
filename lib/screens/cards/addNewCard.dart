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

import '../../enums/enumStrings.dart';
import '../../enums/enums.dart';
import '../../generated/l10n.dart';
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../shared/widgets/textInput/label.dart';
import '../../themes/themeGuide.dart';
import '../../utils/validator.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.addNewCard),
      ),
      body: const SafeArea(
        top: true,
        child: _AddNewCardForm(),
      ),
    );
  }
}

class _AddNewCardForm extends StatefulWidget {
  const _AddNewCardForm({
    Key key,
  }) : super(key: key);

  @override
  __AddNewCardFormState createState() => __AddNewCardFormState();
}

class __AddNewCardFormState extends State<_AddNewCardForm> {
  final GlobalKey<FormBuilderState> _fKey = GlobalKey<FormBuilderState>();

  String cardNumber = '';
  String cardHolderName = '';
  String expMonth = '';
  String expYear = '';
  String bankName = '';
  CardType cardType = CardType.VISA;

  bool isLoading = false;
  String errorText = '';

  final List<DropdownMenuItem> _cardTypeList = [
    DropdownMenuItem<CardType>(
      child: Text(ConvertEnum.cardTypeToString(CardType.MASTER)),
      value: CardType.MASTER,
    ),
    DropdownMenuItem<CardType>(
        child: Text(ConvertEnum.cardTypeToString(CardType.VISA)),
        value: CardType.VISA),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return FormBuilder(
      key: _fKey,
      child: ListView(
        padding: ThemeGuide.padding16,
        children: <Widget>[
          TextInputLabel(label: lang.cardNumber),
          FormBuilderTextField(
            maxLines: 1,
            name: lang.cardNumber,
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.creditCard(),
            ]),
            decoration: InputDecoration(
              hintText: lang.cardNumberPlaceholder, // Add a mask formatter
            ),
          ),
          const SizedBox(height: 16),
          TextInputLabel(label: lang.cardBankName),
          FormBuilderTextField(
            maxLines: 1,
            name: lang.cardBankName,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.maxLength(150),
            ]),
            decoration: InputDecoration(hintText: lang.cardBankNamePlaceholder),
          ),
          const SizedBox(height: 16),
          TextInputLabel(label: lang.cardExpMonth),
          FormBuilderTextField(
            maxLines: 1,
            name: lang.cardExpMonth,
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
              FormBuilderValidators.maxLength(2),
              Validator.creditCardExpMonth(),
            ]),
            decoration: InputDecoration(
              hintText: lang.cardExpMonthPlaceholder,
            ),
          ),
          const SizedBox(height: 16),
          TextInputLabel(label: lang.cardExpYear),
          FormBuilderTextField(
            maxLines: 1,
            name: lang.cardExpYear,
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
              FormBuilderValidators.maxLength(4),
              FormBuilderValidators.minLength(4),
              Validator.creditCardExpYear(),
            ]),
            decoration: InputDecoration(
              hintText: lang.cardExpYearPlaceholder,
            ),
          ),
          const SizedBox(height: 16),
          TextInputLabel(label: lang.cardHolderName),
          FormBuilderTextField(
            maxLines: 1,
            name: lang.cardHolderName,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.maxLength(150),
            ]),
            decoration: InputDecoration(
              hintText: lang.cardHolderNamePlaceholder,
            ),
          ),
          const SizedBox(height: 16),
          TextInputLabel(label: lang.cardType),
          FormBuilderDropdown(
            name: lang.cardType,
            items: _cardTypeList,
            onChanged: (value) => cardType = value,
            validator: FormBuilderValidators.required(),
          ),
          ShowError(text: errorText),
          Submit(
            isLoading: isLoading,
            label: lang.save,
            onPress: submit,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Future<void> submit() async {
    if (_fKey.currentState.saveAndValidate()) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });
    }
  }
}
