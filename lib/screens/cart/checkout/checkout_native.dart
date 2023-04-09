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
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import 'viewModel/checkout_native_view_model.dart';
import 'widgets/chooseShippingAddress.dart';
import 'widgets/choose_billing_address.dart';
import 'widgets/reviewDetails.dart';
import 'widgets/shipping_methods.dart';

class CheckoutNativeScreen extends StatelessWidget {
  const CheckoutNativeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.checkout),
      ),
      body: ChangeNotifierProvider<CheckoutNativeViewModel>(
        create: (context) => CheckoutNativeViewModel(),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cnp = Provider.of<CheckoutNativeViewModel>(context, listen: false);
    return PageView(
      controller: cnp.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        ChooseBillingAddress(),
        ChooseShippingAddress(),
        ShippingMethods(),
        // PaymentMethods(),
        ReviewDetails(),
      ],
    );
  }
}
