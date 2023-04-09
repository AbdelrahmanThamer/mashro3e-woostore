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

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../themes/theme.dart';
import '../../../utils/utils.dart';
import '../order.model.dart';
import '../widgets/detailsModal.dart';
import '../widgets/rowItem.dart';
import '../widgets/statusBuilder.dart';
import 'lineItem.dart';

///
/// ## `Description`
///
/// List item for the orders list. Used to show
/// orders information as a single tile.
///
class MyOrdersListItem extends StatelessWidget {
  const MyOrdersListItem({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final ThemeData _theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: ThemeGuide.padding,
      decoration: BoxDecoration(
        color: _theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              RowItem(
                label: lang.orderId,
                value: order.wooOrder.id.toString(),
              ),
              RowItem(
                label: lang.date,
                value: order.wooOrder.dateCreated,
              ),
              RowItem(
                label: lang.total,
                value: Utils.formatPrice(order.wooOrder.total),
              ),
              ExpandablePanel(
                theme:
                    LocatorService.themeProvider().themeMode == ThemeMode.dark
                        ? const ExpandableThemeData(
                            hasIcon: true,
                            iconColor: Colors.white,
                          )
                        : const ExpandableThemeData(
                            hasIcon: true,
                            iconColor: Colors.black,
                          ),
                collapsed: const SizedBox(),
                header: Padding(
                  padding: ThemeGuide.padding10,
                  child: Text('${lang.show} ${lang.items}'),
                ),
                expanded: Column(
                  children: order.wooOrder.lineItems!.map<Widget>((e) {
                    return LineItem(
                      lineItem: e,
                      order: order,
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    if (!(order.status == OrderStatus.completed ||
                        order.status == OrderStatus.failed ||
                        order.status == OrderStatus.cancelled))
                      _TrackOrder(order: order),
                    if (!(order.status == OrderStatus.completed ||
                        order.status == OrderStatus.failed ||
                        order.status == OrderStatus.cancelled))
                      const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {
                        // Open a modal for products info
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) =>
                              OrdersDetailsScreen(order: order),
                        ));
                      },
                      child: Text(lang.moreInfo),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (Directionality.of(context) == TextDirection.rtl)
            Positioned(
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: _BuildStatus(status: order.status),
              ),
            )
          else
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: _BuildStatus(status: order.status),
              ),
            ),
        ],
      ),
    );
  }
}

class _TrackOrder extends StatelessWidget {
  const _TrackOrder({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return OutlinedButton(
      onPressed: () {
        NavigationController.navigator.push(TrackOrderRoute(order: order));
      },
      child: Text(lang.track),
    );
  }
}

class _BuildStatus extends StatelessWidget {
  const _BuildStatus({Key? key, required this.status}) : super(key: key);
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    switch (status) {
      case OrderStatus.completed:
        return StatusBuilder.completed(text: lang.completed);
      case OrderStatus.pending:
        return StatusBuilder.pending(text: lang.pending);
      case OrderStatus.processing:
        return StatusBuilder.processing(text: lang.processing);
      case OrderStatus.cancelled:
        return StatusBuilder.cancelled(text: lang.cancelled);
      case OrderStatus.failed:
        return StatusBuilder.failed(text: lang.failed);
      default:
        return const StatusBuilder.undefined(text: '');
    }
  }
}
