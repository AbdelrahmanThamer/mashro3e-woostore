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
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/coupon.dart';
import 'package:woocommerce/models/order.dart' as woo_order_model;
import 'package:woocommerce/models/order_payload.dart';

import '../../../controllers/navigationController.dart';
import '../../../locator.dart';
import '../../../models/models.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../shared/dialogs/error_dialog.dart';
import '../../../shared/widgets/loadingIndicators/dialog_loading_indicator.dart';
import '../../../utils/api_utils.dart';
import '../../../utils/utils.dart';
import '../../product/widgets/file_upload_progress_dialog.dart';
import 'mixins/coupon_mixin.dart';
import 'mixins/customer_note.dart';
import 'states.dart';

class CartViewModel with ChangeNotifier, CouponMixin, CustomerNoteMixin {
  bool get isGuestCart => isBlank(LocatorService.userProvider().user.id);
  bool isAlreadyMerged = false;

  /// The cart error states
  CartErrorState _cartErrorState;

  CartErrorState get cartErrorState => _cartErrorState;

  /// WooCommerce Service for the cart actions
  final WooService wooService = LocatorService.wooService();

  /// Map of products to store all the products information in a single big
  /// object
  Map<String, CartProduct> _productsMap = {};

  /// Getter for products map
  Map<String, CartProduct> get productsMap => _productsMap;

  /// Tracks the total number of items in the cart
  int _totalItems = 0;

  int get totalItems => _totalItems;

  /// Total cost of all the products.
  double _totalCost = 0.0;

  String get subTotal => _totalCost.toStringAsFixed(2);

  double get discount {
    // Check for any applied coupon
    if (isNotBlank(selectedCoupon.value.amount)) {
      if (selectedCoupon.value.couponType == WooCouponType.percentDiscount) {
        try {
          return double.tryParse(selectedCoupon.value.amount!)! *
              _totalCost /
              100;
        } catch (e) {
          Dev.error('cannot calculate coupon discount in percent', error: e);
          return 0;
        }
      } else {
        try {
          return double.tryParse(selectedCoupon.value.amount!)!;
        } catch (e) {
          Dev.error('cannot calculate coupon discount as fixed', error: e);
          return 0;
        }
      }
    }
    return 0;
  }

  String get discountString => discount.toStringAsFixed(2);

  String get totalCost {
    // final double result = _totalCost - discount;
    // return result.toStringAsFixed(2);
    return totalFromCart.toStringAsFixed(2);
  }

  /// value from cart
  double totalFromCart = 0.0;

  CartViewModel() : _cartErrorState = const CartEmptyState() {
    getCart();
  }

  /// Reset the cart after user logs out
  void resetCart() {
    // Function Log
    Dev.debugFunction(
      functionName: 'resetCart',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );
    _cartErrorState = const CartEmptyState();
    _errorMessage = '';
    _productsMap = {};
    _totalItems = 0;
    _totalCost = 0.0;
    clearCustomerNote();
    clearCoupon();
    // Function Log
    Dev.debugFunction(
      functionName: 'resetCart',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: false,
    );
  }

