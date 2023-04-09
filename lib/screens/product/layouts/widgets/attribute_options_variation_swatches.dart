// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../models/models.dart';
import '../../../../services/woocommerce/woocommerce.service.dart';
import '../../../../utils/colors.utils.dart';
import '../../../../utils/utils.dart';
import 'attributeOptions.dart';
import 'shared/sectionDecorator.dart';
import 'shared/subHeading.dart';

class AttributeOptionsVariationSwatches extends StatelessWidget {
  const AttributeOptionsVariationSwatches({
    Key key,
    @required this.product,
    @required this.options,
    @required this.name,
    @required this.attributeKey,
  }) : super(key: key);

  final Product product;
  final List<String> options;
  final String name;
  final String attributeKey;

  @override
  Widget build(BuildContext context) {
    final WooStoreProductAttribute attribute = _getAttribute(attributeKey);

    if (attribute == null) {
      return AttributeOptions(
        product: product,
        options: options,
        name: name,
        attributeKey: attributeKey,
      );
    }

    if (options == null || options.isEmpty) {
      return const SizedBox();
    }
    final String title = _createTitle(context, name);
    if (product.wooProduct?.variations?.isEmpty ?? true) {
      // Check if the product is `simple` or `external`.
      if (product.wooProduct.type == 'simple' ||
          product.wooProduct.type == 'external') {
        return _SimpleOrExternalProductAttributes(
          title: title,
          options: options,
          attribute: attribute,
        );
      }
    }

    if (options.length == 1) {
      return _SingleAttributeOptionContainer(
        title: title,
        option: product.selectedAttributesNotifier.value[attributeKey],
        attribute: attribute,
      );
    }

    final theme = Theme.of(context);
    return SectionDecorator(
      child: ValueListenableBuilder<Map>(
        valueListenable: product.selectedAttributesNotifier,
        builder: (context, map, w) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                  title: '$title: ${map[attributeKey]?.toString() ?? ''}'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: List<Widget>.generate(
                  options.length,
                  (int index) {
                    return GestureDetector(
                      onTap: () {
                        product.updateSelectedAttributes(
                            {attributeKey: options[index]});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: ThemeGuide.borderRadius,
                          border: map[attributeKey].toString().toLowerCase() ==
                                  options[index].toString().toLowerCase()
                              ? Border.all(
                                  width: 2,
                                  color: theme.colorScheme.primary,
                                )
                              : Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                ),
                        ),
                        child: _RenderItem(
                          value: options[index],
                          theme: theme,
                          attribute: attribute,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  String _createTitle(BuildContext context, String name) {
    final lang = S.of(context);
    if (name != null && name.toLowerCase() == 'size' ||
        name.toLowerCase() == 'sizes') {
      return lang.size;
    } else {
      return name;
    }
  }

  WooStoreProductAttribute _getAttribute(String attributeKey) {
    return LocatorService.wooService().productAttributes.firstWhere((element) {
      return element.name.toLowerCase() == attributeKey.toLowerCase();
    }, orElse: () => null);
  }
}

class _SimpleOrExternalProductAttributes extends StatelessWidget {
  const _SimpleOrExternalProductAttributes({
    Key key,
    @required this.title,
    @required this.options,
    @required this.attribute,
  }) : super(key: key);
  final String title;
  final List<String> options;
  final WooStoreProductAttribute attribute;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionDecorator(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubHeading(title: title),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            direction: Axis.horizontal,
            children: List<Widget>.generate(
              options.length,
              (int index) {
                return _RenderItem(
                  attribute: attribute,
                  theme: theme,
                  value: options[index],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

class _SingleAttributeOptionContainer extends StatelessWidget {
  const _SingleAttributeOptionContainer({
    Key key,
    @required this.option,
    @required this.title,
    @required this.attribute,
  }) : super(key: key);
  final String option;
  final String title;
  final WooStoreProductAttribute attribute;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionDecorator(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubHeading(title: '$title: ${Utils.capitalize(option)}'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: ThemeGuide.borderRadius10,
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: _RenderItem(
              theme: theme,
              value: option,
              attribute: attribute,
            ),
          ),
        ],
      ),
    );
  }
}

class _RenderItem extends StatelessWidget {
  final String value;
  final ThemeData theme;
  final WooStoreProductAttribute attribute;

  const _RenderItem({
    Key key,
    this.value,
    this.theme,
    this.attribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final option = buildOption();
    if (attribute.type == WooStoreProductAttributeType.color) {
      return Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: option == null
              ? HexColor(value)
              : HexColor.fromDynamicString(buildOption()),
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }

    if (attribute.type == WooStoreProductAttributeType.image) {
      return SizedBox(
        height: 35,
        width: 35,
        child: ExtendedCachedImage(imageUrl: buildOption()),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: ThemeGuide.borderRadius5,
        color: theme.disabledColor.withAlpha(20),
      ),
      child: Text(
        Utils.capitalize(value) ?? '',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  String buildOption() {
    return attribute.terms.firstWhere((element) {
      return element.name?.toLowerCase() == value?.toLowerCase();
    }, orElse: () => null)?.value;
  }
}
