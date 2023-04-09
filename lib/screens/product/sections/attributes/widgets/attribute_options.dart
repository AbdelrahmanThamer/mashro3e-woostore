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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../../../app_builder/app_builder.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/models.dart';
import '../../../../../utils/utils.dart';
import '../../shared.dart';
import '../attributes.dart';
import 'color_options.dart';

class AttributeOptions extends ConsumerWidget {
  const AttributeOptions({
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
    if (name?.toLowerCase() == 'color' || name?.toLowerCase() == 'colour') {
      return ColorOptions(
        product: product,
        options: options,
        title: name,
        attributeKey: name,
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
        );
      }
    }

    if (options!.length == 1) {
      return _SingleAttributeOptionContainer(
        title: title,
        option: product.selectedAttributesNotifier.value[attributeKey],
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
                  '$title: ${map[attributeKey]?.toString() ?? ''}',
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: ThemeGuide.borderRadius,
                            border: map[attributeKey] == options![index]
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
                            padding: ThemeGuide.padding10,
                            decoration: BoxDecoration(
                              borderRadius: ThemeGuide.borderRadius5,
                              color: theme.scaffoldBackgroundColor,
                            ),
                            child: Text(
                              Utils.capitalize(options![index]),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
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
}

class _SimpleOrExternalProductAttributes extends ConsumerWidget {
  const _SimpleOrExternalProductAttributes({
    Key? key,
    this.title,
    required this.options,
  }) : super(key: key);
  final String? title;
  final List<String> options;

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
                  return Container(
                    padding: ThemeGuide.padding10,
                    decoration: BoxDecoration(
                      borderRadius: ThemeGuide.borderRadius5,
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: Text(
                      Utils.capitalize(options[index]),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
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
  }) : super(key: key);
  final String option;
  final String? title;

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
              '$title: ${Utils.capitalize(option)}',
              style: psAttributeSectionData.styledData.textStyleData
                  .createTextStyle(),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: ThemeGuide.borderRadius,
              ),
              child: Text(
                Utils.capitalize(option),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
