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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../themes/gradients.dart';
import '../../utils/style.dart';
import '../screens.dart';
import 'checkout/checkoutWebView.dart';
import 'checkout/checkout_native.dart';
import 'viewModel/viewModel.dart';

class CheckOutContainer extends StatelessWidget {
  const CheckOutContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Selector<CartViewModel, int>(
      selector: (context, d) => d.totalItems,
      builder: (context, totalItems, child) {
        if (totalItems > 0) {
          return child!;
        } else {
          return const SizedBox.shrink();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: _theme.colorScheme.background,
          boxShadow: UIStyle.renderShadow(
            context: context,
            light: ThemeGuide.primaryShadow,
            dark: ThemeGuide.primaryShadowDark,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            right: 20,
            left: 20,
            bottom: 10,
          ),
          child: Column(
            children: const <Widget>[
              _SmallBar(),
              SizedBox(height: 15),
              _TotalItems(),
              SizedBox(height: 15),
              _TotalAmount(),
              SizedBox(height: 15),
              _CheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutButton extends ConsumerStatefulWidget {
  const _CheckoutButton({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends ConsumerState<_CheckoutButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: ThemeGuide.padding20,
        child: LinearProgressIndicator(
          minHeight: 2,
        ),
      );
    }

    final lang = S.of(context);
    return SizedBox(
      width: double.infinity,
      child: GradientButton(
        onPress: onPress,
        child: Text(
          lang.checkout,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> onPress() async {
    try {
      if (ref.read(providerOfCartScreenLayoutData).enableNativeCheckout) {
        setState(() {
          isLoading = true;
        });
        if (await LocatorService.cartViewModel()
            .validateCartBeforeCheckout(context)) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CheckoutNativeScreen(),
            ),
          );
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        // NavigationController.navigator.push(Routes.checkoutScreen);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CheckoutWebView(),
          ),
        );
      }
    } catch (e, s) {
      Dev.error('Checkout Button on press', error: e, stackTrace: s);
      setState(() {
        isLoading = false;
      });
    }
  }
}

class _TotalAmount extends StatelessWidget {
  const _TotalAmount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    return ValueListenableBuilder<WooCoupon>(
      valueListenable: LocatorService.cartViewModel().selectedCoupon,
      builder: (context, selectedCoupon, w) {
        if (selectedCoupon.id != null &&
            selectedCoupon.id! > 0 &&
            isNotBlank(selectedCoupon.amount)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${lang.sub} ${lang.total}',
                    style: _theme.textTheme.subtitle2,
                  ),
                  Selector<CartViewModel, String>(
                    selector: (context, d) => d.subTotal,
                    builder: (context, value, _) {
                      return Text(
                        '${ParseEngine.currencySymbol} $value',
                        style: _theme.textTheme.subtitle2,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    lang.coupon,
                    style: _theme.textTheme.subtitle2,
                  ),
                  Selector<CartViewModel, String>(
                    selector: (context, d) => d.discountString,
                    builder: (context, value, _) {
                      return Text(
                        '- ${ParseEngine.currencySymbol} $value',
                        style: _theme.textTheme.subtitle2,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              w!,
            ],
          );
        }
        return w!;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            lang.totalAmount,
            style: _theme.textTheme.subtitle2,
          ),
          Selector<CartViewModel, String>(
            selector: (context, d) => d.totalCost,
            builder: (context, totalCost, _) {
              return Text(
                '${ParseEngine.currencySymbol} $totalCost',
                style: _theme.textTheme.subtitle2,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TotalItems extends StatelessWidget {
  const _TotalItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    return Selector<CartViewModel, int>(
      selector: (context, d) => d.totalItems,
      builder: (context, totalItems, _) {
        return Text(
          '${lang.cartMessagePart1} $totalItems ${lang.cartMessagePart2}',
          style: _theme.textTheme.caption,
        );
      },
    );
  }
}

class _SmallBar extends StatelessWidget {
  const _SmallBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: ThemeGuide.borderRadius,
        gradient: AppGradients.linearGradient(context),
      ),
    );
  }
}
