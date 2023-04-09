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
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../../../app_builder/app_builder.dart' hide HexColor;
import '../../../../../generated/l10n.dart';
import '../../../../../locator.dart';
import '../../../../../models/models.dart';
import '../../../../../services/woocommerce/models/models.dart';
import '../../../../../utils/colors.utils.dart';
import '../../../../../utils/utils.dart';
import '../../shared.dart';
import '../attributes.dart';
import 'attribute_options.dart';

class AttributeOptionsVariationSwatches extends ConsumerWidget {
  const AttributeOptionsVariationSwatches({
    Key? key,
    required this.product,
    this.options,
    this.name,
    this.attributeKey,
  }) : super(key: key);

  final Product product;
  final List<String>? options;
  final String? name;
  final String? attributeKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final WooStoreProductAttribute? attribute = _getAttribute(attributeKey);

    if (attribute == null) {
      return AttributeOptions(
        product: product,
        options: options,
        name: name,
        attributeKey: attributeKey,
      );
    }

    if (options == null || (options?.isEmpty ?? false)) {
      return const SizedBox();
    }
    final String? title = _createTitle(context, name);
    if (product.wooProduct.variations?.isEmpty ?? true) {
      // Check if the product is `simple` or `external`.
      if (product.wooProduct.type == 'simple' ||
          product.wooProduct.type == 'external') {
        return _SimpleOrExternalProductAttributes(
          title: title,
          options: options!,
          attribute: attribute,
        );
      }
    }

    if (options!.length == 1) {
      return _SingleAttributeOptionContainer(
        title: title,
        option: product.selectedAttributesNotifier.value[attributeKey],
        attribute: attribute,
      );
    }

    final theme = Theme.of(context);
    final psAttributeSectionData =
        ref.read(providerOfPSAttributeSectionDataProvider);
    return PSStyledContainerLayout(
      styledData: psAttributeSectionData.styledData,
      child: SizedBox(
        width: double.infinity,
        child: ValueListenableBuilder<Map>(
          valueListenable: product.selectedAttributesNotifier,
          builder: (context, map, w) {
            return Column(
              crossAxisAlignment:
                  ParseEngineLayoutUtils.convertTextAlignToCrossAxisAlignment(
                psAttributeSectionData.styledData.textStyleData.alignment,
              ),
              children: [
                Text(
                  '$title: ${map[attributeKey]?.toString().capitalize() ?? ''}',
                  style: psAttributeSectionData.styledData.textStyleData
                      .createTextStyle(),
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment:
                      ParseEngineLayoutUtils.convertTextAlignToWrapAlignment(
                    psAttributeSectionData.styledData.textStyleData.alignment,
                  ),
                  spacing: 5,
                  runSpacing: 5,
                  children: List<Widget>.generate(
                    options!.length,
                    (int index) {
                      return GestureDetector(
                        onTap: () {
                          if (isNotBlank(attributeKey)) {
                            product.updateSelectedAttributes(
                                {attributeKey!: options![index]});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: ThemeGuide.borderRadius,
                            border:
                                map[attributeKey].toString().toLowerCase() ==
                                        options![index].toString().toLowerCase()
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
                            value: options![index],
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
      ),
    );
  }

  String? _createTitle(BuildContext context, String? name) {
    final lang = S.of(context);
    if (isNotBlank(name) && name!.toLowerCase() == 'size' ||
        name!.toLowerCase() == 'sizes') {
      return Utils.capitalize(lang.size);
    } else {
      return name;
    }
  }

  WooStoreProductAttribute? _getAttribute(String? attributeKey) {
    if (isBlank(attributeKey)) {
      return null;
    }
    return LocatorService.wooService()
        .productAttributes
        .firstWhereOrNull((element) {
      return element.name?.toLowerCase() == attributeKey!.toLowerCase();
    });
  }
}

class _SimpleOrExternalProductAttributes extends ConsumerWidget {
  const _SimpleOrExternalProductAttributes({
    Key? key,
    this.title,
    required this.options,
    required this.attribute,
  }) : super(key: key);
  final String? title;
  final List<String> options;
  final WooStoreProductAttribute attribute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final psAttributeSectionData =
        ref.read(providerOfPSAttributeSectionDataProvider);
    return PSStyledContainerLayout(
      styledData: psAttributeSectionData.styledData,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment:
              ParseEngineLayoutUtils.convertTextAlignToCrossAxisAlignment(
            psAttributeSectionData.styledData.textStyleData.alignment,
          ),
          children: [
            Text(
              title ?? 'Attribute',
              style: psAttributeSectionData.styledData.textStyleData
                  .createTextStyle(),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: ParseEngineLayoutUtils.convertTextAlignToWrapAlignment(
                psAttributeSectionData.styledData.textStyleData.alignment,
              ),
              spacing: 5,
              runSpacing: 5,
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
      ),
    );
  }
}

class _SingleAttributeOptionContainer extends ConsumerWidget {
  const _SingleAttributeOptionContainer({
    Key? key,
    required this.option,
    this.title,
    required this.attribute,
  }) : super(key: key);
  final String option;
  final String? title;
  final WooStoreProductAttribute attribute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final psAttributeSectionData =
        ref.read(providerOfPSAttributeSectionDataProvider);
    return PSStyledContainerLayout(
      styledData: psAttributeSectionData.styledData,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              ParseEngineLayoutUtils.convertTextAlignToCrossAxisAlignment(
            psAttributeSectionData.styledData.textStyleData.alignment,
          ),
          children: [
            Text(
              '${title ?? 'Attribute'}: ${Utils.capitalize(option)}',
              style: psAttributeSectionData.styledData.textStyleData
                  .createTextStyle(),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: ThemeGuide.borderRadius10,
                border: Border.all(
                  width: 2,
                  color: theme.colorScheme.primary,
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
      ),
    );
  }
}

class _RenderItem extends StatelessWidget {
  final String value;
  final ThemeData theme;
  final WooStoreProductAttribute attribute;

  const _RenderItem({
    Key? key,
    required this.value,
    required this.theme,
    required this.attribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final option = buildOption();
    if (attribute.type == WooStoreProductAttributeType.color) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: option == null
              ? HexColor(value)
              : HexColor.fromDynamicString(option),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    if (attribute.type == WooStoreProductAttributeType.image) {
      return SizedBox(
        height: 40,
        width: 40,
        child: ExtendedCachedImage(
          imageUrl: buildOption(),
          borderRadius: ThemeGuide.borderRadius5,
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
      padding: ThemeGuide.padding10,
      decoration: BoxDecoration(
        borderRadius: ThemeGuide.borderRadius5,
        color: theme.scaffoldBackgroundColor,
      ),
      child: Text(
        Utils.capitalize(value),
        style: const TextStyle(fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }

  String? buildOption() {
    return attribute.terms?.firstWhereOrNull((element) {
      return element.name?.toLowerCase() == value.toLowerCase();
    })?.value;
  }
}
