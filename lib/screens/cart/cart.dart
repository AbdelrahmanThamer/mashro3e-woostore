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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart' as legacy;
import 'package:quiver/strings.dart';

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../screens/cart/checkoutContainer.dart';
import '../shared/app_bar/app_bar.dart';
import 'listItems/cartItem.dart';
import 'viewModel/states.dart';
import 'viewModel/viewModel.dart';
import 'widgets/coupon/coupon_tile.dart';
import 'widgets/customer_note.dart';

AutoDisposeProvider<AppCartScreenData> providerOfCartScreenLayoutData =
    Provider.autoDispose<AppCartScreenData>((ref) {
  return const AppCartScreenData();
});

class CartScreenLayout extends StatelessWidget {
  const CartScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppCartScreenData screenData;

  @override
  Widget build(BuildContext context) {
    providerOfCartScreenLayoutData =
        Provider.autoDispose<AppCartScreenData>((ref) {
      return screenData;
    });
    final lang = S.of(context);
    return legacy.ChangeNotifierProvider<CartViewModel>.value(
      value: LocatorService.cartViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBarLayout(
                      overrideTitle: lang.cart,
                      data: screenData.appBarData,
                      bottomWidget: const _ProgressIndicator(),
                      overrideActions: {
                        AppActionType.cartReload:
                            LocatorService.cartViewModel().getCart,
                      },
                    ),
                    const _CartListContainer(),
                    const SliverToBoxAdapter(child: _ExtraData()),
                  ],
                ),
              ),
              const CheckOutContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget with PreferredSizeWidget {
  const _ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return legacy.Selector<CartViewModel, bool>(
      selector: (context, d) => d.isLoading,
      builder: (context, loading, child) {
        if (loading) {
          return child!;
        } else {
          return const SizedBox();
        }
      },
      child: const LinearProgressIndicator(minHeight: 2),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(2);
}

class _CartListContainer extends StatelessWidget {
  const _CartListContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return legacy.Consumer<CartViewModel>(
      builder: (context, provider, _) {
        if (provider.productsMap.isNotEmpty) {
          if (provider.isSuccess && provider.hasData) {
            final productsList = provider.productsMap.values.toList();
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: CartItem(cartProduct: productsList[i]),
                  );
                },
                childCount: productsList.length,
              ),
            );
          }
        }

        Widget widget = const _EmptyCart();

        if (isNotBlank(provider.errorMessage)) {
          if (provider.cartErrorState is CartGeneralErrorState) {
            widget = _GeneralError(extra: provider.errorMessage);
          } else if (provider.cartErrorState is CartEmptyState) {
            widget = const _EmptyCart();
          } else if (provider.cartErrorState is CartUserEmptyState) {
            widget = Center(
              child: Text('${lang.no} ${lang.user}\n${lang.loginAgain}'),
            );
          } else if (provider.cartErrorState is CartLoginMessageState) {
            widget = Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${provider.errorMessage}\n\n${lang.loginAgain}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          widget = Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                provider.errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          if (provider.cartErrorState is CartGeneralErrorState) {
            widget = const _GeneralError();
          } else if (provider.cartErrorState is CartEmptyState) {
            widget = const _EmptyCart();
          } else if (provider.cartErrorState is CartUserEmptyState) {
            widget = Center(
              child: Text('${lang.no} ${lang.user}\n${lang.loginAgain}'),
            );
          } else if (provider.cartErrorState is CartLoginMessageState) {
            widget = Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${provider.errorMessage}\n\n${lang.loginAgain}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
        }
        widget = const _EmptyCart();
        return SliverToBoxAdapter(child: widget);
      },
    );
  }
}

class _GeneralError extends StatelessWidget {
  const _GeneralError({Key? key, this.extra = ''}) : super(key: key);
  final String extra;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Center(
      child: Text('${lang.somethingWentWrong}\n$extra'),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/sad-bag-icon.svg',
            height: 200,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white60
                : Colors.black12,
          ),
          const SizedBox(height: 20),
          Text(lang.cartEmpty),
        ],
      ),
    );
  }
}

/// Container for Coupons and Customer Note if any.
class _ExtraData extends ConsumerWidget {
  const _ExtraData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenData = ref.read(providerOfCartScreenLayoutData);
    return legacy.Selector<CartViewModel, int>(
      selector: (context, d) => d.totalItems,
      builder: (context, totalItems, child) {
        if (totalItems > 0) {
          return child!;
        } else {
          return const SizedBox.shrink();
        }
      },
      child: Column(
        children: [
          if (screenData.enableCoupon) const SizedBox(height: 10),
          if (screenData.enableCoupon)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: CartCoupon(data: screenData.couponData),
            ),
          if (screenData.enableCustomerNote)
            const Padding(
              padding: EdgeInsets.all(10),
              child: CartCustomerNote(),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
