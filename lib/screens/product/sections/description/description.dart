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

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/html_view.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSDescriptionSectionLayout extends ConsumerWidget {
  const PSDescriptionSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSDescriptionSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    final product = ref.read(providerOfProductViewModel).currentProduct;
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: data.showTitle
          ? ExpandablePanel(
              controller: ExpandableController(initialExpanded: data.expanded),
              theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconColor: theme.disabledColor,
                iconPadding: const EdgeInsets.all(0),
              ),
              collapsed: const SizedBox(),
              header: Text(
                lang.description,
                style: data.styledData.textStyleData.createTextStyle(),
                textAlign: data.styledData.textStyleData.alignment,
              ),
              expanded: Padding(
                padding: data.showTitle
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.all(0),
                child: isBlank(product.wooProduct.description)
                    ? const SizedBox()
                    : HtmlCustomView(
                        htmlText: product.wooProduct.description!,
                      ),
              ),
            )
          : Padding(
              padding: data.showTitle
                  ? const EdgeInsets.only(top: 20)
                  : const EdgeInsets.all(0),
              child: isBlank(product.wooProduct.description)
                  ? const SizedBox()
                  : HtmlCustomView(
                      htmlText: product.wooProduct.description!,
                    ),
            ),
    );
  }
}

class PSShortDescriptionSectionLayout extends ConsumerWidget {
  const PSShortDescriptionSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSShortDescriptionSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    final product = ref.read(providerOfProductViewModel).currentProduct;
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: data.showTitle
          ? ExpandablePanel(
              controller: ExpandableController(initialExpanded: data.expanded),
              theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconColor: theme.disabledColor,
                iconPadding: const EdgeInsets.all(0),
              ),
              collapsed: const SizedBox(),
              header: Text(
                '${lang.short} ${lang.description}',
                style: data.styledData.textStyleData.createTextStyle(),
                textAlign: data.styledData.textStyleData.alignment,
              ),
              expanded: Padding(
                padding: data.showTitle
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.all(0),
                child: isBlank(product.wooProduct.shortDescription)
                    ? const SizedBox()
                    : HtmlCustomView(
                        htmlText: product.wooProduct.shortDescription!,
                      ),
              ),
            )
          : Padding(
              padding: data.showTitle
                  ? const EdgeInsets.only(top: 20)
                  : const EdgeInsets.all(0),
              child: isBlank(product.wooProduct.shortDescription)
                  ? const SizedBox()
                  : HtmlCustomView(
                      htmlText: product.wooProduct.shortDescription!,
                    ),
            ),
    );
  }
}
