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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/vendor.dart';

import '../../../app_builder/app_builder.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../shared/customLoader.dart';
import '../../../shared/widgets/error/errorReload.dart';
import '../../shared/vendor_card/vendor_card.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';
import 'shared/section_title.dart';

class VendorSectionLayout extends ConsumerWidget {
  const VendorSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final VendorSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Vendor> list =
        ref.read(providerOfVendorSectionNotifier(data)).vendorsList;

    if (list.isEmpty) {
      return _BodyWithoutData(data: data);
    }
    return _Body(data: data, list: list);
  }
}

class _BodyWithoutData extends ConsumerWidget {
  const _BodyWithoutData({
    Key? key,
    required this.data,
  }) : super(key: key);
  final VendorSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(providerOfVendorSectionNotifier(data));

    if (state.status == VendorSectionStatus.undefined) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    if (state.status == VendorSectionStatus.loading) {
      return const SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: CustomLoader(),
      ));
    }

    if (state.status == VendorSectionStatus.error) {
      return SliverToBoxAdapter(
        child: ErrorReload(
          errorMessage: state.errorMessage ?? S.of(context).somethingWentWrong,
          reloadFunction: ref
              .read(providerOfVendorSectionNotifier(data).notifier)
              .fetchVendor,
        ),
      );
    }

    if (state.status == VendorSectionStatus.noData) {
      Dev.warn('Vendor Section No data available');
      return const SliverToBoxAdapter(child: SizedBox());
    }

    return _Body(data: data, list: state.vendorsList);
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    Key? key,
    required this.data,
    required this.list,
  }) : super(key: key);
  final VendorSectionData data;
  final List<Vendor> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.vendorCardLayoutData.styledData.dimensionsData,
        itemBuilder: (context, i) {
          return _ItemCard(sectionData: data, vendorData: list[i]);
        },
      ),
    );

    if (data.layout == SectionLayout.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return _ItemCard(sectionData: data, vendorData: list[i]);
        },
      );
    }

    if (data.layout == SectionLayout.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.vendorCardLayoutData.styledData.dimensionsData,
        columns: data.columns,
        spacing: 0,
        itemBuilder: (context, i) {
          return _ItemCard(sectionData: data, vendorData: list[i]);
        },
      );
    }

    if (isNotBlank(data.title) || data.enableShowAllButton) {
      return SliverSectionLayoutDecorator(
        styledData: data.styledData,
        sliver: MultiSliver(
          children: [
            SectionTitle(
              title: data.title,
              showAllButton: data.enableShowAllButton,
              showAllButtonOnPressed: () => ParseEngine.createAction(
                context: context,
                action: const NavigationAction(
                  navigationData: NavigationData(
                    screenName: AppPrebuiltScreensNames.allVendors,
                    screenId: AppPrebuiltScreensId.allVendors,
                  ),
                ),
              )?.call(),
            ),
            listWidget,
          ],
        ),
      );
    }

    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: listWidget,
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    Key? key,
    required this.sectionData,
    required this.vendorData,
  }) : super(key: key);

  final VendorSectionData sectionData;
  final Vendor vendorData;

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
          arguments: {'vendorData': vendorData},
        ),
      )?.call(),
      child: VendorCardLayout(
        layoutData: sectionData.vendorCardLayoutData,
        data: vendorData,
      ),
    );
  }
}

final providerOfVendorSectionNotifier = StateNotifierProvider.autoDispose
    .family<VendorSectionNotifier, VendorSectionState, VendorSectionData>(
        (ref, sectionData) {
  ref.maintainState = true;
  return VendorSectionNotifier(sectionData);
});

class VendorSectionNotifier extends StateNotifier<VendorSectionState> {
  VendorSectionNotifier(
    this.sectionData,
  ) : super(const VendorSectionState()) {
    fetchVendor();
  }

  final VendorSectionData sectionData;

  Future<void> fetchVendor() async {
    try {
      state = state.copyWith(status: VendorSectionStatus.loading);

      // Fetch data from backend
      final List<Vendor>? result =
          await LocatorService.wooService().fetchVendors(
        includes: sectionData.vendors.map((e) => e.id).toList().cast<int>(),
        featured: sectionData.showBestSelling,
        orderBy: sectionData.showTopRated ? 'rating_desc' : null,
      );

      if (result == null || result.isEmpty) {
        if (state.vendorsList.isNotEmpty) {
          state = state.copyWith(status: VendorSectionStatus.hasData);
        } else {
          state = state.copyWith(status: VendorSectionStatus.noData);
        }
      }

      if (result!.isNotEmpty) {
        state = state.copyWith(
          vendorsList: result,
          status: VendorSectionStatus.hasData,
        );
      }
    } catch (e, s) {
      Dev.error(
        'Fetch Dynamic Vendor Section State Notifier',
        error: e is DioError ? e.response?.data : e,
        stackTrace: s,
      );
      state = state.copyWith(
        status: VendorSectionStatus.noData,
        errorMessage: ExceptionUtils.renderException(e),
      );
    }
  }
}

@immutable
class VendorSectionState {
  final List<Vendor> vendorsList;
  final VendorSectionStatus status;
  final String? errorMessage;

  const VendorSectionState({
    this.vendorsList = const [],
    this.status = VendorSectionStatus.undefined,
    this.errorMessage,
  });

  VendorSectionState copyWith({
    List<Vendor>? vendorsList,
    VendorSectionStatus? status,
    String? errorMessage,
  }) {
    return VendorSectionState(
      vendorsList: vendorsList ?? this.vendorsList,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

enum VendorSectionStatus {
  loading,
  hasData,
  noData,
  error,
  undefined,
}
