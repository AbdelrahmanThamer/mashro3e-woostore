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
import 'package:provider/provider.dart';

import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../themes/theme.dart';
import '../viewModel/tag_products_view_model.dart';

class TagProductsSortBottomSheet extends StatelessWidget {
  const TagProductsSortBottomSheet({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final TagProductsViewModel provider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    return ChangeNotifierProvider<TagProductsViewModel>.value(
      value: provider,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: ThemeGuide.borderRadiusBottomSheet,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  lang.sort + ' ' + lang.by,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _Item(
                title: lang.latest,
                sortOption: SortOption.latest,
                theme: theme,
              ),
              _Item(
                title: lang.popularity,
                sortOption: SortOption.popularity,
                theme: theme,
              ),
              _Item(
                title: lang.rating,
                sortOption: SortOption.rating,
                theme: theme,
              ),
              _Item(
                title: '${lang.low} ${lang.toLowerCase} ${lang.high}',
                sortOption: SortOption.lowToHigh,
                theme: theme,
              ),
              _Item(
                title: '${lang.high} ${lang.toLowerCase} ${lang.low}',
                sortOption: SortOption.highToLow,
                theme: theme,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.title,
    required this.sortOption,
    required this.theme,
  }) : super(key: key);
  final String title;
  final SortOption sortOption;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Selector<TagProductsViewModel, WooStoreFilters>(
      selector: (context, d) => d.filters,
      builder: (context, filters, _) {
        return GestureDetector(
          onTap: () {
            if (sortOption == filters.sortOption) {
              NavigationController.navigator.pop();
              return;
            }
            final provider = Provider.of<TagProductsViewModel>(
              context,
              listen: false,
            );
            provider.setSortOption(sortOption);
            NavigationController.navigator.pop();
            provider.fetchWithSortOption();
          },
          child: Container(
            margin: ThemeGuide.marginV5,
            padding: ThemeGuide.marginH5,
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: ThemeGuide.borderRadius10,
              border: filters.sortOption == sortOption
                  ? Border.all(width: 2, color: theme.colorScheme.primary)
                  : Border.all(width: 2, color: Colors.transparent),
            ),
            child: ListTile(title: Text(title)),
          ),
        );
      },
    );
  }
}
