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

import '../../../shared/widgets/error/noDataAvailable.dart';
import '../../../themes/theme.dart';
import '../listItems/listItem.dart';
import '../order.model.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({
    Key key,
    @required this.list,
    @required this.orderStatus,
  }) : super(key: key);

  final List<Order> list;
  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    if (list == null || list.isEmpty) {
      return const Center(
        child: NoDataAvailableImage(),
      );
    } else {
      return ListView.builder(
        padding: ThemeGuide.listPadding,
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, int i) {
          return MyOrdersListItem(order: list[i]);
        },
      );
    }
  }
}
