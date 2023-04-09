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
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart' as legacy;

import '../../../app_builder/app_builder.dart';
import '../../../controllers/uiController.dart';
import '../../../enums/enums.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../shared/customLoader.dart';
import '../../shared/product_card/product_card.dart';
import '../viewModel/searchViewModel.dart';

class SearchItemList extends StatefulWidget {
  const SearchItemList({Key? key}) : super(key: key);

  @override
  _SearchItemListState createState() => _SearchItemListState();
}

class _SearchItemListState extends State<SearchItemList> {
  late S lang;

  AppAllProductsScreenData screenData = const AppAllProductsScreenData();

  /// Page number to fetch the result for
  int page = 2;

  /// Controller for the grid view
  final ScrollController _scrollController = ScrollController();

  /// Flag to prevent concurrent requests
  bool isPerformingRequest = false;

  /// Flag to mark if the previous data request gave the last set of data
  /// available.
  bool isFinalDataSet = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      lang = S.of(context);
    });

    final AppAllProductsScreenData? tempScreenData = ParseEngine.getScreenData(
      screenId: AppPrebuiltScreensId.allProducts,
      screenType: AppScreenType.preBuilt,
    ) as AppAllProductsScreenData?;

    if (tempScreenData != null) {
      screenData = tempScreenData;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreData();
    }
  }

  Future<void> _getMoreData() async {
    if (isFinalDataSet) {
      return;
    }
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);

      final result =
          await LocatorService.searchViewModel().fetchMoreData(page: page);

      if (result == FetchActionResponse.Failed) {
        UiController.showNotification(
          context: context,
          title: lang.somethingWentWrong,
          message: lang.requestFailed,
          color: Colors.red,
        );
      }

      if (result == FetchActionResponse.LastData ||
          result == FetchActionResponse.NoDataAvailable) {
        UiController.showNotification(
          context: context,
          title: lang.endOfList,
          message: lang.noMoreDataAvailable,
          position: FlushbarPosition.BOTTOM,
        );
      }

      setState(() {
        isPerformingRequest = false;
        page++;
        isFinalDataSet = result == FetchActionResponse.LastData ||
            result == FetchActionResponse.NoDataAvailable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        legacy.Selector<SearchViewModel, List<String>>(
          selector: (context, d) => d.searchProductsList,
          builder: (context, list, _) {
            if (list.isNotEmpty) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  if (screenData.productListConfig.listType ==
                      ProductListType.grid)
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        bottom: 100,
                        left: 10,
                        right: 10,
                      ),
                      sliver: _Grid(screenData: screenData, list: list),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        bottom: 100,
                        left: 10,
                        right: 10,
                      ),
                      sliver: _VerticalList(screenData: screenData, list: list),
                    ),
                ],
              );
            } else {
              return Center(child: Text(lang.noDataAvailable));
            }
          },
        ),
        if (isPerformingRequest)
          const Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Center(child: CustomLoader()),
          ),
      ],
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
