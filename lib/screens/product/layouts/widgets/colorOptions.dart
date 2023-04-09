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
import '../../../../utils/colors.utils.dart';
import 'shared/sectionDecorator.dart';
import 'shared/subHeading.dart';

class ColorOptions extends StatelessWidget {
  const ColorOptions({
    Key key,
    @required this.product,
    @required this.options,
    @required this.title,
    @required this.attributeKey,
  }) : super(key: key);

  final Product product;
  final List<String> options;
  final String title;
  final String attributeKey;

  @override
  Widget build(BuildContext context) {
    if (options == null || options.isEmpty) {
      print('Color options are empty');
      return const SizedBox();
    }
    if ((product.wooProduct?.variations?.isEmpty ?? true) ||
        product.wooProduct.type == 'simple') {
      if (product.selectedAttributesNotifier.value.containsKey(attributeKey)) {
        return _SingleColorOptionContainer(
          colorOption: product.selectedAttributesNotifier.value[attributeKey],
        );
      }
      return const SizedBox();
    }
    if (options.length == 1) {
      return _SingleColorOptionContainer(
        colorOption: product.selectedAttributesNotifier.value[attributeKey],
      );
    }
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
                children: List<Widget>.generate(
                  options.length,
                  (int index) {
                    return GestureDetector(
                      onTap: () {
                        product.updateSelectedAttributes(
                            {attributeKey: options[index]});
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: ThemeGuide.borderRadius10,
                          border: map[attributeKey] == options[index]
                              ? Border.all(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : Border.all(
                                  width: 2,
                                  color: Colors.transparent,
                                ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor(options[index]),
                            borderRadius: BorderRadius.circular(6),
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
}

class _SingleColorOptionContainer extends StatelessWidget {
  const _SingleColorOptionContainer({
    Key key,
    @required this.colorOption,
  }) : super(key: key);
  final String colorOption;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SectionDecorator(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubHeading(title: lang.color),
          const SizedBox(height: 8),
          Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: ThemeGuide.borderRadius10,
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor(colorOption),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
