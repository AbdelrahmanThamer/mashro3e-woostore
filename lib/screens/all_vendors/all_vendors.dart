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
import 'package:woocommerce/models/vendor.dart';

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../providers/utils/viewStateController.dart';
import '../../services/pagination/pagination.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/vendor_card/vendor_card.dart';
import 'viewModel/view_model.dart';

class AllVendorsScreenLayout extends ConsumerWidget {
  const AllVendorsScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppAllVendorsScreenData screenData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return legacy.ChangeNotifierProvider(
      create: (context) => AllVendorsViewModel(screenData: screenData),
      child: Scaffold(
        body: Builder(builder: (context) {
          return CustomScrollView(
            controller: ref
                .read(legacy.Provider.of<AllVendorsViewModel>(
                  context,
                  listen: false,
                ).paginationController.notifier)
                .scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              if (screenData.appBarData.show)
                SliverAppBarLayout(
                  data: screenData.appBarData,
                  overrideTitle: '${S.of(context).all} Vendors',
                ),
              SliverViewStateController<AllVendorsViewModel>(
                fetchData: legacy.Provider.of<AllVendorsViewModel>(
                  context,
                  listen: false,
                ).fetchData,
                builder: () => const _ListContainer(),
              ),
              SliverToBoxAdapter(
                child: PaginationLoadingIndicator(
                  controller: legacy.Provider.of<AllVendorsViewModel>(
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
    return legacy.Selector<AllVendorsViewModel, List<Vendor>>(
      selector: (context, d) => d.vendorsList,
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
        final screenData = legacy.Provider.of<AllVendorsViewModel>(
          context,
          listen: false,
        ).screenData;
        if (screenData.itemListConfig.listType == ItemListType.grid) {
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
  final AppAllVendorsScreenData screenData;
  final List<Vendor> list;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenData.itemListConfig.gridColumns,
        childAspectRatio: screenData.itemListConfig.aspectRatio,
        crossAxisSpacing: screenData.itemListConfig.itemPadding,
        mainAxisSpacing: screenData.itemListConfig.itemPadding,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return _ItemCard(
            layoutData: screenData.vendorCardLayoutData,
            vendor: list[i],
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
  final AppAllVendorsScreenData screenData;
  final List<Vendor> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: screenData.itemListConfig.itemPadding,
            ),
            child: _ItemCard(
              layoutData: screenData.vendorCardLayoutData,
              vendor: list[i],
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    Key? key,
    required this.layoutData,
    required this.vendor,
  }) : super(key: key);

  final VendorCardLayoutData layoutData;
  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: NavigationAction(
          navigationData: const NavigationData(
            screenName: AppPrebuiltScreensNames.vendor,
            screenId: AppPrebuiltScreensId.vendor,
          ),
          arguments: {'vendorData': vendor},
        ),
      )?.call(),
      child: VendorCardLayout(
        layoutData: layoutData,
        data: vendor,
      ),
    );
  }
}
