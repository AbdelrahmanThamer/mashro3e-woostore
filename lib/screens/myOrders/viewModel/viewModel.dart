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

import 'package:quiver/strings.dart';

import '../../../constants/appStrings.dart';
import '../../../developer/dev.log.dart';
import '../../../locator.dart';
import '../../../models/models.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../order.model.dart';

class MyOrdersViewModel extends BaseProvider {
  //**********************************************************
  //  Data Holders
  //**********************************************************

  /// Store of all orders
  Map<int, Order> _ordersMap = {};

  /// List of aLl the orders
  List<Order> get ordersList => _ordersMap.values.toList();

  // Pending Orders
  final Map<int, Order> _pendingOrdersMap = {};

  List<Order> get pendingOrdersList => _pendingOrdersMap.values.toList();

  // Completed Orders
  final Map<int, Order> _completedOrdersMap = {};

  List<Order> get completedOrdersList => _completedOrdersMap.values.toList();

  // Cancelled Orders
  final Map<int, Order> _cancelledOrdersMap = {};

  List<Order> get cancelledOrdersList => _cancelledOrdersMap.values.toList();

  // Processing Orders
  final Map<int, Order> _processingOrdersMap = {};

  List<Order> get processingOrdersList => _processingOrdersMap.values.toList();

  // Refunded Orders
  final Map<int, Order> _refundedOrdersMap = {};

  List<Order> get refundedOrdersList => _refundedOrdersMap.values.toList();

  // Failed Orders
  final Map<int, Order> _failedOrdersMap = {};

  List<Order> get failedOrdersList => _failedOrdersMap.values.toList();

  /// Fetch the orders based on the user id
  Future<void> fetchData({
    int page = 1,
    int perPage = 100,
  }) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'fetchData',
      className: 'MyOrdersViewModel',
      fileName: 'viewModel.dart',
      start: true,
    );

    try {
      // Get the user from userProvider
      final User user = LocatorService.userProvider().user;

      if (isBlank(user.id)) {
        notifyCustomMessage('${AppStrings.no} ${AppStrings.user}');
        return;
      }

      int? userId;
      try {
        userId = int.parse(user.id);
      } catch (_) {}

      if (userId == null) {
        notifyCustomMessage('${AppStrings.no} ${AppStrings.user}');
        return;
      }

      notifyLoading();
      final List<WooOrder>? result =
          await LocatorService.wooService().wc.getOrders(
                customer: userId,
                perPage: perPage,
                page: page,
              );

      // If the result is null or empty
      if (result == null) {
        notifyState(ViewState.NO_DATA_AVAILABLE);
        return;
      }

      final Map<int, Order> temp = {};
      // sort the orders
      for (final obj in result) {
        final Order o = Order.fromWooOrder(obj);
        _sortOrder(o);
        temp.putIfAbsent(o.id, () => o);
      }

      _ordersMap = temp;

      // Notify the state
      notifyState(ViewState.DATA_AVAILABLE);

      // Function Log
      Dev.debugFunction(
        functionName: 'fetchData',
        className: 'MyOrdersViewModel',
        fileName: 'viewModel.dart',
        start: false,
      );
    } catch (e, s) {
      notifyError(message: e.toString());
      Dev.error(
        'Fetch data My Orders View Model',
        error: e,
        stackTrace: s,
      );
    }
  }

  /// Sort the list of orders
  ///
  /// Values are:
  /// any, pending, processing, on-hold, completed, cancelled, refunded,
  /// failed and trash
  void _sortOrder(Order order) {
    switch (order.wooOrder.status?.toLowerCase()) {
      case 'completed':
        _completedOrdersMap.putIfAbsent(order.id, () => order);
        break;

      case 'processing':
        _processingOrdersMap.putIfAbsent(order.id, () => order);
        break;

      case 'cancelled':
        _cancelledOrdersMap.putIfAbsent(order.id, () => order);
        break;

      case 'pending':
        _pendingOrdersMap.putIfAbsent(order.id, () => order);
        break;

      case 'refunded':
        _refundedOrdersMap.putIfAbsent(order.id, () => order);
        break;
      case 'failed':
        _failedOrdersMap.putIfAbsent(order.id, () => order);
        break;
    }
  }
}
