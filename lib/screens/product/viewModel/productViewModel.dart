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

// ignore_for_file: unnecessary_null_comparison

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../controllers/uiController.dart';
import '../../../developer/dev.log.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../models/models.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../utils/utils.dart';
import '../exceptions/noVariationFound.dart';

late AutoDisposeChangeNotifierProvider<ProductViewModel>
    providerOfProductViewModel;

class ProductViewModel extends ChangeNotifier {
  /// This build context of the widget
  final BuildContext context;

  /// The product for which all the related variations are to be fetched
  Product currentProduct;

  final AppProductScreenData screenData;

  /// All the variations related to this product
  List<WooProductVariation> productVariations = [];

  /// Selected variation to show variation specific values
  WooProductVariation? selectedVariation;

  /// Populate this if there is no variation found
  NoVariationFoundError? noVariationFoundError;

  /// The reward points earned for the product or variation selected.
  int points = 0;

  ProductViewModel({
    required this.context,
    required this.currentProduct,
    required this.screenData,
  }) {
    initialize();
  }

  @override
  void dispose() {
    currentProduct.selectedAttributesNotifier
        .removeListener(_variationSizeListener);
    super.dispose();
  }

  /// Start the products data fetching and syncing
  void initialize() {
    if (currentProduct.wooProduct.variations != null) {
      if (currentProduct.wooProduct.variations?.isNotEmpty ?? false) {
        // Add variation change listeners
        currentProduct.selectedAttributesNotifier
            .addListener(_variationSizeListener);
        fetchProductVariations();
      }
    }

    // add to recent products
    LocatorService.productsRepository().addToRecentProducts(currentProduct);
  }

