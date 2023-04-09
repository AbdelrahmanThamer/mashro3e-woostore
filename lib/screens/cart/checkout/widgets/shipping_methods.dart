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
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../../controllers/uiController.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/customLoader.dart';
import '../../../../shared/widgets/error/errorReload.dart';
import '../../../../shared/widgets/error/noDataAvailable.dart';
import '../../../../themes/theme.dart';
import '../viewModel/checkout_native_view_model.dart';
import 'bottomButtons.dart';
import 'headline.dart';

class ShippingMethods extends StatelessWidget {
  const ShippingMethods({
    Key? key,
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
          child: Headline(title: lang.shippingOption),
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
            if (provider.shippingMethod == null ||
                isBlank(provider.shippingMethod.methodId) ||
                isBlank(provider.shippingMethod.methodTitle)) {
              final lang = S.of(context);
              UiController.showErrorNotification(
                context: context,
                title: '${lang.no} ${lang.shippingOption} ${lang.selected}',
                message: lang.somethingWentWrong,
              );
              return;
            }
            provider.next();
          },
          back:
              Provider.of<CheckoutNativeViewModel>(context, listen: false).back,
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BodyWithState();
    // final provider =
    //     Provider.of<CheckoutNativeViewModel>(context, listen: false);
    // if (provider.shippingMethods.isEmpty) {
    //   return const _BodyWithState();
    // } else {
    //   return const _ListContainer();
    // }
  }
}

class _BodyWithState extends StatefulWidget {
  const _BodyWithState({Key? key}) : super(key: key);

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
      provider.fetchShippingMethods(
        provider.createShippingMethodRequestPackage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutNativeViewModel>(
      builder: (context, p, w) {
        if (p.isShippingInfoLoading) {
          return const CustomLoader();
        }

        if (p.shippingMethods.isNotEmpty) {
          return const _ListContainer();
        }

        if (p.isShippingInfoError) {
          return ErrorReload(
            errorMessage: p.errorShippingInfoMessage,
            reloadFunction: () {
              p.fetchShippingMethods(
                p.createShippingMethodRequestPackage(),
              );
            },
          );
        }

        return const NoDataAvailableImage();
      },
    );
  }
}

class _ListContainer extends StatelessWidget {
  const _ListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CheckoutNativeViewModel>(context);
    return ListView.builder(
      itemCount: provider.shippingMethods.length,
      itemBuilder: (context, i) {
        return ShippingMethodTile(
          shippingMethod: provider.shippingMethods[i],
        );
      },
    );
  }
}

class ShippingMethodTile extends StatelessWidget {
  const ShippingMethodTile({
    Key? key,
    required this.shippingMethod,
  }) : super(key: key);

  final WPIShippingMethod shippingMethod;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Selector<CheckoutNativeViewModel, WPIShippingMethod>(
      selector: (context, d) => d.shippingMethod,
      shouldRebuild: (a, b) => a.instanceId != b.instanceId,
      builder: (context, method, w) {
        final isSelected = shippingMethod.instanceId == method.instanceId;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn,
          padding:
              isSelected ? const EdgeInsets.all(10) : const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: _theme.colorScheme.background,
            borderRadius: ThemeGuide.borderRadius,
          ),
          child: CheckboxListTile(
            value: isSelected,
            onChanged: (val) {
              Provider.of<CheckoutNativeViewModel>(context, listen: false)
                  .setShippingMethod(shippingMethod);
            },
            title: Text(
              shippingMethod.methodTitle ?? 'NA',
              style: isSelected
                  ? const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    )
                  : const TextStyle(),
            ),
            subtitle: Text(
              shippingMethod.cost ?? 'NA',
              style: isSelected
                  ? const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )
                  : const TextStyle(),
            ),
          ),
        );
      },
    );
  }
}
