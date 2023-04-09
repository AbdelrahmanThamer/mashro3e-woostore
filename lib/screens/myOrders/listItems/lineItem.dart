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
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/order.dart' as order_model;

import '../../../controllers/navigationController.dart';
import '../../../controllers/uiController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../models/models.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../shared/widgets/itemAttributes.dart';
import '../../../utils/utils.dart';
import '../../product/viewModel/productViewModel.dart';
import '../../review/addReview.dart';
import '../order.model.dart';
import '../widgets/rowItem.dart';

/// An item in an order
class LineItem extends StatefulWidget {
  const LineItem({
    Key? key,
    required this.lineItem,
    required this.order,
  }) : super(key: key);
  final order_model.LineItems lineItem;
  final Order order;

  @override
  _LineItemState createState() => _LineItemState();
}

class _LineItemState extends State<LineItem> {
  bool loading = false;
  bool isVariable = false;
  WooProductVariation? productVariation;
  Product? product;

  @override
  void initState() {
    super.initState();

    if (widget.lineItem.variationId != null &&
        widget.lineItem.variationId! > 0) {
      isVariable = true;
    }

    // Check if the variation is present in the order variation list
    productVariation =
        widget.order.productVariations[widget.lineItem.variationId];

    // Check if the product is present in the order products list
    product = widget.order.products[widget.lineItem.productId.toString()];

    SchedulerBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  // Fetch the product and variation information
  Future<void> init() async {
    if (isVariable) {
      // If not present then perform variable product fetch task
      if (productVariation == null) {
        _fetchVariation();
      }
    }

    // If not present then perform variable product fetch task
    if (product == null) {
      _fetchProduct();
    }
  }

  /// Fetch the product and variation together
  Future<void> _fetchVariation() async {
    // Function Log
    Dev.debugFunction(
      functionName: '_fetchVariation',
      className: '_LineItemState',
      fileName: 'lineItem.dart',
      start: true,
    );
    try {
      // fetch the product data
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      final int productId = widget.lineItem.productId ?? 0;
      final int variationId = widget.lineItem.variationId ?? 0;

      final resultOfVariation = await LocatorService.productsProvider()
          .fetchProductVariation(productId, variationId);

      if (resultOfVariation != null) {
        widget.order.updateVariations(resultOfVariation);
        if (mounted) {
          setState(() {
            loading = false;
            productVariation = resultOfVariation;
          });
        }
      }
    } catch (e, s) {
      Dev.error('_fetchVariation error', error: e, stackTrace: s);
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
    // Function Log
    Dev.debugFunction(
      functionName: '_fetchVariation',
      className: '_LineItemState',
      fileName: 'lineItem.dart',
      start: false,
    );
  }

  /// Fetch the simple product
  Future<void> _fetchProduct() async {
    // Function Log
    Dev.debugFunction(
      functionName: '_fetchProduct',
      className: '_LineItemState',
      fileName: 'lineItem.dart',
      start: true,
    );

    try {
      // fetch the product data
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      final Product? result =
          await LocatorService.productsProvider().fetchSingleProductById(
        widget.lineItem.productId ?? 0,
        shouldCheckInCache: true,
      );

      if (result != null) {
        widget.order.updateProducts(result);
        if (mounted) {
          setState(() {
            loading = false;
            product = result;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }
    } catch (e, s) {
      Dev.error('_fetchProduct error', error: e, stackTrace: s);
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
    // Function Log
    Dev.debugFunction(
      functionName: '_fetchProduct',
      className: '_LineItemState',
      fileName: 'lineItem.dart',
      start: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Column(
        children: [
          _LineItemBody(
            lineItem: widget.lineItem,
            order: widget.order,
            variation: productVariation,
            product: product,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: LinearProgressIndicator(minHeight: 2),
          )
        ],
      );
    } else {
      return _LineItemBody(
        lineItem: widget.lineItem,
        order: widget.order,
        variation: productVariation,
        product: product,
      );
    }
  }
}

class _LineItemBody extends StatelessWidget {
  const _LineItemBody({
    Key? key,
    this.lineItem,
    this.order,
    this.variation,
    this.product,
  }) : super(key: key);
  final order_model.LineItems? lineItem;
  final Order? order;
  final WooProductVariation? variation;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    String? imageUrl;
    if (variation != null &&
        variation!.image != null &&
        variation!.image!.src != null &&
        variation!.image!.src!.isNotEmpty) {
      imageUrl = variation!.image!.src!;
    } else if (product != null && isNotBlank(product!.displayImage)) {
      imageUrl = product!.displayImage;
    }

    final attrMap = {};
    if (variation != null &&
        variation!.attributes != null &&
        variation!.attributes!.isNotEmpty) {
      for (final val in variation!.attributes!) {
        attrMap.addAll({val.name: val.option});
      }
    }

    String price = lineItem?.total ?? 'NA';
    final double? _tempTotal = double.tryParse(lineItem?.total ?? '0');
    final double? _tempTax = double.tryParse(lineItem?.totalTax ?? '0');
    if (_tempTotal != null && _tempTax != null) {
      price = (_tempTotal + _tempTax).toString();
    }
    return InkWell(
      onTap: () {
        if (lineItem?.productId != null) {
          NavigationController.navigator.push(
            ProductDetailsScreenLayoutRoute(
                id: lineItem!.productId!.toString()),
          );
        }
      },
      child: Container(
        padding: ThemeGuide.padding10,
        margin: ThemeGuide.margin5,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: ThemeGuide.borderRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ExtendedCachedImage(imageUrl: imageUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lineItem?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    RowItem.noPadding(
                      label: lang.quantity,
                      value: lineItem?.quantity.toString() ?? '',
                    ),
                    const SizedBox(height: 5),
                    RowItem.noPadding(
                      label: lang.price,
                      value: Utils.formatPrice(price),
                    ),
                    RenderAttributes(attributes: attrMap),
                    _RenderProductAddons(productAddons: lineItem?.metaData),
                    if (order?.status == OrderStatus.completed)
                      const SizedBox(height: 10),
                    if (order?.status == OrderStatus.completed)
                      _AddReviewButton(product: product),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddReviewButton extends StatelessWidget {
  const _AddReviewButton({
    Key? key,
    this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    if (product?.wooProduct.id == null ||
        (product?.wooProduct.reviewsAllowed == false)) {
      return const SizedBox();
    }

    final lang = S.of(context);
    return OutlinedButton(
      onPressed: () {
        if (isBlank(LocatorService.userProvider().user.id)) {
          UiController.showErrorNotification(
            context: context,
            title: '${lang.no} ${lang.user}',
            message:
                '${lang.login} ${lang.toLowerCase} ${lang.add} ${lang.review}',
          );
        } else {
          UiController.showModal(
            context: context,
            child: ChangeNotifierProvider<PVMReviewNotifier>(
              create: (context) => PVMReviewNotifier(product!.id),
              builder: (context, _) {
                return AddReview(
                  notifier: Provider.of<PVMReviewNotifier>(
                    context,
                    listen: false,
                  ),
                );
              },
            ),
          );
        }
      },
      child: Text(
        lang.addReview,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _RenderProductAddons extends StatelessWidget {
  const _RenderProductAddons({Key? key, required this.productAddons})
      : super(key: key);
  final List<order_model.MetaData>? productAddons;

  @override
  Widget build(BuildContext context) {
    if (productAddons == null) {
      return const SizedBox();
    }
    final List<Widget> list = [];
    for (final o in productAddons!) {
      if (isNotBlank(o.key) && isNotBlank(o.value)) {
        if (o.key!.startsWith('_') || o.key!.startsWith('pa_')) {
          continue;
        }
        list.add(_ProductAddonOption(
          name: o.key!,
          value: o.value!,
        ));
      }
    }
    if (list.isEmpty) {
      return const SizedBox();
    }
    return ExpandablePanel(
      controller: ExpandableController(initialExpanded: false),
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

class _ProductAddonOption extends StatelessWidget {
  const _ProductAddonOption({
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
      Dev.error('create product add on value in order line items',
          error: e, stackTrace: s);
      return value;
    }
    return value;
  }
}
