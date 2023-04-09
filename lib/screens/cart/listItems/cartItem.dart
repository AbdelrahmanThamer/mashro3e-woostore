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
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../models/models.dart';
import '../../../shared/widgets/itemAttributes.dart';
import '../../../utils/utils.dart';

class CartItemSettingsProvider {
  final bool isReview;

  const CartItemSettingsProvider({
    this.isReview = false,
  });
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.cartProduct,
  })  : isReview = false,
        super(key: key);

  const CartItem.review({
    Key? key,
    required this.cartProduct,
  })  : isReview = true,
        super(key: key);

  final CartProduct cartProduct;
  final bool isReview;

  @override
  Widget build(BuildContext context) {
    return Provider<CartItemSettingsProvider>(
      create: (context) => CartItemSettingsProvider(isReview: isReview),
      child: _CartItemBody(cartProduct: cartProduct),
    );
  }
}

class _CartItemBody extends StatelessWidget {
  const _CartItemBody({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    final isReview = Provider.of<CartItemSettingsProvider>(context).isReview;
    final ThemeData _theme = Theme.of(context);
    final Widget main = Container(
      margin: ThemeGuide.marginV5,
      padding: ThemeGuide.padding,
      decoration: BoxDecoration(
        color: _theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ExtendedCachedImage(
                  imageUrl: cartProduct.displayImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _Price(cartProduct: cartProduct),
              ),
            ],
          ),
          Expanded(
            child: isReview
                ? _InfoContainer.review(cartProduct: cartProduct)
                : _InfoContainer(cartProduct: cartProduct),
          ),
        ],
      ),
    );
    if (isReview) {
      return main;
    }
    return GestureDetector(
      onTap: () {
        NavigationController.navigator.push(
          ProductDetailsScreenLayoutRoute(id: cartProduct.product.id),
        );
      },
      child: main,
    );
  }
}

class _InfoContainer extends StatelessWidget {
  const _InfoContainer({
    Key? key,
    required this.cartProduct,
  })  : showQuantityControls = true,
        isReview = false,
        super(key: key);

  // ignore: unused_element
  const _InfoContainer.review({
    Key? key,
    required this.cartProduct,
  })  : showQuantityControls = false,
        isReview = true,
        super(key: key);

  final CartProduct cartProduct;
  final bool showQuantityControls;
  final bool isReview;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final Widget nameWidget = Text(
      (cartProduct.attributes?.isNotEmpty ?? false)
          ? _createVariationName()
          : cartProduct.name ?? 'NA',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (!isReview)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: nameWidget),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.red.withAlpha(50),
                  ),
                  onPressed: () =>
                      LocatorService.cartViewModel().removeFromCart(
                    cartProduct.cartItemKey ??
                        cartProduct.generateCartItemKey(),
                  ),
                  child: const Icon(Icons.close),
                ),
              ],
            )
          else
            nameWidget,
          if (isReview) const SizedBox(height: 10),
          if (cartProduct.product.wooProduct.soldIndividually == null ||
              cartProduct.product.wooProduct.soldIndividually == true ||
              !showQuantityControls)
            Text(
              '${lang.quantity}:  ${cartProduct.quantity}',
              style: ThemeGuide.isDarkMode(context)
                  ? const TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                    )
                  : const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
            )
          else
            _Quantity(cartProduct: cartProduct),
          if (cartProduct.attributes?.isNotEmpty ?? false)
            RenderAttributes(attributes: cartProduct.attributes!),
          if (cartProduct.productAddons?.isNotEmpty ?? false)
            RenderProductAddons(productAddons: cartProduct.productAddons!),
        ],
      ),
    );
  }

  String _createVariationName() {
    String attributeString = '';
    final attrList = cartProduct.attributes?.values.toList() ?? const [];
    for (var i = 0; i < attrList.length; i++) {
      attributeString += attrList[i];
      if (attrList.length - i > 1) {
        attributeString += ', ';
      }
    }
    return '${cartProduct.name} - $attributeString';
  }
}

