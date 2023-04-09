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

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../constants/wooConfig.dart';
import '../../../../developer/dev.log.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../screens/address/addressContainers.dart';
import '../../../../screens/payment/payment.dart';
import '../../../../shared/animatedButton.dart';
import '../../../../shared/customLoader.dart';
import '../../../../shared/widgets/error/errorReload.dart';
import '../../../../shared/widgets/error/noDataAvailable.dart';
import '../../../../themes/theme.dart';
import '../../../../utils/utils.dart';
import '../../listItems/cartItem.dart';
import '../../models/cartProductModel.dart';
import '../../widgets/coupon/widgets/applied_coupon.dart';
import '../viewModel/checkout_native_view_model.dart';
import 'headline.dart';

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BodyWithState();
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
      provider.reviewDetails(
        provider.createCartDetailsPayload(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutNativeViewModel>(
      builder: (context, p, w) {
        if (p.isReviewDetailsLoading) {
          return const CustomLoader();
        }

        if (p.cartTotals != null && isNotBlank(p.cartTotals.total)) {
          return const _Body();
        }

        if (p.isReviewDetailsError) {
          return ErrorReload(
            errorMessage: p.errorReviewDetailsMessage,
            reloadFunction: () {
              p.reviewDetails(
                p.createCartDetailsPayload(),
              );
            },
          );
        }

        return const NoDataAvailableImage();
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
            ),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                _Heading(),
                SliverToBoxAdapter(
                  child: Divider(
                    height: 30,
                    thickness: 2.5,
                  ),
                ),
                _Divider(height: 10),
                _TotalAmount(),
                _Divider(),
                _CartItemList(),
                SliverToBoxAdapter(child: _CouponApplied()),
                _Divider(),
                _Shipping(),
                _Divider(),
                // _PaymentOption(),
                // _Divider(),
                _Address(),
                SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),
        ),
        _ReviewBottomButtons(),
      ],
    );
  }
}

