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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart' as legacy;

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../providers/products/products.provider.dart';
import '../../providers/utils/viewStateController.dart';
import '../../themes/theme.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/product_card/product_card.dart';
import 'models/favoriteProduct.model.dart';

AutoDisposeProvider<AppWishlistScreenData> providerOfWishlistScreenLayoutData =
    Provider.autoDispose<AppWishlistScreenData>((ref) {
  return const AppWishlistScreenData();
});

class WishlistScreenLayout extends StatelessWidget {
  const WishlistScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppWishlistScreenData screenData;

  @override
  Widget build(BuildContext context) {
    providerOfWishlistScreenLayoutData =
        Provider.autoDispose<AppWishlistScreenData>((ref) {
      return screenData;
    });
    final lang = S.of(context);
    return Scaffold(
      body: legacy.ChangeNotifierProvider<ProductsProvider>.value(
        value: LocatorService.productsProvider(),
        child: CustomScrollView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          slivers: [
            if (screenData.appBarData.show)
              SliverAppBarLayout(
                data: screenData.appBarData,
                overrideTitle: lang.wishlist,
              ),
            SliverViewStateController<ProductsProvider>(
              fetchData:
                  LocatorService.productsProvider().getFavoriteProductsFromDB,
              builder: () => const _ListContainer(),
            ),
          ],
        ),
      ),
    );
  }

  static ProductCardLayoutData modifyLayoutData(
    ProductCardLayoutData originalData, {
    double addHeight = 70,
  }) {
    var result = originalData;
    final isd = result.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.image)
        as ImageSectionData;
    final nsd = result.sections.firstWhere(
            (element) => element.sectionType == ProductCardSectionType.name)
        as NameSectionData;
    double height = originalData.height;
    if (originalData.layoutType == ProductCardLayoutType.vertical) {
      height = isd.height +
          nsd.marginData.top +
          nsd.marginData.bottom +
          nsd.textStyleData.fontSize +
          addHeight;
    }

    result = result.copyWith(
      height: height,
      sections: [
        isd.copyWith(
          showLikeButton: false,
          showRating: false,
          showAddToCartButton: false,
        ),
        nsd,
      ],
    );
    return result;
  }
}

class _ListContainer extends ConsumerWidget {
  const _ListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenData = ref.read(providerOfWishlistScreenLayoutData);
    return legacy.Selector<ProductsProvider, List<String>>(
      selector: (context, d) => d.favProducts,
      shouldRebuild: (a, b) => true,
      builder: (context, list, _) {
        if (list.isEmpty) {
          return const SliverToBoxAdapter(child: _NoItemsContainer());
        }
        if (screenData.productListConfig.listType == ProductListType.grid) {
          return SliverPadding(
            padding: const EdgeInsets.only(
              bottom: 100,
              left: 10,
              right: 10,
            ),
            sliver: _Grid(screenData: screenData, list: list),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.only(
            bottom: 100,
            left: 10,
            right: 10,
          ),
          sliver: _VerticalList(screenData: screenData, list: list),
        );
      },
    );
  }
}

class _NoItemsContainer extends StatelessWidget {
  const _NoItemsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/broken-heart.svg',
            color: const Color(0xFFEF5350),
            height: 150,
          ),
          const SizedBox(height: 20),
          Text(lang.noFavoriteItems),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    Key? key,
    required this.screenData,
    required this.list,
  }) : super(key: key);
  final AppWishlistScreenData screenData;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    var productCardLayoutData = screenData.productListConfig.layoutData;
    if (screenData.productListConfig.useGlobalProductCardLayout) {
      productCardLayoutData = ParseEngine.appTemplate.globalProductCardLayout;
    }

    productCardLayoutData = WishlistScreenLayout.modifyLayoutData(
        productCardLayoutData,
        addHeight: screenData.productListConfig.gridColumns > 2
            ? (70 * screenData.productListConfig.gridColumns).toDouble()
            : 70);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.productListConfig.gridColumns,
        childAspectRatio: productCardLayoutData.getAspectRatio(),
        crossAxisSpacing: screenData.productListConfig.itemPadding,
        mainAxisSpacing: screenData.productListConfig.itemPadding,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          final FavoriteProduct? favoriteProduct =
              LocatorService.productsProvider().favoriteProductsMap[list[i]];
          if (favoriteProduct == null) {
            return const SizedBox();
          }
          return _Wrapper(
            product: favoriteProduct,
            child: ProductCardLayout(
              layoutData: productCardLayoutData,
              productData: ProductCardLayoutProductData(
                id: favoriteProduct.productId.toString(),
                name: favoriteProduct.name ?? '',
                displayImage: favoriteProduct.displayImage ?? '',
              ),
            ),
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
  final AppWishlistScreenData screenData;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    var productCardLayoutData = screenData.productListConfig.layoutData;
    if (screenData.productListConfig.useGlobalProductCardLayout) {
      productCardLayoutData = ParseEngine.appTemplate.globalProductCardLayout;
    }

    productCardLayoutData = WishlistScreenLayout.modifyLayoutData(
      productCardLayoutData,
      addHeight: 30,
    );
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          final FavoriteProduct? favoriteProduct =
              LocatorService.productsProvider().favoriteProductsMap[list[i]];
          if (favoriteProduct == null) {
            return const SizedBox();
          }
          return _Wrapper(
            product: favoriteProduct,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: screenData.productListConfig.itemPadding,
              ),
              child: ProductCardLayout(
                layoutData: WishlistScreenLayout.modifyLayoutData(
                  screenData.productListConfig.layoutData,
                ),
                productData: ProductCardLayoutProductData(
                  id: favoriteProduct.productId.toString(),
                  name: favoriteProduct.name ?? '',
                  displayImage: favoriteProduct.displayImage ?? '',
                ),
              ),
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({
    Key? key,
    required this.child,
    required this.product,
  }) : super(key: key);
  final Widget child;
  final FavoriteProduct product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.directional(
          top: 5,
          end: 5,
          textDirection: Directionality.of(context),
          child: GestureDetector(
            onTap: () => LocatorService.productsProvider().toggleStatus(
              product.productId.toString(),
              status: false,
            ),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: ThemeGuide.borderRadius,
              ),
              child: const Icon(Icons.close, color: Colors.red),
            ),
          ),
        )
      ],
    );
  }
}
