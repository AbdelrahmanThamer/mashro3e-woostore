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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../../../app_builder/app_builder.dart' hide HexColor;
import '../../../../../generated/l10n.dart';
import '../../../../../models/models.dart';
import '../../../../../utils/colors.utils.dart';
import '../../shared.dart';
import '../attributes.dart';

class ColorOptions extends ConsumerWidget {
  const ColorOptions({
    Key? key,
    required this.product,
    this.options,
    this.title,
    this.attributeKey,
  }) : super(key: key);

  final Product product;
  final List<String>? options;
  final String? title;
  final String? attributeKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (options == null || (options?.isEmpty ?? false)) {
      return const SizedBox();
    }
    if ((product.wooProduct.variations?.isEmpty ?? true) ||
        product.wooProduct.type == 'simple') {
      if (product.selectedAttributesNotifier.value.containsKey(attributeKey)) {
        return _SingleColorOptionContainer(
          colorOption: product.selectedAttributesNotifier.value[attributeKey],
        );
      }
      return const SizedBox();
    }
    if (options!.length == 1) {
      return _SingleColorOptionContainer(
        colorOption: product.selectedAttributesNotifier.value[attributeKey],
      );
    }
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
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: ThemeGuide.borderRadius,
                            border: map[attributeKey] == options![index]
                                ? Border.all(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : Border.all(
                                    width: 2,
                                    color: Colors.transparent,
                                  ),
                          ),
                          child: Center(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: HexColor(options![index]),
                                borderRadius: ThemeGuide.borderRadius5,
                              ),
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
}

class _SingleColorOptionContainer extends ConsumerWidget {
  const _SingleColorOptionContainer({
    Key? key,
    required this.colorOption,
  }) : super(key: key);
  final String colorOption;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = S.of(context);
    final psAttributeSectionData =
        ref.read(providerOfPSAttributeSectionDataProvider);
    return PSStyledContainerLayout(
      styledData: psAttributeSectionData.styledData,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang.color,
              style: psAttributeSectionData.styledData.textStyleData
                  .createTextStyle(),
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: HexColor(colorOption),
                borderRadius: ThemeGuide.borderRadius5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
