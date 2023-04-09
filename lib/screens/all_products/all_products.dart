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
import 'package:provider/provider.dart' as legacy;

import '../../app_builder/app_builder.dart';
import '../../controllers/uiController.dart';
import '../../generated/l10n.dart';
import '../../providers/utils/viewStateController.dart';
import '../../services/pagination/pagination.dart';
import '../../shared/filter_modal/filter_modal.dart';
import '../../shared/filter_modal/selected_filters_widget.dart';
import '../../shared/filter_modal/sort_bottom_sheet.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/product_card/product_card.dart';
import 'viewModel/allProductsViewModel.dart';

class AllProductsScreenLayout extends ConsumerWidget {
  const AllProductsScreenLayout({
    Key? key,
    required this.screenData,
    required this.action,
  }) : super(key: key);
  final AppAllProductsScreenData screenData;
  final NavigateToAllProductsScreenAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = S.of(context);
    return legacy.ChangeNotifierProvider(
      create: (context) => AllProductsViewModel(
        screenData: screenData,
        action: action,
      ),
      child: Scaffold(
        body: Builder(builder: (context) {
          return CustomScrollView(
            controller: ref
                .read(legacy.Provider.of<AllProductsViewModel>(
                  context,
                  listen: false,
                ).paginationController.notifier)
                .scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              if (screenData.appBarData.show)
                SliverAppBarLayout(
                  data: screenData.appBarData,
                  overrideTitle: '${lang.all} ${lang.products}',
                  overrideActions: {
                    AppActionType.filterModal: () {
                      UiController.showModal(
                        context: context,
                        child: FilterModal(
                          provider: legacy.Provider.of<AllProductsViewModel>(
                            context,
                            listen: false,
                          ).filterViewModel,
                        ),
                      );
                    },
                    AppActionType.sortBottomSheet: () {
                      UiController.modalBottomSheet(
                        context: context,
                        child: SortBottomSheet(
                          provider: legacy.Provider.of<AllProductsViewModel>(
                            context,
                            listen: false,
                          ).filterViewModel,
                        ),
                      );
                    },
                  },
                ),
              SelectedFiltersWidget(
                filterViewModel: legacy.Provider.of<AllProductsViewModel>(
                  context,
                  listen: false,
                ).filterViewModel,
                renderAsSliverAppBar: true,
              ),
              SliverViewStateController<AllProductsViewModel>(
                fetchData: legacy.Provider.of<AllProductsViewModel>(
                  context,
                  listen: false,
                ).fetchData,
                builder: () => const _ListContainer(),
              ),
              SliverToBoxAdapter(
                child: PaginationLoadingIndicator(
                  controller: legacy.Provider.of<AllProductsViewModel>(
                    context,
                    listen: false,
                  ).paginationController,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _ListContainer extends ConsumerWidget {
  const _ListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return legacy.Selector<AllProductsViewModel, List<String>>(
      selector: (context, d) => d.productsList,
      shouldRebuild: (a, b) => a.length != b.length,
      builder: (context, list, _) {
        if (list.isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: const NoDataAvailableImage(),
            ),
          );
        }
        final screenData = legacy.Provider.of<AllProductsViewModel>(
          context,
          listen: false,
        ).screenData;
        if (screenData.productListConfig.listType == ProductListType.grid) {
          return SliverPadding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            sliver: _Grid(screenData: screenData, list: list),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          sliver: _VerticalList(screenData: screenData, list: list),
        );
      },
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    Key? key,
    required this.screenData,
    required this.list,
  }) : super(key: key);
  final AppAllProductsScreenData screenData;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.productListConfig.gridColumns,
        childAspectRatio:
            screenData.productListConfig.layoutData.getAspectRatio(),
        crossAxisSpacing: screenData.productListConfig.itemPadding,
        mainAxisSpacing: screenData.productListConfig.itemPadding,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return ProductCardLayout(
            layoutData: screenData.productListConfig.layoutData,
            productId: list[i],
          );
        },
        childCount: list.length,
      ),
    );
  }
}

class _VerticalList extends StatelessWidget {
  const _VerticalList({
    Key? key,
    required this.screenData,
    required this.list,
  }) : super(key: key);
  final AppAllProductsScreenData screenData;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: screenData.productListConfig.itemPadding,
            ),
            child: ProductCardLayout(
              layoutData: screenData.productListConfig.layoutData,
              productId: list[i],
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}
