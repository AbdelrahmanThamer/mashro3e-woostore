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
import 'package:provider/provider.dart';

import '../order.model.dart';
import '../viewModel/viewModel.dart';
import 'listBuilder.dart';

class TabPage extends StatelessWidget {
  const TabPage({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);
  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    return Selector<MyOrdersViewModel, List<Order>>(
      selector: (context, d) {
        switch (orderStatus) {
          case OrderStatus.completed:
            return d.completedOrdersList;
          case OrderStatus.pending:
            return d.pendingOrdersList;
          case OrderStatus.processing:
            return d.processingOrdersList;
          case OrderStatus.cancelled:
            return d.cancelledOrdersList;
          case OrderStatus.failed:
            return d.failedOrdersList;
          case OrderStatus.refunded:
            return d.refundedOrdersList;
          default:
            return d.ordersList;
        }
      },
      builder: (context, list, _) {
        return ListBuilder(
          list: list,
          orderStatus: orderStatus,
        );
      },
    );
  }
}