  /// Get the cart for the application
  Future<void> getCart() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'getCart',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );

    try {
      if (isGuestCart) {
        // handle guest cart
        handleGuestCart();
        return;
      }

      _onLoading(true);
      final WooStoreProCartData result = await wooService.cart.getCart();

      _mayBeShowErrorForCartItemActionResponse(result);

      if (result.items.isEmpty) {
        _productsMap = {};
        _totalItems = 0;
        _calculateCost();
        _onError('', errorState: const CartEmptyState());
        return;
      }

      // items are not present in productsMap
      // then fetch the products absent and add them
      _createCartProducts(result.items);

      _totalItems = _productsMap.length;

      _calculateCost();
      totalFromCart = result.total;

      // Now update the UI
      _onSuccessful();

      // Function Log
      Dev.debugFunction(
        functionName: 'getCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );
    } on WooStoreProCartException catch (e) {
      Dev.error('Get Cart', error: e);
      _onError(
        e.message,
        errorState: const CartErrorState(),
      );
    } catch (e, s) {
      _onError(
        e is DioError
            ? ApiUtils.handleDioError(e)['message']
            : Utils.renderException(e),
        errorState: const CartLoginMessageState(),
      );
      Dev.error('Get Cart error', error: e, stackTrace: s);
    }
  }

  /// Clears the cart data from the backend
  Future<bool> clearCart() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'clearCart',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );
    try {
      resetCart();
      // Function Log
      Dev.debugFunction(
        functionName: 'clearCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );
      notifyListeners();
      if (!isGuestCart) {
        await wooService.cart.clearCart();
      }
      return true;
    } catch (e, s) {
      Dev.error('Clear cart', error: e, stackTrace: s);
      notifyListeners();
      return false;
    }
  }

  /// Takes in a product id --> search for the product in products provider -->
  /// create a `CartProduct` --> then save it in the cart map and update the
  /// reference list with [total items] and [total cost].
  Future<bool> addToCart(String id) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'addToCart',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );

    final Product? p = LocatorService.productsProvider().productsMap[id];
    if (p == null) {
      throw Exception('Product cannot be found');
    }

    final canAddToCart = await checkPrerequisites(p);
    if (!canAddToCart) {
      return false;
    }

    CartProduct cartProduct = CartProduct.fromProduct(p);

    // If the item is being added the first time then continue.
    try {
      // handle guest cart
      if (isGuestCart) {
        return await guestAddToCart(id);
      }

      _onLoading(true);
      _showLoadingDialog();
      final WooStoreProCartItemActionResponseData? result =
          await wooService.cart.addItem(
        p.createAddItemRequestData(),
      );

      if (result == null) {
        // Notify error and return
        _onError('', errorState: const CartGeneralErrorState());
        return false;
      }

      cartProduct = CartProduct.fromWooStoreProCartItemData(
        cartItem: result.item,
      );

      // Adding to products map
      _productsMap.addAll({
        cartProduct.cartItemKey!: cartProduct,
      });

      /// Update total items in cart
      _totalItems = productsMap.length;

      /// Update the total cost
      _calculateCost();
      totalFromCart = result.total;

      _onSuccessful();

      // Function Log
      Dev.debugFunction(
        functionName: 'addToCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );

      return true;
    } on WooStoreProCartException catch (e) {
      _onError(e.toString());
      _handleExceptionOnAddToSync(exception: e, cartProduct: cartProduct);
      Dev.error('WooStoreProCartException Add to cart', error: e);
      await _maybeHideLoadingDialog();
      // show error
      _showErrorDialog([e]);

      return false;
    } catch (e, s) {
      _onError(e is DioError
          ? ApiUtils.handleDioError(e)['message']
          : Utils.renderException(e));
      Dev.error('Add to cart Error', error: e, stackTrace: s);
      await _maybeHideLoadingDialog();
      // show error
      _showErrorDialog([e as Exception]);

      return false;
    } finally {
      _maybeHideLoadingDialog();
    }
  }

  Future<void> removeFromCart(String cartItemKey) async {
    // Remove the product from the map as well
    final cartProduct = _productsMap[cartItemKey];

    final User? user = LocatorService.userProvider().user;

    if (user == null || isBlank(user.id)) {
      // handle guest cart
      await guestRemoveFromCart(cartItemKey);
      return;
    }

    // Update the total cost
    if (cartProduct != null) {
      try {
        _onLoading(true);
        final result = await wooService.cart.removeItems(
          [cartProduct.cartItemKey!],
        );
        _createCartProducts(result.items);
        // Update total items in cart
        _totalItems = productsMap.length;
        _calculateCost();
        totalFromCart = result.total;
        _onSuccessful();
      } on WooStoreProCartException catch (e) {
        _onError(e.toString());
        Dev.error('Remove from cart error', error: e);
      } catch (e) {
        _onError(e is DioError
            ? ApiUtils.handleDioError(e)['message']
            : Utils.renderException(e));
        Dev.error('Remove from cart error: ', error: e);
      }
    } else {
      _onError('Did not find cart product in list');
    }
  }

  Future<void> increaseProductQuantity(String cartItemKey) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'increaseProductQuantity',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );

    final CartProduct cp = _productsMap[cartItemKey]!;
    _onLoading(true);
    final bool result = await _updateCart(cp, increaseQuantity: true);
    if (result) {
      _onSuccessful();
      _calculateCost();
    } else {
      _onError('', errorState: const CartGeneralErrorState());
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'increaseProductQuantity',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: false,
    );
  }

  Future<void> decreaseProductQuantity(String cartItemKey) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'decreaseProductQuantity',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );

    final CartProduct cp = _productsMap[cartItemKey]!;
    _onLoading(true);
    final bool result = await _updateCart(cp, decreaseQuantity: true);
    if (result) {
      _onSuccessful();
      _calculateCost();
    } else {
      _onLoading(false);
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'decreaseProductQuantity',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: false,
    );
  }

  Future<void> setProductQuantity(String cartItemKey, int quantity) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'setProductQuantity',
      className: 'CartViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );

    final CartProduct cp = _productsMap[cartItemKey]!;
    _onLoading(true);
    final bool result = await _updateQuantity(
      cp: cp,
      quantity: quantity,
    );
    if (result) {
      _calculateCost();
      _onSuccessful();
    } else {
      _onLoading(false);
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'setProductQuantity',
      className: 'CartViewModel',
      fileName: 'viewModel.dart',
      start: false,
    );
  }

  /// merge the cart from guest session to the new logged in session
  Future<void> mergeCart() async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'mergeCart',
        className: 'CartViewModel',
        fileName: 'viewModel.dart',
        start: true,
      );

      if (isBlank(wooService.wc.authToken)) {
        Dev.warn('Cannot merge cart without authToken, aborting operation');
        return;
      }
      // create cart for the NOW logged in user
      final cartPayload = WooStoreProGuestCartPayload(
        couponCode: selectedCoupon.value.code,
        lineItems: _createRawWooStoreProCartItems(),
      );

      _onLoading(true);
      final result = await wooService.cart.mergeCart(
        payload: cartPayload,
        jwt: wooService.wc.authToken!,
      );

      isAlreadyMerged = true;

      _mayBeShowErrorForCartItemActionResponse(result);

      if (result.items.isEmpty) {
        _productsMap = {};
        _totalItems = 0;
        _calculateCost();
        _onError('', errorState: const CartEmptyState());
        return;
      }

      // items are not present in productsMap
      // then fetch the products absent and add them
      _createCartProducts(result.items);

      _totalItems = _productsMap.length;

      _calculateCost();
      totalFromCart = result.total;

      // Now update the UI
      _onSuccessful();

      // delete the saved cart items
      await WooStoreProCartDatabaseUtils.deleteAll();

      // Function Log
      Dev.debugFunction(
        functionName: 'mergeCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );
    } on WooStoreProCartException catch (e) {
      Dev.error('Merge Cart ${e.runtimeType}', error: e);
      _onError(
        e.message,
        errorState: const CartErrorState(),
      );
    } catch (e, s) {
      _onError(
        e is DioError
            ? ApiUtils.handleDioError(e)['message']
            : Utils.renderException(e),
        errorState: const CartLoginMessageState(),
      );
      Dev.error('Merge Cart error', error: e, stackTrace: s);
    }
  }

  //**********************************************************
  // Guest Cart functions
  //**********************************************************

  Future<void> handleGuestCart() async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'handleGuestCart',
        className: 'CartViewModel',
        fileName: 'viewModel.dart',
        start: true,
      );

      _onLoading(true);

      // read cart data from DB
      final result = await WooStoreProCartDatabaseUtils.read();

      if (result.isEmpty) {
        _productsMap = {};
        _totalItems = 0;
        _calculateCost();
        _onError('', errorState: const CartEmptyState());
        return;
      }

      // create guest cart from raw cart items
      final guestCartData = await wooService.cart.handleGuestCartData(
        WooStoreProGuestCartPayload(
          couponCode: selectedCoupon.value.code,
          lineItems: result,
        ),
      );

      _mayBeShowErrorForCartItemActionResponse(guestCartData);

      if (guestCartData.items.isEmpty) {
        _productsMap = {};
        _totalItems = 0;
        _calculateCost();
        _onError('', errorState: const CartEmptyState());
        return;
      }

      // items are not present in productsMap
      // then fetch the products absent and add them
      _createCartProducts(guestCartData.items);

      _totalItems = _productsMap.length;

      _calculateCost();
      totalFromCart = guestCartData.total;

      // Now update the UI
      _onSuccessful();
    } catch (e, s) {
      _onError(
        e is DioError
            ? ApiUtils.handleDioError(e)['message']
            : Utils.renderException(e),
        errorState: const CartGeneralErrorState(),
      );
      Dev.error('handle guest cart error', error: e, stackTrace: s);
    }
  }

  Future<bool> guestAddToCart(String productId) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'guestAddToCart',
        className: 'CartViewModel',
        fileName: 'viewModel.dart',
        start: true,
      );

      final Product? p =
          LocatorService.productsProvider().productsMap[productId];
      if (p == null) {
        throw Exception('Product cannot be found');
      }
      final CartProduct cartProduct = CartProduct.fromProduct(p);

      _onLoading(true);
      _showLoadingDialog();
      // create list of raw cart items
      final WooStoreProCartData result =
          await wooService.cart.handleGuestCartData(
        WooStoreProGuestCartPayload(
          couponCode: selectedCoupon.value.code,
          lineItems: _createRawWooStoreProCartItems(newProduct: cartProduct),
        ),
      );

      await _maybeHideLoadingDialog();
      _mayBeShowErrorForCartItemActionResponse(result);

      if (result.items.isEmpty) {
        _productsMap = {};
        _totalItems = 0;
        _calculateCost();
        _onError('', errorState: const CartEmptyState());
        return false;
      }

      // items are not present in productsMap
      // then fetch the products absent and add them
      _createCartProducts(result.items);

      _totalItems = _productsMap.length;

      _calculateCost();
      totalFromCart = result.total;

      // Now update the UI
      _onSuccessful();

      // update the saved cart
      WooStoreProCartDatabaseUtils.save(_createRawWooStoreProCartItems());
      return true;
    } catch (e, s) {
      _onError(
        e is DioError
            ? ApiUtils.handleDioError(e)['message']
            : Utils.renderException(e),
        errorState: const CartGeneralErrorState(),
      );
      Dev.error('guest add to cart error', error: e, stackTrace: s);

      await _maybeHideLoadingDialog();

      _showErrorDialog([e as Exception]);

      return false;
    }
  }

  Future<bool> guestUpdateCart(
    CartProduct cp, {
    bool increaseQuantity = false,
    bool decreaseQuantity = false,
  }) async {
    final int oldQuantity = cp.quantity;
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'guestUpdateCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: true,
      );

      if (increaseQuantity) {
        final bool canIncrease = cp.increaseQuantity();
        // If the quantity is not allowed to be increased then return
        if (!canIncrease) {
          Dev.debug('Increase quantity action not allowed returning');
          return false;
        }

        final result = await wooService.cart.handleGuestCartData(
          WooStoreProGuestCartPayload(
            couponCode: selectedCoupon.value.code,
            lineItems: _createRawWooStoreProCartItems(),
          ),
        );

        _mayBeShowErrorForCartItemActionResponse(result);

        if (result.items.isEmpty) {
          _productsMap = {};
          _totalItems = 0;
          _calculateCost();
          _onError('', errorState: const CartEmptyState());
          return false;
        }

        // items are not present in productsMap
        // then fetch the products absent and add them
        _createCartProducts(result.items);

        _totalItems = _productsMap.length;

        _calculateCost();
        totalFromCart = result.total;

        // Now update the UI
        _onSuccessful();

        // update the saved cart
        WooStoreProCartDatabaseUtils.save(_createRawWooStoreProCartItems());
        return true;
      }
      if (decreaseQuantity) {
        final bool canDecrease = cp.decreaseQuantity();
        if (!canDecrease) {
          Dev.debug('Decrease quantity action not allowed returning');
          return false;
        }

        final result = await wooService.cart.handleGuestCartData(
          WooStoreProGuestCartPayload(
            couponCode: selectedCoupon.value.code,
            lineItems: _createRawWooStoreProCartItems(),
          ),
        );

        if (result.items.isEmpty) {
          _productsMap = {};
          _totalItems = 0;
          _calculateCost();
          _onError('', errorState: const CartEmptyState());
          return false;
        }

        // items are not present in productsMap
        // then fetch the products absent and add them
        _createCartProducts(result.items);

        _totalItems = _productsMap.length;

        _calculateCost();
        totalFromCart = result.total;

        // Now update the UI
        _onSuccessful();

        // update the saved cart
        WooStoreProCartDatabaseUtils.save(_createRawWooStoreProCartItems());
        return true;
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'guestUpdateCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );

      return false;
    } on WooStoreProCartException catch (e) {
      cp.setQuantity = oldQuantity;
      Dev.error('Update Cart Error', error: e);
      // possibly show error to the user
      return false;
    } catch (e, s) {
      cp.setQuantity = oldQuantity;
      Dev.error('Update Cart Error', error: e, stackTrace: s);
      return false;
    }
  }

  Future<void> guestRemoveFromCart(String cartItemKey) async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'guestRemoveFromCart',
        className: 'CartViewModel',
        fileName: 'viewModel.dart',
        start: true,
      );

      // Find if the product is already in the products map
      final bool isAlreadyPresent = _productsMap.containsKey(
        cartItemKey,
      );

      if (isAlreadyPresent) {
        _productsMap.removeWhere(
          (key, value) => value.cartItemKey == cartItemKey,
        );
      }

      _onLoading(true);
      final result = await wooService.cart.handleGuestCartData(
        WooStoreProGuestCartPayload(
          couponCode: selectedCoupon.value.code,
          lineItems: _createRawWooStoreProCartItems(),
        ),
      );

      _mayBeShowErrorForCartItemActionResponse(result);

      // items are not present in productsMap
      // then fetch the products absent and add them
      _createCartProducts(result.items);

      _totalItems = _productsMap.length;

      _calculateCost();
      totalFromCart = result.total;

      // Now update the UI
      _onSuccessful();

      // update the saved cart
      WooStoreProCartDatabaseUtils.save(_createRawWooStoreProCartItems());
    } catch (e, s) {
      Dev.error('guest add to cart error', error: e, stackTrace: s);
    }
  }

  List<RawWooStoreProCartItemData> _createRawWooStoreProCartItems({
    CartProduct? newProduct,
  }) {
    final List<RawWooStoreProCartItemData> list = [];

    if (_productsMap.isNotEmpty) {
      for (final cp in _productsMap.values) {
        list.add(cp.createRawWooStoreProCartItemData());
      }
    }

    if (newProduct != null) {
      list.add(newProduct.createRawWooStoreProCartItemData());
    }
    return list;
  }

  //**********************************************************
  // After login functions
  //**********************************************************

  /// check if the user had any data in the cart product map
  /// if yes, the user was in logged out state and now
  /// has logged in so merge the cart
  /// else just get the cart
  Future<void> getCartAfterLogin() async {
    if (_productsMap.isNotEmpty) {
      await mergeCart();
    } else {
      await getCart();
    }
  }

  //**********************************************************
  //  Private Helper functions
  //**********************************************************

  /// Update the cart based on product update
  Future<bool> _updateQuantity({
    required CartProduct cp,
    required int quantity,
  }) async {
    final int oldQuantity = cp.quantity;
    try {
      // Function Log
      Dev.debugFunction(
        functionName: '_updateQuantity',
        className: 'CartViewModel',
        fileName: 'viewModel.dart',
        start: true,
      );

      if (quantity > 0) {
        // set the product quantity
        cp.setQuantity = quantity;

        final result = await wooService.cart.updateItem(
          cp.createRawWooStoreProCartItemData(),
        );

        if (isNotBlank(result.item.cartItemKey)) {
          final cartProduct = CartProduct.fromWooStoreProCartItemData(
            cartItem: result.item,
          );
          // Adding to products map
          _productsMap.addAll({
            cartProduct.id: cartProduct,
          });
          totalFromCart = result.total;
          return true;
        } else {
          // Notify error and return
          cp.setQuantity = oldQuantity;

          // Function Log
          Dev.debugFunction(
            functionName: '_updateQuantity',
            className: 'CartScreenLayoutViewModel',
            fileName: 'viewModel.dart',
            start: false,
          );

          return false;
        }
      }

      // Function Log
      Dev.debugFunction(
        functionName: '_updateQuantity',
        className: 'CartViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );

      return false;
    } on WooStoreProCartException catch (e) {
      Dev.error('Update Quantity Error', error: e);
      cp.setQuantity = oldQuantity;
      // possibly show error to the user
      return false;
    } catch (e, s) {
      cp.setQuantity = oldQuantity;
      Dev.error('Update Quantity Error', error: e, stackTrace: s);
      return false;
    }
  }

  /// Update the cart based on product update
  Future<bool> _updateCart(
    CartProduct cp, {
    bool increaseQuantity = false,
    bool decreaseQuantity = false,
  }) async {
    if (isGuestCart) {
      return await guestUpdateCart(
        cp,
        increaseQuantity: increaseQuantity,
        decreaseQuantity: decreaseQuantity,
      );
    }

    final int oldQuantity = cp.quantity;
    try {
      // Function Log
      Dev.debugFunction(
        functionName: '_updateCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: true,
      );

      if (increaseQuantity) {
        final bool canIncrease = cp.increaseQuantity();
        // If the quantity is not allowed to be increased then return
        if (!canIncrease) {
          Dev.debug('Increase quantity action not allowed returning');
          return false;
        }

        final result = await wooService.cart.updateItem(
          cp.createRawWooStoreProCartItemData(),
        );

        if (isNotBlank(result.item.cartItemKey)) {
          totalFromCart = result.total;
          return true;
        } else {
          // Notify error and return
          cp.setQuantity = oldQuantity;

          // Function Log
          Dev.debugFunction(
            functionName: '_updateCart',
            className: 'CartScreenLayoutViewModel',
            fileName: 'viewModel.dart',
            start: false,
          );

          return false;
        }
      }

      if (decreaseQuantity) {
        final bool canDecrease = cp.decreaseQuantity();
        if (!canDecrease) {
          Dev.debug('Decrease quantity action not allowed returning');
          return false;
        }
        final result = await wooService.cart.updateItem(
          cp.createRawWooStoreProCartItemData(),
        );

        if (isNotBlank(result.item.cartItemKey)) {
          totalFromCart = result.total;
          return true;
        } else {
          // Notify error and return
          cp.setQuantity = oldQuantity;

          // Function Log
          Dev.debugFunction(
            functionName: '_updateCart',
            className: 'CartScreenLayoutViewModel',
            fileName: 'viewModel.dart',
            start: false,
          );

          return false;
        }
      }

      // Function Log
      Dev.debugFunction(
        functionName: '_updateCart',
        className: 'CartScreenLayoutViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );

      return false;
    } on WooStoreProCartException catch (e) {
      cp.setQuantity = oldQuantity;
      Dev.error('Update Cart Error', error: e);
      // possibly show error to the user
      return false;
    } catch (e, s) {
      cp.setQuantity = oldQuantity;
      Dev.error('Update Cart Error', error: e, stackTrace: s);
      return false;
    }
  }

  /// Calculate the total cost from the list of products
  void _calculateCost() {
    if (_totalItems == 0) {
      _totalCost = 0;
      return;
    }
    double result = 0;
    for (final item in _productsMap.values) {
      if (isNotBlank(item.price)) {
        result += double.parse(item.price!) * item.quantity;
      }
    }
    _totalCost = result;
  }

  /// If the cart item is not present in the list and the API
  /// returns an error, then according to the error status, perform
  /// further actions to keep carts in sync.
  void _handleExceptionOnAddToSync({
    required WooStoreProCartException exception,
    required CartProduct cartProduct,
  }) {
    if (exception.code == 'add_to_cart_error') {
      _productsMap.addAll({cartProduct.id: cartProduct});
    }
  }

  /// Creates cart products and adds them to the products map
  void _createCartProducts(List<WooStoreProCartItemData>? items) {
    // Function Log
    Dev.debugFunction(
      functionName: '_createCartProducts',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );

    final Map<String, CartProduct> _tempCpMap = {};

    if (items != null && items.isNotEmpty) {
      for (final cpi in items) {
        // Instance to add to the local cart
        CartProduct? cp;

        Dev.debug('Working for CPI with cart item key: ${cpi.cartItemKey}');

        Dev.debug('CPI not present in cart, checking in products repo');
        // If the item is not present in local cart then check if it is
        // present in products repository
        final product = LocatorService.productsProvider()
            .productsMap[cpi.product.id.toString()];

        // If item is present in product repo then create cartProduct from it
        // and add it to local cart product map
        if (product != null) {
          Dev.debug('CPI found in local products repo');
          // Check if the WooStoreProCartItemData is of type variation or simple
          if (cpi.variation != null && cpi.variation!.id != null) {
            Dev.debug('CPI is variable, checking for variation in local repo');
            // If the cpi is variable then check if the product has this
            // variation in the application's state
            //
            // If the variation is found then populate the cart product data
            // with that variation else fetch the variation and add it to
            // product variation and then update the cart item.

            // Create the cart product and update with variation data
            cp = CartProduct.fromWooStoreProCartItemData(
              cartItem: cpi,
              ref: product,
            );

            WooProductVariation? variationObject;

            if (product.variations.isNotEmpty) {
              variationObject = product.variations.firstWhereOrNull(
                (element) => element.id == cpi.variation!.id,
              );
            }

            if (variationObject != null) {
              Dev.debug(
                'Found the variation in local products repo, updating...',
              );
              cp.updateDisplayImage(newVariation: variationObject);
            } else {
              Dev.debug('No variation found');
            }
          } else {
            // both are simple
            Dev.debug('CPI is simple product');
            cp = CartProduct.fromWooStoreProCartItemData(
              cartItem: cpi,
              ref: product,
            );
          }
        } else {
          Dev.debug('CPI not present in local products repo');
          cp = CartProduct.fromWooStoreProCartItemData(cartItem: cpi);
        }

        if (isNotBlank(cp.cartItemKey)) {
          _tempCpMap.addAll({cp.cartItemKey!: cp});
        } else {
          // create a cart item key yourself based on the cart item data
          // and then save it
          cp.updateCartItemKey(cp.generateCartItemKey());
          _tempCpMap.addAll({cp.cartItemKey!: cp});
        }
      } // For loop ends
    }

    _productsMap = _tempCpMap;

    // Function Log
    Dev.debugFunction(
      functionName: '_createCartProducts',
      className: 'CartScreenLayoutViewModel',
      fileName: 'viewModel.dart',
      start: false,
    );
  }

  /// perform all the checks on the product object before
  /// performing any actions related to cart
  Future<bool> checkPrerequisites(Product p) async {
    // check if the product file add on is required and
    // the file needs to be uploaded.
    if (_shouldUploadFile(p)) {
      // start the upload process
      final uploadFileResponse = await showDialog(
        barrierDismissible: false,
        context: NavigationController.navigator.navigatorKey.currentContext!,
        builder: (_) => FileUploadProgressDialog(addon: p.fileUploadAddonData!),
      );
      if (uploadFileResponse is Map) {
        // add the file response to the product add on data
        p.fileUploadAddonData = p.fileUploadAddonData!
            .copyWithValue(value: uploadFileResponse['value']);
        p.addProductAddon(p.fileUploadAddonData!);
      } else {
        return false;
      }
    }

    // check if the product values are ok to be submitted for cart
    final List<Exception> val = p.isReadyForCartActions();
    if (val.isNotEmpty) {
      // show error on the screen
      showDialog(
        context: NavigationController.navigator.navigatorKey.currentContext!,
        builder: (_) => ErrorDialog(errorMessages: val),
      );
      return false;
    }

    return true;
  }

  /// check to see if the file should be uploaded to the website
  bool _shouldUploadFile(Product product) {
    if (product.fileUploadAddonData != null) {
      return true;
    }
    return false;
  }

  // *********************************************************************
  // For managing current product solely from cart provider.
  // *********************************************************************

  CartProduct? currentProduct;

  void setCurrentProduct(String productId) {
    final CartProduct? p = _productsMap[productId];
    if (p != null) {
      currentProduct = p;
    }
  }

  void removeCurrentFromCart() {
    removeFromCart(currentProduct!.id);
    currentProduct = null;
  }

  /// Empty the cart. Usually performed after checkout payment is made.
  void emptyCart() {
    _productsMap.clear();
    _totalCost = 0;
    _totalItems = 0;
    notifyListeners();
  }

  //**********************************************************
  // Public Helper functions
  //**********************************************************

  List<WPILineItems> createOrderWPILineItems() {
    try {
      final List<WPILineItems> result = [];
      for (final item in productsMap.values) {
        result.add(
          WPILineItems(
            productId: int.tryParse(item.productId) ?? 0,
            variationId: int.tryParse(item.variationId ?? '0'),
            quantity: item.quantity,
            cartItemData: {
              if (item.productAddons?.isNotEmpty ?? false)
                'addons': item.productAddons!
                    .map(
                      (e) => e.toMap(),
                    )
                    .toList(),
            },
            metaData: [
              if (item.productAddons?.isNotEmpty ?? false)
                ...item.productAddons!
                    .map<woo_order_model.MetaData>(
                      (e) => woo_order_model.MetaData(
                        key: e.name,
                        value: e.value,
                      ),
                    )
                    .toList()
            ],
          ),
        );
      }
      return result;
    } catch (e, s) {
      Dev.error(
        'Error Creating cart order line items',
        error: e,
        stackTrace: s,
      );
      return const [];
    }
  }

  /// Perform all the required validation tasks before going to the
  /// checkout screen.
  Future<bool> validateCartBeforeCheckout(BuildContext context) async {
    if (await verifyCouponBeforeCheckout(context)) {
      return true;
    }

    return false;
  }

  void _mayBeShowErrorForCartItemActionResponse(WooStoreProCartData cartData) {
    if (cartData.lineItemAddToCartResult != null) {
      final list = <Exception>[];
      for (final o in cartData.lineItemAddToCartResult!) {
        if (isNotBlank(o.error)) {
          list.add(Exception(o.error!));
        }
      }
      if (list.isNotEmpty) {
        _showErrorDialog(list);
      }
    }
  }

  void _showErrorDialog(List<Exception> exceptions) {
    // Show the loading animation:
    showDialog(
      context: NavigationController.navigator.navigatorKey.currentContext!,
      builder: (_) => ErrorDialog(errorMessages: exceptions),
    );
  }

  void _showLoadingDialog() {
    // Show the loading animation:
    NavigationController.navigator.push(CustomAlertRoute(
      child: const LoadingDialog(),
    ));
  }

  Future<void> _maybeHideLoadingDialog() async {
    if (NavigationController.navigator.current.name == CustomAlertRoute.name) {
      await NavigationController.navigator.pop();
    }
  }

  //**********************************************************
  //  Events
  //**********************************************************

  /// Loading event
  bool _isLoading = false;

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
  //  Event Helper Functions
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
    _hasData = hasData;
    _isError = false;
    _errorMessage = '';
    notifyListeners();
  }

  /// Notifies about the error
  void _onError(String message, {CartErrorState? errorState}) {
    _isLoading = false;
    _isSuccess = false;
    _isError = true;
    _errorMessage = message;
    if (errorState != null) {
      _cartErrorState = errorState;
    }
    notifyListeners();
  }
}
