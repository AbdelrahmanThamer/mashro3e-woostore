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

import '../../../../controllers/navigationController.dart';
import '../../../../generated/l10n.dart';
import '../../../app_builder/app_builder.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const _PaymentIcon.successful(),
          const SizedBox(height: 10),
          Text(
            lang.paymentSuccessful,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            lang.paymentSuccessfulMessage,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: ThemeGuide.padding20,
            child: SizedBox(
              width: double.infinity,
              child: GradientButton(
                child: Text(
                  lang.continueShopping,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPress: _goToHome,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void _goToHome() {
    NavigationController.navigator
        .popUntilRouteWithName(TabbarNavigationRoute.name);
    ParseEngine.changeTab();
  }
}

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const _PaymentIcon.failed(),
          const SizedBox(height: 10),
          Text(
            lang.paymentFailed,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            lang.paymentFailedMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PaymentIcon extends StatelessWidget {
  const _PaymentIcon.successful({
    Key? key,
  })  : icon = Icons.check,
        color = Colors.green,
        super(key: key);

  const _PaymentIcon.failed({
    Key? key,
  })  : icon = Icons.close,
        color = Colors.red,
        super(key: key);

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ThemeGuide.padding20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
