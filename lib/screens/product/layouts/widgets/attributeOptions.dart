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

import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/models.dart';
import '../../../../themes/themeGuide.dart';
import '../../../../utils/utils.dart';
import 'colorOptions.dart';
import 'shared/sectionDecorator.dart';
import 'shared/subHeading.dart';

class AttributeOptions extends StatelessWidget {
  const AttributeOptions({
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
    if (name.toLowerCase() == 'color' || name.toLowerCase() == 'colour') {
      return ColorOptions(
        product: product,
        options: options,
        title: name,
        attributeKey: name,
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
        );
      }
    }

    if (options.length == 1) {
      return _SingleAttributeOptionContainer(
        title: title,
        option: product.selectedAttributesNotifier.value[attributeKey],
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
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: ThemeGuide.borderRadius,
                          border: map[attributeKey] == options[index]
                              ? Border.all(
                                  width: 2,
                                  color: theme.colorScheme.primary,
                                )
                              : Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: ThemeGuide.borderRadius5,
                            color: theme.disabledColor.withAlpha(20),
                          ),
                          child: Text(
                            Utils.capitalize(options[index]) ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
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
}

class _SimpleOrExternalProductAttributes extends StatelessWidget {
  const _SimpleOrExternalProductAttributes({
    Key key,
    @required this.title,
    @required this.options,
  }) : super(key: key);
  final String title;
  final List<String> options;

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
                    Utils.capitalize(options[index]) ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
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
  }) : super(key: key);
  final String option;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SectionDecorator(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubHeading(title: '$title: ${Utils.capitalize(option)}'),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: ThemeGuide.borderRadius10,
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Text(Utils.capitalize(option) ?? ''),
          ),
        ],
      ),
    );
  }
}