  /// Get the data from the product
  Future<void> fetchProductDetails() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchProductDetails',
      className: 'ProductViewModel',
      fileName: 'productViewModel.dart',
      start: true,
    );

    try {
      final WooProduct? result =
          await LocatorService.wooService().wc.getProductById(
                id: int.parse(currentProduct.id.toString()),
              );

      currentProduct = currentProduct.copyWithWooProduct(result);
      // Add the updated or new fetched product to the map
      LocatorService.productsProvider().addToMap(currentProduct);
      notifyListeners();

      // Call to fetch the points for the simple product.
      fetchPointsForSimpleProduct(currentProduct.wooProduct.id!);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchProductDetails',
        className: 'ProductViewModel',
        fileName: 'productViewModel.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Fetch Product Details Error', error: e, stackTrace: s);
      final lang = S.of(context);
      UiController.showErrorNotification(
        context: context,
        title: lang.error,
        message: isNotBlank(Utils.renderException(e))
            ? Utils.renderException(e)
            : lang.somethingWentWrong,
      );
    }
  }

  /// Fetch the variations for a product after loading it on the screen
  Future<void> fetchProductVariations() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchProductVariations',
      className: 'ProductViewModel',
      fileName: 'productViewModel.dart',
      start: true,
    );

    try {
      final result = await LocatorService.wooService().wc.getProductVariations(
            productId: int.parse(currentProduct.id.toString()),
            perPage: 100,
          );

      productVariations = result;

      // Save the variations in the product
      currentProduct.variations = result.toSet();

      // After the product variations are fetched, set the default product
      // variation in the product model
      setVariation();

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchProductVariations',
        className: 'ProductViewModel',
        fileName: 'productViewModel.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Fetch product variation error', error: e, stackTrace: s);
      final lang = S.of(context);
      UiController.showErrorNotification(
        context: context,
        title: lang.error,
        message: isNotBlank(Utils.renderException(e))
            ? Utils.renderException(e)
            : lang.somethingWentWrong,
      );
    }
  }

  /// Refresh the page and get the product variations again
  Future<void> refresh() async {
    try {
      // TODO(AniketMalik): Check if this is okay to remove
      if (currentProduct.variations != null) {
        if (currentProduct.variations.isNotEmpty) {
          await fetchProductVariations();
        } else {
          await fetchProductDetails();
          return;
        }
      } else {
        await fetchProductDetails();
      }
    } catch (e) {
      Future.error(e);
      Dev.error('Product screen Refresh', error: e);
    }
  }

  //**********************************************************
  // Product Points related functionality
  //**********************************************************

  /// Fetches the product points and updates the ui with the
  /// new points
  Future<void> fetchPointsForSimpleProduct(int productId) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'fetchPointsForSimpleProduct',
        className: 'ProductViewModel',
        fileName: 'productViewModel.dart',
        start: true,
      );

      if (!ParseEngine.enabledPointsAndRewards) {
        Dev.debug('Points functionality is disabled, returning');
        return;
      }

      final result =
          await LocatorService.wooService().wc.getProductPoints(productId);

      if (result != null && result > 0) {
        points = result;
        // notify the listeners
        notifyListeners();
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchPointsForSimpleProduct',
        className: 'ProductViewModel',
        fileName: 'productViewModel.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Fetch Points error', error: e, stackTrace: s);
    }
  }

  /// Fetches the product points for the variation and updates the ui with the
  /// new points
  Future<void> fetchPointsForVariation(int variationId) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'fetchPointsForVariation',
        className: 'ProductViewModel',
        fileName: 'productViewModel.dart',
        start: true,
      );

      if (!ParseEngine.enabledPointsAndRewards) {
        Dev.debug('Points functionality is disabled, returning');
        return;
      }

      final result =
          await LocatorService.wooService().wc.getProductPoints(variationId);

      if (result != null && result > 0) {
        points = result;
        // notify the listeners
        notifyListeners();
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchPointsForVariation',
        className: 'ProductViewModel',
        fileName: 'productViewModel.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Fetch Points error', error: e, stackTrace: s);
    }
  }

  //**********************************************************
  //  Helper Functions
  //**********************************************************

  void addProductSelectedAddon(ProductSelectedAddon addon) {
    currentProduct.addProductAddon(addon);
  }

  /// Listener for size and color changes
  void _variationSizeListener() {
    // Function Log
    Dev.debugFunction(
      functionName: '_sizeOrColorChangeListener',
      className: 'ProductViewModel',
      fileName: 'productViewModel.dart',
      start: true,
    );

    setVariation();

    // Function Log
    Dev.debugFunction(
      functionName: '_sizeOrColorChangeListener',
      className: 'ProductViewModel',
      fileName: 'productViewModel.dart',
      start: false,
    );
  }

  /// Set the variation in the product data class and this view model
  /// and notify listeners
  void setVariation() {
    final v = findVariation();
    // There is no variation linked to this product combination
    if (v == null) {
      noVariationFoundError = const NoVariationFoundError();
      selectedVariation = v;
      notifyListeners();
      final lang = S.maybeOf(context);
      UiController.showErrorNotification(
        context: context,
        title: lang?.noVariationFound ?? 'No variation found',
        message: lang?.noVariationFoundMessage ??
            'Could not find the variation at this moment',
      );

      return;
    }
    currentProduct.setSelectedProductVariation(v);
    selectedVariation = v;
    noVariationFoundError = null;
    notifyListeners();

    // After the variation is found, fetch the points for that variation
    fetchPointsForVariation(v.id!);
  }

  //**********************************************************
  // Experimental
  //**********************************************************

  WooProductVariation? findVariation() {
    if (currentProduct.selectedAttributesNotifier.value.isEmpty) {
      final temp = <String, dynamic>{};
      for (final element in productVariations.first.attributes ?? const []) {
        temp.addAll({element.name: element.option});
      }
      currentProduct.updateSelectedAttributes(temp);
      return productVariations.first;
    }

    final List<Map> variationAttributeList = [];
    for (final element in productVariations) {
      final temp = {'id': element.id, 'attributes': {}};
      for (final e2 in element.attributes ?? const []) {
        (temp['attributes'] as Map).addAll({e2.name: e2.option});
      }
      variationAttributeList.add(temp);
    }

    int id = 0;
    for (final element in variationAttributeList) {
      if (mapEquals(
          (element['attributes'] as Map).map((key, value) => MapEntry(
              Product.attributeKey(key), Product.attributeValue(value))),
          currentProduct.selectedAttributesNotifier.value.map((key, value) =>
              MapEntry(
                  Product.attributeKey(key), Product.attributeValue(value))))) {
        id = element['id'];
      }
    }

    return productVariations.firstWhereOrNull((element) => element.id == id);
  }

  List<WooProductCategory> filterCategories(
      List<WooProductCategory>? unfilteredList) {
    if (unfilteredList == null || unfilteredList.isEmpty) {
      return const [];
    }
    final list = unfilteredList;
    list.removeWhere((element) =>
        element.name?.toLowerCase() == 'uncategorized' ||
        element.name?.toLowerCase() == 'uncategorised');
    return list;
  }
}

