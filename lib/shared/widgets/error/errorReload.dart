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

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../generated/l10n.dart';
import '../../../themes/theme.dart';
import '../../animatedButton.dart';
import '../../customButtonStyle.dart';

class ErrorReload extends StatelessWidget {
  const ErrorReload({
    Key? key,
    required this.errorMessage,
    required this.reloadFunction,
  }) : super(key: key);

  final String errorMessage;
  final void Function() reloadFunction;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return LimitedBox(
      maxHeight: 100,
      maxWidth: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                isBlank(errorMessage) ? lang.somethingWentWrong : errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.errorText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              AnimButton(
                child: CustomButtonStyle(
                  color: Theme.of(context).disabledColor.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(lang.reload),
                  ),
                ),
                onTap: reloadFunction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorReloadWithIcon extends StatelessWidget {
  const ErrorReloadWithIcon({
    Key? key,
    required this.errorMessage,
    required this.reloadFunction,
  }) : super(key: key);

  final String errorMessage;
  final void Function() reloadFunction;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return LimitedBox(
      maxHeight: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Flexible(
            child: FittedBox(
              child: Icon(
                Icons.error_outline_rounded,
                size: 100,
                color: Color(0xFFEF5350),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              isBlank(errorMessage) ? lang.somethingWentWrong : errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.errorText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          AnimButton(
            child: CustomButtonStyle(
              color: Theme.of(context).disabledColor.withAlpha(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(lang.reload),
              ),
            ),
            onTap: reloadFunction,
          ),
        ],
      ),
    );
  }
}
