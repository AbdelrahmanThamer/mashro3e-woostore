// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../developer/dev.log.dart';
import '../../../enums/enums.dart';
import '../../../locator.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../providers/utils/viewStateController.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../models/homeSectionDataHolder.dart';
import '../utils/homeUtils.dart';

export '../models/homeSectionDataHolder.dart';

/// Acts as a data holder class with notification capabilities for dynamic
/// `Custom Home Section Views` and related products.
///
/// ## Main Usage:
///
/// Stored in a Map<String, HomeSectionViewModel> inside `HomeViewModel` as
/// a value for dynamic Custom Section fetched from the backend.
class HomeSectionViewModel extends BaseProvider {
  HomeSectionViewModel({
    @required HomeSectionDataHolder dataHolder,
  })  : productTag = dataHolder.tag,
        productCategory = dataHolder.category {
    Dev.info(
        'Creating HomeSectionViewModel\nCategory Id ${productCategory?.id}\nCategory Name ${productCategory?.name}\n\nTag Id ${productTag?.id}\nTag Name ${productTag?.name}');
  }

  @override
  void dispose() {
    Dev.info('Disposing HomeSectionViewModel');
    super.dispose();
  }

  /// Products tag object
  final WooProductTag productTag;

  /// Products category object
  final WooProductCategory productCategory;

  /// IDs of the products fetched under products, tag
  Set<String> _productsList = const {};

  /// Getter for products list
  List<String> get productsList => _productsList.toList();

  /// Small list of products to the shown on the home page
  Set<String> _smallProductsList = const {};

  /// Getter of the small list of products
  List<String> get smallProductsList => _smallProductsList.toList();

  /// Fetch the data for products tags
  Future<FetchActionResponse> fetchProducts() async {
    if (productTag == null && productCategory == null) {
      notifyError();
      throw Exception('Both Product category and Product Tag cannot be null!');
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'fetchProducts',
      className: 'HomeSectionViewModel',
      start: true,
      fileName: 'homeSection.viewModel.dart',
    );

    try {
      // Notify state change
      notifyLoading();
      // Fetch data from backend
      final List<WooProduct> result =
          await LocatorService.wooService().wc.getProducts(
                tag: productTag != null ? productTag.id.toString() : '',
                category: productCategory != null
                    ? productCategory.id.toString()
                    : '',
                page: 1,
                perPage: 10,
              );
      if (result == null) {
        notifyError();
        return FetchActionResponse.Failed;
      }

      if (result.isEmpty) {
        notifyState(ViewState.NO_DATA_AVAILABLE);
        return FetchActionResponse.NoDataAvailable;
      }

      // Set the data to product list
      _productsList = HomeUtils.processProductsData(
        list: result,
        dataHolder: _productsList,
      );

      // Adds data to the small list
      _addToSmallList(_productsList);

      // Notify state change
      notifyState(ViewState.DATA_AVAILABLE);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchProducts',
        className: 'HomeSectionViewModel',
        start: false,
        fileName: 'homeSection.viewModel.dart',
      );
      return FetchActionResponse.Successful;
    } catch (e, s) {
      Dev.error('Could not get PopularProducts', error: e, stackTrace: s);

      // Notify state change
      notifyError(message: e.toString());

      return FetchActionResponse.Failed;
    }
  }

  /// Set the list provided as the product list in tags provider
  void setProductList(List<String> list) {
    if (list != null && list.isNotEmpty) {
      final Set<String> tempSet = Set.from(list);
      _productsList = tempSet;

      // Adds data to the small list
      _addToSmallList(tempSet);
    }
  }

  //**********************************************************
  //  Helper Functions
  //**********************************************************

  /// Add 10 items to the small list from the data set
  void _addToSmallList(Set<String> productsList) {
    if (productsList.isNotEmpty) {
      _smallProductsList = productsList.take(10).toSet();
    }
  }
}

/// Wrapper widget to initialize the dynamic home section view model
class RenderHomeSectionProducts extends StatefulWidget {
  const RenderHomeSectionProducts({
    Key key,
    @required this.homeSectionDataHolder,
    @required this.child,
  }) : super(key: key);
  final HomeSectionDataHolder homeSectionDataHolder;
  final Widget child;

  @override
  _RenderHomeSectionProductsState createState() =>
      _RenderHomeSectionProductsState();
}

class _RenderHomeSectionProductsState extends State<RenderHomeSectionProducts> {
  @override
  void initState() {
    super.initState();

    // Add the `ProductTag` to `HomeViewModel.homeSectionsMap` to
    // initialize the `HomeSectionViewModel`
    LocatorService.homeViewModel()
        .addHomeSectionToMap(widget.homeSectionDataHolder);
  }

  @override
  Widget build(BuildContext context) {
    final p = LocatorService.homeViewModel()
        .homeSectionsMap[widget.homeSectionDataHolder.id];
    if (p == null) {
      Dev.warn(
          'RenderHomeSectionProducts ==> No Provider found, returning empty box');
      Dev.warn(widget.homeSectionDataHolder.toString());
      return const SizedBox();
    }
    return ChangeNotifierProvider<HomeSectionViewModel>.value(
      value: p,
      child: ViewStateController<HomeSectionViewModel>(
        fetchData: p.fetchProducts,
        child: widget.child,
      ),
    );
  }
}
