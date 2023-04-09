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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy;
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/vendor.dart';

import '../../app_builder/app_builder.dart';
import '../../controllers/uiController.dart';
import '../../providers/utils/viewStateController.dart';
import '../../services/pagination/pagination.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/product_card/product_card.dart';
import 'viewModel/view_model.dart';
import 'widgets/filter_modal/vendor_products_filter_modal.dart';
import 'widgets/more_info_modal.dart';
import 'widgets/sort_bottom_sheet.dart';

AutoDisposeProvider<AppVendorScreenData>
    providerOfVendorDetailsScreenLayoutData =
    Provider.autoDispose<AppVendorScreenData>((ref) {
  return const AppVendorScreenData();
});

class VendorDetailsScreenLayout extends ConsumerWidget {
  const VendorDetailsScreenLayout({
    Key? key,
    this.screenData,
    required this.vendorData,
  }) : super(key: key);
  final AppVendorScreenData? screenData;
  final Vendor vendorData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppVendorScreenData _screenData = screenData ??
        ParseEngine.getScreenData(
          screenId: AppPrebuiltScreensId.vendor,
        ) as AppVendorScreenData;
    providerOfVendorDetailsScreenLayoutData =
        Provider.autoDispose<AppVendorScreenData>((_) {
      return _screenData;
    });
    return legacy.ChangeNotifierProvider<VendorProductsViewModel>(
      create: (context) => VendorProductsViewModel(vendorData),
      builder: (context, w) => w!,
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return CustomScrollView(
              controller: ref
                  .read(legacy.Provider.of<VendorProductsViewModel>(
                    context,
                    listen: false,
                  ).paginationController.notifier)
                  .scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                if (_screenData.appBarData.show)
                  SliverAppBarLayout(
                    data: _screenData.appBarData,
                    overrideTitle: vendorData.storeName,
                    overrideActions: {
                      AppActionType.sortBottomSheet: () {
                        UiController.modalBottomSheet(
                          context: context,
                          child: VendorProductsSortBottomSheet(
                            provider:
                                legacy.Provider.of<VendorProductsViewModel>(
                              context,
                              listen: false,
                            ),
                          ),
                        );
                      },
                      AppActionType.filterModal: () {
                        UiController.showModal(
                          context: context,
                          child: VendorProductsFilterModal(
                            provider:
                                legacy.Provider.of<VendorProductsViewModel>(
                              context,
                              listen: false,
                            ),
                          ),
                        );
                      },
                      AppActionType.vendorInfo: () {
                        showCupertinoModalPopup(
                          context: context,
                          barrierColor: Colors.black54,
                          builder: (_) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: VendorMoreInfoModal(
                                provider:
                                    legacy.Provider.of<VendorProductsViewModel>(
                                  context,
                                  listen: false,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    },
                  ),
                if (isNotBlank(vendorData.banner))
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: ExtendedCachedImage(
                          imageUrl: vendorData.banner,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                SliverViewStateController<VendorProductsViewModel>(
                  fetchData: legacy.Provider.of<VendorProductsViewModel>(
                    context,
                    listen: false,
                  ).fetchData,
                  builder: () => const _ListContainer(),
                ),
                SliverToBoxAdapter(
                  child: PaginationLoadingIndicator(
                    controller: legacy.Provider.of<VendorProductsViewModel>(
                      context,
                      listen: false,
                    ).paginationController,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListContainer extends ConsumerWidget {
  const _ListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return legacy.Selector<VendorProductsViewModel, List<String>>(
      selector: (context, d) => d.productsList,
      shouldRebuild: (a, b) => a.length != b.length,
      builder: (context, list, _) {
        final screenData = ref.read(providerOfVendorDetailsScreenLayoutData);
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
  final AppVendorScreenData screenData;
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
  final AppVendorScreenData screenData;
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
    ));
  }
}