class _Shipping extends StatelessWidget {
  const _Shipping({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shippingMethod =
        Provider.of<CheckoutNativeViewModel>(context, listen: false)
            .shippingMethod;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallHead(title: S.of(context).shippingOption),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: ThemeGuide.padding16,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: ThemeGuide.borderRadius10,
            ),
            child: Text(
              '${isNotBlank(shippingMethod.methodTitle) ? shippingMethod.methodTitle : 'NA'} - ${ParseEngine.currencySymbol}${shippingMethod.cost}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  const PaymentOption({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedGateway =
        Provider.of<CheckoutNativeViewModel>(context, listen: false)
            .selectedPaymentGateway;
    final lang = S.of(context);
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallHead(title: '${lang.pay} ${lang.by}'),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: ThemeGuide.padding16,
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withAlpha(10),
              borderRadius: ThemeGuide.borderRadius10,
            ),
            child: Text(
              selectedGateway?.title ?? 'NA',
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _Address extends StatelessWidget {
  const _Address({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final provider = Provider.of<CheckoutNativeViewModel>(context);
    return SliverToBoxAdapter(
      child: ExpandablePanel(
        theme: LocatorService.themeProvider().themeMode == ThemeMode.dark
            ? const ExpandableThemeData(
                hasIcon: true,
                iconColor: Colors.white,
              )
            : const ExpandableThemeData(
                hasIcon: true,
                iconColor: Colors.black,
              ),
        collapsed: const SizedBox(),
        header: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SmallHead(title: lang.shippingAddress),
        ),
        expanded: AddressContainer.withoutContainer(
          isBillingAddress: false,
          address: provider.sameShippingAndBillingAddress
              ? provider.billingAddress
              : provider.shippingAddress,
        ),
      ),
    );
  }
}

class _CartItemList extends StatelessWidget {
  const _CartItemList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CartProduct> productsList =
        LocatorService.cartViewModel().productsMap.values.toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          return CartItem.review(cartProduct: productsList[index]);
        },
        childCount: productsList.length,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
    this.height = 30,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SliverToBoxAdapter(
      child: Headline(
        title: lang.review,
        subtitle: lang.reviewSubheading,
      ),
    );
  }
}

class SmallHead extends StatelessWidget {
  const SmallHead({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

class _ReviewBottomButtons extends StatelessWidget {
  const _ReviewBottomButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final ThemeData _theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: AnimButton(
                onTap:
                    Provider.of<CheckoutNativeViewModel>(context, listen: false)
                        .back,
                child: Container(
                  padding: ThemeGuide.padding16,
                  decoration: BoxDecoration(
                    borderRadius: ThemeGuide.borderRadius,
                    color: _theme.disabledColor.withAlpha(40),
                  ),
                  child: Text(
                    lang.back,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: AnimButton(
                onTap: () => _placeOrder(context),
                child: Container(
                  padding: ThemeGuide.padding16,
                  decoration: BoxDecoration(
                    borderRadius: ThemeGuide.borderRadius,
                    gradient: AppGradients.linearGradient(context),
                  ),
                  child: Text(
                    '${lang.place} ${lang.order} ${lang.and} ${lang.pay}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _placeOrder(BuildContext context) async {
    try {
      // Show a loading dialog
      _showLoadingDialog(context);

      final result =
          await Provider.of<CheckoutNativeViewModel>(context, listen: false)
              .placeOrder();

      // Remove the dialog
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (result is WooOrder) {
        // Navigate to payment
        if (result.id != null && result.id > 0) {
          final paymentUrl =
              '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api/checkout/pay?order_id=${result.id}';
          // Navigate to the payment screen
          final PaymentResponse paymentResponse =
              await Navigator.of(context).push<PaymentResponse>(
            CupertinoPageRoute(
              builder: (context) => PaymentScreen(paymentUrl: paymentUrl),
            ),
          );

          Dev.info('Payment Screen Response $paymentResponse');

          if (paymentResponse == PaymentResponse.cancelled) {
            await _handleCancelledPayment(context, result.id);
          }

          return;
        }
      }

      // Show error message if the above fails
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _ErrorDialog(message: S.of(context).somethingWentWrong);
        },
      );
    } catch (e, s) {
      Dev.error('Place Order Review Details', error: e, stackTrace: s);
      // Remove the dialog
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _ErrorDialog(message: Utils.renderException(e));
        },
      );
    }
  }

  Future<void> _handleCancelledPayment(
    BuildContext context,
    int orderId,
  ) async {
    _showLoadingDialog(context);

    try {
      await Provider.of<CheckoutNativeViewModel>(context, listen: false)
          .deleteOrder(orderId);

      // Remove the dialog
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    } catch (e, s) {
      Dev.error('Handle Cancelled Payment ', error: e, stackTrace: s);
      // Remove the dialog
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: ThemeGuide.borderRadius10,
          ),
          contentPadding: ThemeGuide.padding20,
          children: [
            Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  const _ErrorDialog({Key key, this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          right: 20,
          left: 16,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              lang.somethingWentWrong,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.red,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 30, thickness: 1.5),
            Text(message ?? lang.somethingWentWrong),
            const SizedBox(height: 10),
            Center(
              child: OutlinedButton(
                child: Text(lang.ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CouponApplied extends StatelessWidget {
  const _CouponApplied({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCoupon =
        Provider.of<CheckoutNativeViewModel>(context, listen: false)
            .selectedCoupon;
    final lang = S.of(context);
    if (selectedCoupon.id > 0 && isNotBlank(selectedCoupon.code)) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallHead(title: '${lang.applied} ${lang.coupon}'),
            const SizedBox(height: 5),
            AppliedCoupon.withoutRemoveButton(coupon: selectedCoupon),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}

class _TotalAmount extends StatelessWidget {
  const _TotalAmount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    final checkoutNativeViewModal =
        Provider.of<CheckoutNativeViewModel>(context, listen: false);
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: ThemeGuide.borderRadius,
          color: _theme.colorScheme.background,
        ),
        child: Column(
          children: <Widget>[
            CustomTableRow(
              label: '${lang.sub} ${lang.total}',
              value:
                  '${ParseEngine.currencySymbol} ${checkoutNativeViewModal.cartTotals.subtotal ?? checkoutNativeViewModal.subTotal}',
            ),
            CustomTableRow(
              label: lang.shipping,
              value:
                  '${ParseEngine.currencySymbol} ${checkoutNativeViewModal.cartTotals.shippingTotal ?? checkoutNativeViewModal.shippingMethod?.cost}',
            ),
            if (checkoutNativeViewModal.selectedCoupon.id > 0 &&
                isNotBlank(checkoutNativeViewModal.selectedCoupon?.code))
              CustomTableRow(
                label: lang.coupon,
                value:
                    '- ${ParseEngine.currencySymbol} ${checkoutNativeViewModal.cartTotals.discountTotal ?? checkoutNativeViewModal.discountString}',
              ),
            if (checkoutNativeViewModal.shouldShowFee())
              CustomTableRow(
                label: lang.fee,
                value:
                    '${ParseEngine.currencySymbol} ${checkoutNativeViewModal.cartTotals.feeTotal ?? '0.00'}',
              ),
            if (checkoutNativeViewModal.shouldShowTax())
              CustomTableRow(
                label: lang.tax,
                value:
                    '${ParseEngine.currencySymbol} ${checkoutNativeViewModal.cartTotals.totalTax ?? '0.00'}',
              ),
            const Divider(height: 10),
            CustomTableRow(
              label: lang.totalAmount,
              value:
                  '${ParseEngine.currencySymbol} ${checkoutNativeViewModal.cartTotals.total ?? checkoutNativeViewModal.checkoutTotalCost}',
            ),
          ],
        ),
      ),
    );
  }
}
