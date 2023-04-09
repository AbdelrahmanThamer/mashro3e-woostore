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
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/payment_gateway.dart';

import '../../../../controllers/uiController.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/customLoader.dart';
import '../../../../shared/widgets/error/errorReload.dart';
import '../../../../shared/widgets/error/noDataAvailable.dart';
import '../../../../themes/theme.dart';
import '../viewModel/checkout_native_view_model.dart';
import 'bottomButtons.dart';
import 'headline.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
          ),
          child: Headline(title: lang.payment + ' ' + lang.options),
        ),
        const Divider(
          endIndent: 20,
          indent: 20,
          height: 30,
          thickness: 2.5,
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _Body(),
          ),
        ),
        BottomButtons(
          next: () {
            final provider =
                Provider.of<CheckoutNativeViewModel>(context, listen: false);
            if (provider.selectedPaymentGateway == null ||
                isBlank(provider.selectedPaymentGateway.id) ||
                isBlank(provider.selectedPaymentGateway.methodTitle)) {
              final lang = S.of(context);
              UiController.showErrorNotification(
                context: context,
                title:
                    '${lang.no} ${lang.payment} ${lang.method} ${lang.selected}',
                message: lang.somethingWentWrong,
              );
              return;
            }
            provider.next();
          },
          back: () {
            Provider.of<CheckoutNativeViewModel>(context, listen: false).back();
          },
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CheckoutNativeViewModel>(context, listen: false);
    if (provider.paymentGateways.isEmpty) {
      return const _BodyWithState();
    } else {
      return const _ListContainer();
    }
  }
}

class _BodyWithState extends StatefulWidget {
  const _BodyWithState({Key key}) : super(key: key);

  @override
  _BodyWithStateState createState() => _BodyWithStateState();
}

class _BodyWithStateState extends State<_BodyWithState> {
  @override
  void initState() {
    super.initState();

    final provider =
        Provider.of<CheckoutNativeViewModel>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      provider.fetchPaymentGateways();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutNativeViewModel>(
      builder: (context, p, w) {
        if (p.paymentGateways.isNotEmpty) {
          return const _ListContainer();
        }

        if (p.isPaymentInfoLoading) {
          return const CustomLoader();
        }

        if (p.isPaymentInfoError) {
          return ErrorReload(
            errorMessage: p.errorPaymentInfoMessage,
            reloadFunction: () {
              p.fetchPaymentGateways();
            },
          );
        }

        return const NoDataAvailableImage();
      },
    );
  }
}

class _ListContainer extends StatelessWidget {
  const _ListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CheckoutNativeViewModel>(context);
    return ListView.builder(
      itemCount: provider.paymentGateways.length,
      itemBuilder: (context, i) {
        return PaymentMethodTile(
          paymentGateway: provider.paymentGateways[i],
        );
      },
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    Key key,
    this.paymentGateway,
  }) : super(key: key);

  final WooPaymentGateway paymentGateway;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Selector<CheckoutNativeViewModel, WooPaymentGateway>(
      selector: (context, d) => d.selectedPaymentGateway,
      shouldRebuild: (a, b) => a.id != b.id,
      builder: (context, gateway, w) {
        final isSelected = paymentGateway.id == gateway?.id;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn,
          padding: isSelected
              ? const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                )
              : const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: _theme.colorScheme.background,
            borderRadius: ThemeGuide.borderRadius10,
          ),
          child: CheckboxListTile(
            shape: const CircleBorder(),
            value: isSelected,
            onChanged: (val) {
              Provider.of<CheckoutNativeViewModel>(context, listen: false)
                  .selectPaymentGateway(paymentGateway);
            },
            title: Text(
              paymentGateway.title ?? 'NA',
              style: isSelected
                  ? const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )
                  : const TextStyle(),
            ),
          ),
        );
      },
    );
  }
}
