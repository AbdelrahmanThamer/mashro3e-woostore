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
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/navigationController.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../services/woocommerce/woocommerce.service.dart';
import '../../../../shared/animatedButton.dart';
import '../../../../shared/filter_modal/filter_modal.dart';
import '../../viewModel/categoryProductsProvider.dart';

class ProductsFilterModal extends StatelessWidget {
  const ProductsFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    final List<WooProductCategory> childrenCategoryList =
        LocatorService.categoryProductsProvider().childrenCategories;
    return WillPopScope(
      onWillPop: () {
        _backHandler(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(lang.filter),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              tooltip: lang.back,
              icon: const Icon(Icons.close),
              onPressed: () {
                _backHandler(context);
              },
            ),
          ],
        ),
        body: ChangeNotifierProvider<CategoryProductsProvider>.value(
          value: LocatorService.categoryProductsProvider(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: const [
                      FilterOnSale<CategoryProductsProvider>(),
                      Divider(),
                      FilterInStock<CategoryProductsProvider>(),
                      Divider(),
                      FilterFeatured<CategoryProductsProvider>(),
                      Divider(),
                    ],
                  ),
                ),
              ),
              if (childrenCategoryList.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      lang.categories,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              if (childrenCategoryList.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, int i) {
                        return _ProductCategoryItem(
                          category: childrenCategoryList[i],
                        );
                      },
                      childCount: childrenCategoryList.length,
                    ),
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: ExpandablePanel(
                    theme: theme.brightness == Brightness.dark
                        ? const ExpandableThemeData(
                            hasIcon: true,
                            iconColor: Colors.white,
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                          )
                        : const ExpandableThemeData(
                            hasIcon: true,
                            iconColor: Colors.black,
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                          ),
                    header: Text(
                      lang.priceRange,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    collapsed: const SizedBox(),
                    expanded: const FilterPriceRangeSlider<
                        CategoryProductsProvider>(),
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: FilterAttributes<CategoryProductsProvider>(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 15,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: const [
                      _ApplyFilterButton(),
                      SizedBox(height: 25),
                      _ClearFilters(),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100))
            ],
          ),
        ),
      ),
    );
  }

  /// If the user navigates back without selecting any category then
  /// set the searchCategory flag to the current category and fetch data
  static void _backHandler(BuildContext context) {
    final provider = LocatorService.categoryProductsProvider();
    if (provider.searchCategory == null) {
      provider.setSearchCategory(provider.currentCategory!);
      provider.fetchData();
    }
    Navigator.of(context).pop();
  }
}

class _ProductCategoryItem extends StatelessWidget {
  const _ProductCategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final WooProductCategory category;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimButton(
      onTap: _onTap,
      child: Selector<CategoryProductsProvider, WooProductCategory?>(
        selector: (context, d) => d.searchCategory,
        builder: (context, cat, w) {
          return Container(
            padding: ThemeGuide.padding,
            decoration: BoxDecoration(
              borderRadius: ThemeGuide.borderRadius10,
              color: theme.colorScheme.background,
              border: cat?.id == category.id
                  ? Border.all(width: 2, color: theme.colorScheme.primary)
                  : Border.all(width: 2, color: Colors.transparent),
            ),
            child: w,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: ExtendedCachedImage(imageUrl: category.image?.src),
            ),
            Flexible(
              child: Text(
                category.name ?? category.slug ?? '',
                style: theme.textTheme.bodyText1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    // Set the type of category selected and fetch the data
    LocatorService.categoryProductsProvider().setSearchCategory(category);
  }
}

class _ClearFilters extends StatelessWidget {
  const _ClearFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return GestureDetector(
      onTap: LocatorService.categoryProductsProvider().clearFilters,
      child: SizedBox(
        child: Text(lang.clearFilters),
      ),
    );
  }
}

class _ApplyFilterButton extends StatelessWidget {
  const _ApplyFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GradientButton(
        onPress: _onPress,
        child: Text(
          lang.apply,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void _onPress() {
    LocatorService.categoryProductsProvider().fetchDataWithNewPrice();
    NavigationController.navigator.pop();
  }
}
