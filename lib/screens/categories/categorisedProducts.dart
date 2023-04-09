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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/product_category.dart';

import '../../controllers/uiController.dart';
import '../../enums/enums.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../shared/customLoader.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import '../../shared/widgets/listTiles/horizontalListTextItem.dart';
import '../../themes/themeGuide.dart';
import 'viewModel/categoryProductsProvider.dart';
import 'widgets/filter_modal/productsFilterModal.dart';
import 'widgets/list_container.dart';
import 'widgets/sort_bottom_sheet.dart';

class CategorisedProducts extends StatefulWidget {
  const CategorisedProducts({
    Key? key,
    required this.category,
    this.searchCategory,
    this.childrenCategoryList = const [],
  }) : super(key: key);
  final WooProductCategory category;

  /// Category to search for
  final WooProductCategory? searchCategory;
  final List<WooProductCategory> childrenCategoryList;

  @override
  _CategorisedProductsState createState() => _CategorisedProductsState();
}

class _CategorisedProductsState extends State<CategorisedProducts> {
  final CategoryProductsProvider provider =
      LocatorService.categoryProductsProvider();

  @override
  void initState() {
    super.initState();
    provider.setCurrentCategory(
      widget.category,
      childrenCategories: widget.childrenCategoryList,
    );

    if (widget.searchCategory != null) {
      provider.setSearchCategory(widget.searchCategory!);
    }

    provider.fetchData();
  }

  @override
  void dispose() {
    // Clean the provider resources
    provider.cleanUp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ChangeNotifierProvider<CategoryProductsProvider>.value(
      value: LocatorService.categoryProductsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<CategoryProductsProvider>(
            builder: (context, p, w) {
              final String? categoryName = p.currentCategory?.name;
              final String? searchCategoryName = p.searchCategory?.name;
              final String? title = categoryName;
              String? subtitle;

              if (searchCategoryName != categoryName) {
                subtitle = searchCategoryName;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? lang.products,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isNotBlank(subtitle))
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  else
                    const SizedBox(),
                ],
              );
            },
          ),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              tooltip: lang.sort,
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                UiController.modalBottomSheet(
                  context: context,
                  child: const CategorySortBottomSheet(),
                );
              },
            ),
            IconButton(
              tooltip: lang.filter,
              onPressed: () {
                UiController.showModal(
                  context: context,
                  child: const ProductsFilterModal(),
                );
              },
              icon: const Icon(EvaIcons.optionsOutline),
            ),
          ],
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late S lang;

  /// Controller for the grid view
  final ScrollController _scrollController = ScrollController();

  /// Flag to prevent concurrent requests
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      lang = S.of(context);
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    LocatorService.categoryProductsProvider().reset();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreData();
    }
  }

  Future<void> _getMoreData() async {
    if (LocatorService.categoryProductsProvider().isFinalDataSet) {
      return;
    }
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);

      final result =
          await LocatorService.categoryProductsProvider().fetchMoreData();

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
      });
    }
  }

  /// Checks if the values must be reset for a new search category
  void onSelectChildCategory(WooProductCategory cat) {
    // Set the type of category selected and fetch the data
    LocatorService.categoryProductsProvider().setSearchCategory(cat);

    // Call to fetch function now
    LocatorService.categoryProductsProvider().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            if (LocatorService.categoryProductsProvider()
                .childrenCategories
                .isNotEmpty)
              SliverAppBar(
                pinned: false,
                floating: true,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: _ChildrenCategoriesHorizontalList(
                  onSelect: onSelectChildCategory,
                ),
              ),
            Consumer<CategoryProductsProvider>(
              builder: (context, provider, widget) {
                if (provider.isLoading) {
                  return const SliverToBoxAdapter(
                    child: _ViewPort(
                      child: Center(child: CustomLoader()),
                    ),
                  );
                }
                if (provider.isError) {
                  return const SliverToBoxAdapter(
                    child: _ViewPort(child: _ErrorContainer()),
                  );
                }
                if (provider.isSuccess) {
                  if (provider.hasData) {
                    return const CategoryProductsListContainer();
                  } else {
                    return const SliverToBoxAdapter(
                      child: _ViewPort(
                        child: Center(child: NoDataAvailableImage()),
                      ),
                    );
                  }
                }
                return const SliverToBoxAdapter(
                  child: _ViewPort(child: Center(child: CustomLoader())),
                );
              },
            ),
          ],
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

class _ViewPort extends StatelessWidget {
  const _ViewPort({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height - height / 2.5,
      child: child,
    );
  }
}

// class _LL extends StatelessWidget {
//   const _LL({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverPadding(
//       padding: ThemeGuide.listPadding,
//       sliver: Selector<CategoryProductsProvider, List>(
//         selector: (context, d) => d.categoryProductsList,
//         shouldRebuild: (a, b) => true,
//         builder: (context, list, _) {
//           return SliverGrid(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 5,
//               mainAxisSpacing: 5,
//               childAspectRatio: ThemeGuide.productItemCardAspectRatio,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (context, i) {
//                 return ItemCard(productId: list[i]);
//               },
//               childCount: list.length,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class _ErrorContainer extends StatelessWidget {
  const _ErrorContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CategoryProductsProvider, String>(
      selector: (context, d) => d.errorMessage,
      builder: (context, message, widget) {
        return Container(
          padding: ThemeGuide.padding20,
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

class _ChildrenCategoriesHorizontalList extends StatelessWidget {
  const _ChildrenCategoriesHorizontalList({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  final void Function(WooProductCategory) onSelect;

  @override
  Widget build(BuildContext context) {
    final childrenList =
        LocatorService.categoryProductsProvider().childrenCategories;
    if (childrenList.isEmpty) {
      return const SizedBox();
    }
    final theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.textTheme.bodyText2!,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Selector<CategoryProductsProvider, WooProductCategory?>(
          selector: (context, d) => d.searchCategory,
          builder: (context, value, _) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: childrenList.length,
              itemBuilder: (context, i) {
                return HorizontalListTextItem(
                  isSelected: value?.id == childrenList[i].id,
                  text: childrenList[i].name,
                  onTap: () => onSelect(childrenList[i]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
