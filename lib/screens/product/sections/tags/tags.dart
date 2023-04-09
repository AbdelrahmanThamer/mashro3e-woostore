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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../generated/l10n.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSTagsSectionLayout extends StatelessWidget {
  const PSTagsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context) {
    Widget w = _HorizontalList(data: data);

    if (data.itemListConfig.listType == ItemListType.grid) {
      w = _GridList(data: data);
    }
    if (data.itemListConfig.listType == ItemListType.wrap) {
      w = _WrapList(data: data);
    }
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: data.showTitle
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).tags),
                const SizedBox(height: 10),
                w,
              ],
            )
          : w,
    );
  }
}

class _HorizontalList extends ConsumerWidget {
  const _HorizontalList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags =
        ref.read(providerOfProductViewModel).currentProduct.wooProduct.tags;
    if (tags == null || tags.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(right: data.itemListConfig.itemPadding),
            child: TextButton(
              onPressed: () => ParseEngine.createAction(
                context: context,
                action: NavigateToAllProductsScreenAction(
                  title: tags[i].name ?? 'NA',
                  tagData: TagData(
                    id: tags[i].id ?? 0,
                    tagId: tags[i].id?.toString() ?? '0',
                    title: tags[i].name ?? 'NA',
                  ),
                ),
              )?.call(),
              child: Text(
                tags[i].name ?? 'NA',
                style: data.styledData.textStyleData.createTextStyle(),
              ),
            ),
          );
        },
        itemCount: tags.length,
      ),
    );
  }
}

class _GridList extends ConsumerWidget {
  const _GridList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags =
        ref.read(providerOfProductViewModel).currentProduct.wooProduct.tags;
    if (tags == null || tags.isEmpty) {
      return const SizedBox();
    }
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: 4,
      crossAxisSpacing: data.itemListConfig.itemPadding,
      mainAxisSpacing: data.itemListConfig.itemPadding,
      crossAxisCount: data.itemListConfig.gridColumns,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        tags.length,
        (i) {
          return TextButton(
            onPressed: () => ParseEngine.createAction(
              context: context,
              action: NavigateToAllProductsScreenAction(
                title: tags[i].name ?? 'NA',
                tagData: TagData(
                  id: tags[i].id ?? 0,
                  tagId: tags[i].id?.toString() ?? '0',
                  title: tags[i].name ?? 'NA',
                ),
              ),
            )?.call(),
            child: Text(
              tags[i].name ?? 'NA',
              style: data.styledData.textStyleData.createTextStyle(),
            ),
          );
        },
      ),
    );
  }
}

class _WrapList extends ConsumerWidget {
  const _WrapList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags =
        ref.read(providerOfProductViewModel).currentProduct.wooProduct.tags;
    if (tags == null || tags.isEmpty) {
      return const SizedBox();
    }
    return Wrap(
      spacing: data.itemListConfig.itemPadding,
      runSpacing: data.itemListConfig.itemPadding,
      children: List.generate(
        tags.length,
        (i) {
          return TextButton(
            onPressed: () => ParseEngine.createAction(
              context: context,
              action: NavigateToAllProductsScreenAction(
                title: tags[i].name ?? 'NA',
                tagData: TagData(
                  id: tags[i].id ?? 0,
                  tagId: tags[i].id?.toString() ?? '0',
                  title: tags[i].name ?? 'NA',
                ),
              ),
            )?.call(),
            child: Text(
              tags[i].name ?? 'NA',
              style: data.styledData.textStyleData.createTextStyle(),
            ),
          );
        },
      ),
    );
  }
}