/// Change notifier to get the reviews of the product view model
class PVMReviewNotifier extends ChangeNotifier {
  PVMReviewNotifier(this.productId) {
    fetchProductReviews();
    currentProduct = LocatorService.productsProvider().productsMap[productId];
  }

  /// The product for which all the related variations are to be fetched
  String productId;
  late Product? currentProduct;

  /// ALl the product reviews
  List<WooProductReview> reviews = [];

  /// Fetch the product reviews
  Future<void> fetchProductReviews() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchProductReviews',
      className: 'PVMReviewNotifier',
      fileName: 'productViewModel.dart',
      start: true,
    );

    try {
      _onLoading(true);
      final int id = int.tryParse(productId) ?? 0;
      if (id <= 0) {
        _onError('No product id found');
        return;
      }

      final List<WooProductReview>? result =
          await LocatorService.wooService().wc.getProductReviews(product: [id]);

      if (result == null) {
        _onSuccessful(hasData: false);

        // Function Log
        Dev.debugFunction(
          functionName: 'fetchProductReviews',
          className: 'PVMReviewNotifier',
          fileName: 'productViewModel.dart',
          start: false,
        );

        return;
      }

      if (result.isNotEmpty) {
        reviews = result;
        currentProduct?.ratingCount.value = reviews.length;
        _onSuccessful();
      } else {
        reviews = [];
        _onSuccessful(hasData: false);
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchProductReviews',
        className: 'PVMReviewNotifier',
        fileName: 'productViewModel.dart',
        start: false,
      );
    } catch (e) {
      Future.value(e.toString());
      _onError(Utils.renderException(e));
      Dev.error('Product Review fetch error', error: e);
    }
  }

  /// Refresh
  Future<void> onRefresh() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'onRefresh',
      className: 'PVMReviewNotifier',
      fileName: 'productViewModel.dart',
      start: true,
    );

    try {
      final int id = int.tryParse(productId) ?? 0;
      if (id <= 0) {
        _onError('No product id found');
        return;
      }

      final List<WooProductReview>? result =
          await LocatorService.wooService().wc.getProductReviews(product: [id]);

      if (result == null) {
        _onSuccessful(hasData: false);

        // Function Log
        Dev.debugFunction(
          functionName: 'onRefresh',
          className: 'PVMReviewNotifier',
          fileName: 'productViewModel.dart',
          start: false,
        );

        return;
      }

      if (result.isNotEmpty) {
        reviews = result;
        _onSuccessful();
      } else {
        _onSuccessful(hasData: false);
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'onRefresh',
        className: 'PVMReviewNotifier',
        fileName: 'productViewModel.dart',
        start: false,
      );
    } catch (e) {
      Future.value(e.toString());
      if (reviews.isEmpty) {
        _onError(Utils.renderException(e));
      }
      Dev.error('Refresh Product Reviews error', error: e);
    }
  }

  void addToReviews(WooProductReview review) {
    reviews = [review, ...reviews];
    _onSuccessful(hasData: true);
    currentProduct?.ratingCount.value = reviews.length;
  }

  //**********************************************************
  //  Events
  //**********************************************************

  /// Loading event
  bool _isLoading = true;

  /// Get the loading value
  bool get isLoading => _isLoading;

  /// Success flag to verify if data fetching event was successfully.
  bool _isSuccess = false;

  /// Get the success value
  bool get isSuccess => _isSuccess;

  /// Flag to show if data is available
  bool _hasData = false;

  /// Getter for the data availability flag
  bool get hasData => _hasData;

  /// Error flag for any error while fetching
  bool _isError = false;

  /// Get the error value
  bool get isError => _isError;

  /// Error message
  String _errorMessage = '';

  /// Get the error message value
  String get errorMessage => _errorMessage;

  //**********************************************************
  //  Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful({bool hasData = true}) {
    _isLoading = false;
    _isSuccess = true;
    _isError = false;
    _hasData = hasData;
    _errorMessage = '';
    notifyListeners();
  }

  /// Notifies about the error
  void _onError(String message) {
    _isLoading = false;
    _isSuccess = false;
    _isError = true;
    _errorMessage = message;
    notifyListeners();
  }
}

@immutable
class ProductViewModelArguments {
  final BuildContext context;
  final Product product;
  final AppProductScreenData screenData;

  const ProductViewModelArguments({
    required this.context,
    required this.product,
    required this.screenData,
  });
}
