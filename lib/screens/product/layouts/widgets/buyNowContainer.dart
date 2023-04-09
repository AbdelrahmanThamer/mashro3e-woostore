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

import 'dart:ui';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../controllers/navigationController.dart';
import '../../../../controllers/uiController.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../models/models.dart';
import '../../../../shared/animatedButton.dart';
import '../../viewModel/productViewModel.dart';

class BuyNowContainer extends ConsumerStatefulWidget {
  const BuyNowContainer({
    Key? key,
  }) : super(key: key);

  @override
  _BuyNowContainerState createState() => _BuyNowContainerState();
}

class _BuyNowContainerState extends ConsumerState<BuyNowContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  late final Product product;

  @override
  void initState() {
    super.initState();

    product = ref.read(providerOfProductViewModel).currentProduct;

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeInOutBack,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return SizedBox(
      height: 90,
      child: SlideTransition(
        position: _offsetAnimation,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 80 + MediaQuery.of(context).viewInsets.bottom,
              width: MediaQuery.of(context).size.width,
              child: _isExternalProduct(product.wooProduct.type)
                  ? const _ExternalProductButton()
                  : const _ButtonBar(),
            ),
          ),
        ),
      ),
    );
  }

  /// Check if the product is external or affiliated
  bool _isExternalProduct(String? value) {
    if (value == null) {
      return false;
    }
    if (value == 'external' || value == 'affiliate') {
      return true;
    }
    return false;
  }
}

class _ButtonBar extends ConsumerWidget {
  const _ButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pvm = ref.watch(providerOfProductViewModel);

    // Add to cart button logic
    Widget addToCartButton = const _AddToCartButton.disabled();

    // return if variation is in stock
    if (pvm.selectedVariation != null) {
      // ignore: avoid_bool_literals_in_conditional_expressions
      if (isNotBlank(pvm.selectedVariation!.stockStatus) &&
          pvm.selectedVariation!.stockStatus == 'instock') {
        if (isNotBlank(pvm.selectedVariation!.price)) {
          if (pvm.screenData.bottomButtonsLayout ==
              PSBottomButtonsLayout.layout1) {
            addToCartButton = const _AddToCartButton.withoutText();
          } else if (pvm.screenData.bottomButtonsLayout ==
              PSBottomButtonsLayout.layout2) {
            addToCartButton = const Expanded(child: _AddToCartButton());
          } else if (pvm.screenData.bottomButtonsLayout ==
              PSBottomButtonsLayout.layout3) {
            addToCartButton =
                const Expanded(child: _AddToCartButton.withoutIcon());
          } else {
            addToCartButton = const _AddToCartButton.withoutText();
          }
        }
      }
    } else {
      // return if there is no variation for the product
      if (pvm.currentProduct.inStock) {
        if (isNotBlank(pvm.currentProduct.productSelectedData?.price)) {
          if (pvm.screenData.bottomButtonsLayout ==
              PSBottomButtonsLayout.layout1) {
            addToCartButton = const _AddToCartButton.withoutText();
          } else if (pvm.screenData.bottomButtonsLayout ==
              PSBottomButtonsLayout.layout2) {
            addToCartButton = const Expanded(child: _AddToCartButton());
          } else if (pvm.screenData.bottomButtonsLayout ==
              PSBottomButtonsLayout.layout3) {
            addToCartButton =
                const Expanded(child: _AddToCartButton.withoutIcon());
          } else {
            addToCartButton = const _AddToCartButton.withoutText();
          }
        }
      }
    }

    Widget buyNowButton = const _BuyNowButton.disabled();

    // return if variation is in stock
    if (pvm.selectedVariation != null) {
      // ignore: avoid_bool_literals_in_conditional_expressions
      if (pvm.selectedVariation!.stockStatus != null
          ? pvm.selectedVariation!.stockStatus == 'instock'
          : false) {
        if (isNotBlank(pvm.selectedVariation!.price)) {
          buyNowButton = const _BuyNowButton();
        }
      }
    } else {
      // return if there is no variation for the product
      if (pvm.currentProduct.inStock) {
        if (isNotBlank(pvm.currentProduct.productSelectedData?.price)) {
          buyNowButton = const _BuyNowButton();
        }
      }
    }

    if (pvm.noVariationFoundError != null) {
      return Container(
        padding: ThemeGuide.padding10,
        margin: ThemeGuide.padding10,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withAlpha(100),
          borderRadius: ThemeGuide.borderRadius,
        ),
        child: Center(
          child: Text(
            S.of(context).noVariationFound,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        addToCartButton,
        const SizedBox(width: 10),
        Expanded(child: buyNowButton),
      ],
    );
  }
}

