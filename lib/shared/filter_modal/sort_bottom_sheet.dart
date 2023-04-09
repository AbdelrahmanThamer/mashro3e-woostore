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
import 'filter_view_model.dart';

class SortBottomSheet<T extends FilterViewModel> extends StatelessWidget {
  const SortBottomSheet({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final T provider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    return ClipRRect(
      borderRadius: ThemeGuide.borderRadiusBottomSheet,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ChangeNotifierProvider<T>.value(
            value: provider,
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
                  _Item<T>(
                    title: lang.latest,
                    sortOption: SortOption.latest,
                    theme: theme,
                  ),
                  _Item<T>(
                    title: lang.popularity,
                    sortOption: SortOption.popularity,
                    theme: theme,
                  ),
                  _Item<T>(
                    title: lang.rating,
                    sortOption: SortOption.rating,
                    theme: theme,
                  ),
                  _Item<T>(
                    title: '${lang.low} ${lang.toLowerCase} ${lang.high}',
                    sortOption: SortOption.lowToHigh,
                    theme: theme,
                  ),
                  _Item<T>(
                    title: '${lang.high} ${lang.toLowerCase} ${lang.low}',
                    sortOption: SortOption.highToLow,
                    theme: theme,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Item<T extends FilterViewModel> extends StatelessWidget {
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
    return Selector<T, WooStoreFilters>(
      selector: (context, d) => d.filters,
      builder: (context, filters, _) {
        return GestureDetector(
          onTap: () {
            if (sortOption == filters.sortOption) {
              NavigationController.navigator.pop();
              return;
            }
            final provider = Provider.of<T>(
              context,
              listen: false,
            );
            provider.setSortOption(sortOption);
            NavigationController.navigator.pop();
            provider.onApplyFilters();
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