class _Price extends StatelessWidget {
  const _Price({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    final Widget price = Text(
      Utils.formatPrice(
        NumberFormat.compact().format(
          double.tryParse(cartProduct.price ?? '0'),
        ),
      ),
      style: TextStyle(
        color: _theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );

    Widget? salePrice;
    if (isNotBlank(cartProduct.product.wooProduct.regularPrice) &&
        (double.tryParse(cartProduct.product.wooProduct.regularPrice!) !=
            double.tryParse(cartProduct.product.wooProduct.price ?? '0'))) {
      salePrice = Text(
        Utils.formatPrice(
          NumberFormat.compact().format(
            double.parse(cartProduct.product.wooProduct.regularPrice!),
          ),
        ),
        style: const TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.grey,
        ),
      );
    }

    if (salePrice != null) {
      return Row(
        children: [
          salePrice,
          const SizedBox(width: 5),
          price,
        ],
      );
    }

    return price;
  }
}

class _Quantity extends StatelessWidget {
  const _Quantity({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          child: GestureDetector(
            child: const Icon(
              Icons.remove,
              size: 16,
            ),
            onTap: () {
              LocatorService.cartViewModel().decreaseProductQuantity(
                cartProduct.cartItemKey ?? cartProduct.generateCartItemKey(),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          child: _QuantityField(cartProduct: cartProduct),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          child: GestureDetector(
            child: const Icon(
              Icons.add,
              size: 16,
            ),
            onTap: () {
              LocatorService.cartViewModel().increaseProductQuantity(
                cartProduct.cartItemKey ?? cartProduct.generateCartItemKey(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _QuantityField extends StatelessWidget {
  const _QuantityField({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);
  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open Editing dialog
        showDialog(
          context: context,
          builder: (context) {
            return _QuantityDialog(cartProduct: cartProduct);
          },
        );
      },
      child: SizedBox(
        width: 40,
        child: Text(
          cartProduct.quantity.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _QuantityDialog extends StatefulWidget {
  const _QuantityDialog({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);
  final CartProduct cartProduct;

  @override
  _QuantityDialogState createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<_QuantityDialog> {
  String quantity = '1';

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SimpleDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 300,
          width: 250,
          child: ExtendedCachedImage(
            imageUrl: widget.cartProduct.displayImage,
          ),
        ),
        Padding(
          padding: ThemeGuide.padding16,
          child: TextFormField(
            initialValue: widget.cartProduct.quantity.toString(),
            maxLines: 1,
            // textInputAction: TextInputAction.done,
            autocorrect: false,
            autovalidateMode: AutovalidateMode.always,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
              FormBuilderValidators.min(1),
            ]),
            onEditingComplete: _submit,
            decoration: InputDecoration(
              labelText: lang.quantity,
            ),
            onChanged: (val) {
              if (mounted) {
                setState(() {
                  quantity = val;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) {
      LocatorService.cartViewModel().setProductQuantity(
        widget.cartProduct.cartItemKey ??
            widget.cartProduct.generateCartItemKey(),
        int.tryParse(quantity) ?? 1,
      );
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(true);
      }
    }
  }
}

class RenderProductAddons extends StatelessWidget {
  const RenderProductAddons({Key? key, required this.productAddons})
      : super(key: key);
  final List<ProductSelectedAddon> productAddons;

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];
    for (final o in productAddons) {
      list.add(ProductAddonOption(
        name: o.renderNameWithPrice(currency: ParseEngine.currencySymbol),
        value: o.value,
      ));
    }
    return ExpandablePanel(
      collapsed: const SizedBox(),
      theme: const ExpandableThemeData(
        iconColor: Colors.grey,
        headerAlignment: ExpandablePanelHeaderAlignment.center,
      ),
      header: Text(
        S.of(context).addons,
        style: ThemeGuide.isDarkMode(context)
            ? const TextStyle(
                fontSize: 14,
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              )
            : const TextStyle(
                fontSize: 14,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
      ),
      expanded: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      ),
    );
  }
}

class ProductAddonOption extends StatelessWidget {
  const ProductAddonOption({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: ThemeGuide.isDarkMode(context)
                ? const TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                  )
                : const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
          ),
          const SizedBox(height: 5),
          Text(_createValue(value)),
        ],
      ),
    );
  }

  String _createValue(String value) {
    try {
      if (Uri.parse(value).host.isNotEmpty) {
        final urlFragments = value.split('/');
        return isNotBlank(urlFragments.last) ? urlFragments.last : value;
      }
    } catch (e, s) {
      Dev.error('create product add on value', error: e, stackTrace: s);
      return value;
    }
    return value;
  }
}
