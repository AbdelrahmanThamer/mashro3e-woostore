// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woocommerce/models/products.dart';

import '../../app_builder/app_builder.dart';
import '../../locator.dart';
import '../../models/models.dart';

final providerOfDynamicSectionProductsNotifier =
    StateNotifierProvider.autoDispose.family<DynamicSectionProductsNotifier,
        DynamicSectionState, LoadProductsConfigData>((ref, productsConfigData) {
  ref.maintainState = true;
  return DynamicSectionProductsNotifier(productsConfigData);
});

class DynamicSectionProductsNotifier
    extends StateNotifier<DynamicSectionState> {
  DynamicSectionProductsNotifier(
    this.productsConfigData,
  ) : super(const DynamicSectionState()) {
    fetchProducts();
  }

  final LoadProductsConfigData productsConfigData;

  Future<void> fetchProducts() async {
    try {
      state = state.copyWith(status: DynamicSectionStatus.loading);

      // Fetch data from backend
      final List<WooProduct>? result =
          await LocatorService.wooService().wc.getProducts(
                tag: productsConfigData.tag.tagId,
                category: productsConfigData.category.categoryId,
                include: productsConfigData.include
                    .map((e) => int.tryParse(e.id) ?? 0)
                    .toList()
                    .cast<int>(),
                minPrice: productsConfigData.minPrice,
                maxPrice: productsConfigData.maxPrice,
                featured: productsConfigData.featured,
                onSale: productsConfigData.onSale,
                page: 1,
              );

      if (result == null || result.isEmpty) {
        if (state.productsList.isNotEmpty) {
          state = state.copyWith(status: DynamicSectionStatus.hasData);
        } else {
          state = state.copyWith(status: DynamicSectionStatus.noData);
        }
      }

      if (result!.isNotEmpty) {
        final tempList = processProductsData(
          list: result,
          dataHolder: state.productsList,
        );
        state = state.copyWith(
          productsList: tempList,
          status: DynamicSectionStatus.hasData,
        );
      }
    } catch (e, s) {
      Dev.error(
        'Fetch Products Dynamic Section Products State Notifier',
        error: e,
        stackTrace: s,
      );
      state = state.copyWith(
        status: DynamicSectionStatus.error,
        errorMessage: ExceptionUtils.renderException(e),
      );
    }
  }

  static Set<String> processProductsData({
    required List<WooProduct> list,
    required Set<String> dataHolder,
  }) {
    Dev.debugFunction(
      functionName: 'processProductsData',
      className: 'DynamicSectionProductsNotifier',
      start: true,
      fileName: 'state.dart',
    );
    final Set<String> result = {};
    if (list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        if (dataHolder.contains(list[i].id.toString())) {
          result.add(list[i].id.toString());
          continue;
        }
        final Product p = Product.fromWooProduct(list[i]);
        result.add(p.id.toString());
        LocatorService.productsProvider().addToMap(p);
      }
    }
    Dev.debugFunction(
      functionName: 'processProductsData',
      className: 'DynamicSectionProductsNotifier',
      start: false,
      fileName: 'state.dart',
    );
    return result;
  }
}

@immutable
class DynamicSectionState {
  final Set<String> productsList;
  final DynamicSectionStatus status;
  final String? errorMessage;

  const DynamicSectionState({
    this.productsList = const {},
    this.status = DynamicSectionStatus.undefined,
    this.errorMessage,
  });

  DynamicSectionState copyWith({
    Set<String>? productsList,
    DynamicSectionStatus? status,
    String? errorMessage,
  }) {
    return DynamicSectionState(
      productsList: productsList ?? this.productsList,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

enum DynamicSectionStatus {
  loading,
  hasData,
  noData,
  error,
  undefined,
}
