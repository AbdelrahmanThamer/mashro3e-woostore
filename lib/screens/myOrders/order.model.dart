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

import '../../models/models.dart';
import '../../services/woocommerce/woocommerce.service.dart';

enum OrderStatus {
  all,
  pending,
  processing,
  completed,
  cancelled,
  refunded,
  failed,
  undefined,
}

class Order {
  final int id;
  final WooOrder wooOrder;
  final Map<String, Product> products;
  final Map<int, WooProductVariation> productVariations;
  final OrderStatus status;
  AdvancedShipmentTracking? shipmentTracking;

  Order({
    required this.id,
    required this.wooOrder,
    this.products = const {},
    this.productVariations = const {},
    this.status = OrderStatus.undefined,
    this.shipmentTracking,
  });

  factory Order.fromWooOrder(WooOrder value) {
    Dev.info(value.toJson());
    return Order(
      id: value.id ?? 0,
      wooOrder: value,
      products: {},
      productVariations: {},
      status: _createOrderStatus(value.status.toString()),
    );
  }

  void updateVariations(WooProductVariation variation) {
    productVariations.addAll({variation.id!: variation});
  }

  void updateProducts(Product product) {
    products.addAll({product.id: product});
  }

  void updateShipmentTracking(AdvancedShipmentTracking ast) {
    shipmentTracking = ast;
  }

  /// Create the order status for the wooOrder
  static OrderStatus _createOrderStatus(String value) {
    switch (value.toLowerCase()) {
      case 'completed':
        return OrderStatus.completed;

      case 'processing':
        return OrderStatus.processing;

      case 'cancelled':
        return OrderStatus.cancelled;

      case 'pending':
        return OrderStatus.pending;

      case 'refunded':
        return OrderStatus.refunded;
      case 'failed':
        return OrderStatus.failed;
      default:
        return OrderStatus.undefined;
    }
  }
}
