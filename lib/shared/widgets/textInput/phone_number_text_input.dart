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

import '../../../app_builder/app_builder.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({
    Key? key,
    this.initialValue,
    required this.onChange,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.fillColor,
    this.enabled = true,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool enabled;
  final String? initialValue;
  final ValueChanged<String> onChange;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? fillColor;

  @override
  State<PhoneNumberTextField> createState() => PhoneNumberTextFieldState();
}

class PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  String flag = '';
  String dialCode = '';
  String number = '';
  String initialValue = '';

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> countryObject = kCountries.firstWhere(
      (element) => element['countryCode'] == ParseEngine.defaultCountryCode,
      orElse: () => const {},
    );
    flag = countryObject['flag'];
    dialCode = countryObject['dialCode'];

    if (isNotBlank(widget.initialValue) && widget.initialValue!.contains('-')) {
      final tempNumber = widget.initialValue!.split(r'-');
      if (tempNumber.length <= 1) {
        initialValue = tempNumber[0];
      } else {
        if (isNotBlank(tempNumber[0])) {
          dialCode = tempNumber[0];
          final tempFlag = kCountries.firstWhere(
            (element) => element['dialCode'] == tempNumber[0],
            orElse: () => const {},
          )['flag'];
          if (isNotBlank(tempFlag)) {
            flag = tempFlag!;
          }
        }
        if (isNotBlank(tempNumber[1])) {
          initialValue = tempNumber[1];
          number = tempNumber[1];
        }
      }
    }

    if (widget.controller != null) {
      widget.controller!.text = number;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Phone Number',
      initialValue: number,
      enabled: widget.enabled,
      controller: widget.controller,
      maxLines: 1,
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: false,
      ),
      onChanged: (val) {
        number = val ?? '';
        widget.onChange(_createCompleteNumber());
      },
      decoration: InputDecoration(
        hintText: '1232343456',
        prefixIcon: _buildDialCodeSelector(),
        fillColor: widget.fillColor,
      ),
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: widget.validator ??
          FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
            FormBuilderValidators.maxLength(12),
          ]),
    );
  }

  Widget _buildDialCodeSelector() {
    return InkWell(
      onTap: () {
        final size = MediaQuery.of(context).size;
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: ThemeGuide.borderRadius10,
              ),
              child: SizedBox(
                height: size.height / 2,
                width: size.width / 3 > 350 ? size.width / 3 : 350,
                child: ListView.builder(
                  padding: ThemeGuide.listPadding,
                  itemCount: kCountries.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                        setState(() {
                          flag = kCountries[i]['flag']!;
                          dialCode = kCountries[i]['dialCode']!;
                        });

                        widget.onChange(_createCompleteNumber());
                      },
                      leading: Text(
                        kCountries[i]['flag'] ?? '',
                        style: const TextStyle(fontSize: 26),
                      ),
                      title: Text(kCountries[i]['name'] ?? ''),
                      trailing: Text(kCountries[i]['dialCode'] ?? ''),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: FractionallySizedBox(
        widthFactor: 0.22,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 20),
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  dialCode,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _createCompleteNumber() {
    if (isBlank(number)) {
      return '';
    }

    return dialCode + '-' + number;
  }
}