class _AddToCartButton extends ConsumerWidget {
  const _AddToCartButton({
    Key? key,
  })  : showIcon = true,
        showText = true,
        disabled = false,
        super(key: key);

  const _AddToCartButton.withoutIcon({
    Key? key,
  })  : showIcon = false,
        showText = true,
        disabled = false,
        super(key: key);

  const _AddToCartButton.withoutText({
    Key? key,
  })  : showIcon = true,
        showText = false,
        disabled = false,
        super(key: key);

  const _AddToCartButton.disabled({
    Key? key,
  })  : showIcon = true,
        showText = true,
        disabled = true,
        super(key: key);

  final bool showIcon;
  final bool showText;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pvm = ref.read(providerOfProductViewModel);
    final String? productId = pvm.currentProduct.id;

    final TextStyle textStyle = TextStyle(
      fontSize: pvm.screenData.bottomButtonTextStyle.fontSize,
      fontWeight: pvm.screenData.bottomButtonTextStyle.getFontWeight(),
    );

    final _theme = Theme.of(context);
    if (productId == null || disabled) {
      return const SizedBox();
    }
    return AnimButton(
      onTap: () {
        if (!ParseEngine.enabledGuestCheckout &&
            isBlank(LocatorService.userProvider().user.id)) {
          NavigationController.navigator.push(LoginFromXRoute(
            onSuccess: () {},
          ));
          return;
        }
        LocatorService.cartViewModel().addToCart(productId);
      },
      child: Container(
        padding: ThemeGuide.padding16,
        decoration: BoxDecoration(
          color: _theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius10,
        ),
        child: _buildButton(context, textStyle),
      ),
    );
  }

  Widget _buildButton(BuildContext context, TextStyle style) {
    if (showIcon && showText) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(EvaIcons.shoppingCartOutline),
          const SizedBox(width: 10),
          Text(
            S.of(context).addToCart,
            textAlign: TextAlign.center,
            style: style,
          ),
        ],
      );
    } else if (showIcon && !showText) {
      return const Icon(EvaIcons.shoppingCartOutline);
    } else if (!showIcon && showText) {
      return Text(
        S.of(context).addToCart,
        textAlign: TextAlign.center,
        style: style,
      );
    } else {
      return const Icon(EvaIcons.shoppingCartOutline);
    }
  }
}

class _BuyNowButton extends ConsumerWidget {
  const _BuyNowButton({
    Key? key,
  })  : disabled = false,
        super(key: key);

  const _BuyNowButton.disabled({Key? key})
      : disabled = true,
        super(key: key);

  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(providerOfProductViewModel);
    final String? productId = provider.currentProduct.id;
    final lang = S.of(context);
    if (productId == null || disabled) {
      return Container(
        padding: ThemeGuide.padding16,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(80),
          borderRadius: ThemeGuide.borderRadius,
        ),
        child: Text(
          lang.outOfStock,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return GradientButton(
      onPress: () async {
        if (!ParseEngine.enabledGuestCheckout) {
          NavigationController.navigator.push(LoginFromXRoute(
            onSuccess: () {},
          ));
          return;
        }
        if (await LocatorService.cartViewModel().addToCart(productId)) {
          ParseEngine.navigateToCart(context);
        }
      },
      child: Text(
        lang.buyNow,
        textAlign: TextAlign.center,
        style: provider.screenData.bottomButtonTextStyle.createTextStyle(
          forcedColor: Colors.white,
        ),
      ),
    );
  }
}

class _ExternalProductButton extends ConsumerWidget {
  const _ExternalProductButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenData = ref.read(providerOfProductViewModel).screenData;
    final product = ref.read(providerOfProductViewModel).currentProduct;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GradientButton(
        onPress: () async {
          final url = product.wooProduct.externalUrl;
          if (url != null) {
            if (await canLaunchUrlString(url)) {
              launchUrlString(url);
            } else {
              final lang = S.of(context);
              UiController.showErrorNotification(
                context: context,
                title: lang.couldNotLaunch,
                message: lang.errorLaunchUrl,
              );
            }
          } else {
            final lang = S.of(context);
            UiController.showErrorNotification(
              context: context,
              title: '${lang.no} ${lang.url} ${lang.found}',
              message: lang.errorNoUrl,
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product.wooProduct.buttonText ?? S.of(context).buyNow,
              textAlign: TextAlign.center,
              style: screenData.bottomButtonTextStyle.createTextStyle(
                forcedColor: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              EvaIcons.externalLinkOutline,
              color: HexColor.fromHex(
                screenData.bottomButtonTextStyle.color,
                Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
