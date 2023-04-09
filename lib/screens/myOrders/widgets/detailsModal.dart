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
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../models/models.dart' show Address, BillingAddress;
import '../../../shared/style/styledContainer.dart';
import '../../../themes/theme.dart';
import '../../../utils/utils.dart';
import '../../address/addressContainers.dart';
import '../listItems/lineItem.dart';
import '../order.model.dart';
import 'rowItem.dart';

class OrdersDetailsScreen extends StatelessWidget {
  const OrdersDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.order + ' ' + lang.details),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: ThemeGuide.padding16,
        children: [
          _OrderInfo(order: order),
          const SizedBox(height: 30),
          _OrderItems(order: order),
          const SizedBox(height: 30),
          if (isNotBlank(order.wooOrder.customerNote))
            StyledContainer(child: Text(order.wooOrder.customerNote!)),
          if (isNotBlank(order.wooOrder.customerNote))
            const SizedBox(height: 30),
          ExpandablePanel(
            theme: LocatorService.themeProvider().themeMode == ThemeMode.dark
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _Heading(
                text: '${lang.shipping} ${lang.address}',
              ),
            ),
            expanded: AddressContainer.withoutContainer(
              isBillingAddress: false,
              address: Address(
                address1: order.wooOrder.shipping?.address1,
                address2: order.wooOrder.shipping?.address2,
                city: order.wooOrder.shipping?.city,
                state: order.wooOrder.shipping?.state,
                country: order.wooOrder.shipping?.country,
                postCode: order.wooOrder.shipping?.postcode,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ExpandablePanel(
            theme: LocatorService.themeProvider().themeMode == ThemeMode.dark
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _Heading(
                text: '${lang.billing} ${lang.address}',
              ),
            ),
            expanded: AddressContainer.withoutContainer(
              isBillingAddress: true,
              address: BillingAddress(
                address1: order.wooOrder.billing?.address1,
                address2: order.wooOrder.billing?.address2,
                city: order.wooOrder.billing?.city,
                state: order.wooOrder.billing?.state,
                country: order.wooOrder.billing?.country,
                postCode: order.wooOrder.billing?.postcode,
                email: order.wooOrder.billing?.email,
                phone: order.wooOrder.billing?.phone,
              ),
            ),
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({Key? key, this.text}) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}

class _OrderInfo extends StatelessWidget {
  const _OrderInfo({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return StyledContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Heading(text: lang.details),
          const SizedBox(height: 10),
          RowItem(
            padding: const EdgeInsets.only(top: 5),
            label: lang.orderId,
            value: order.wooOrder.id.toString(),
          ),
          const SizedBox(height: 2),
          RowItem(
            padding: const EdgeInsets.only(top: 5),
            label: lang.total + ' ' + lang.items,
            value: order.wooOrder.lineItems?.length.toString() ?? '0',
          ),
          const SizedBox(height: 2),
          RowItem(
            padding: const EdgeInsets.only(top: 5),
            label: lang.date,
            value: order.wooOrder.dateCreated,
          ),
          const SizedBox(height: 2),
          RowItem(
            padding: const EdgeInsets.only(top: 5),
            label: '${lang.payment} ${lang.method}',
            value: order.wooOrder.paymentMethodTitle,
          ),
          const SizedBox(height: 2),
          RowItem(
            padding: const EdgeInsets.only(top: 5),
            label: lang.shipping,
            value: Utils.formatPrice(order.wooOrder.shippingTotal),
          ),
          const SizedBox(height: 2),
          RowItem(
            padding: const EdgeInsets.only(top: 5),
            label: lang.total,
            value: Utils.formatPrice(order.wooOrder.total),
          ),
        ],
      ),
    );
  }
}

class _OrderItems extends StatelessWidget {
  const _OrderItems({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    if (order.wooOrder.lineItems == null ||
        (order.wooOrder.lineItems?.isEmpty ?? false)) {
      return const SizedBox();
    }

    final lang = S.of(context);
    return StyledContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Heading(text: lang.items),
          const SizedBox(height: 10),
          ...order.wooOrder.lineItems!.map<Widget>((e) {
            return LineItem(
              lineItem: e,
              order: order,
            );
          }).toList(),
        ],
      ),
    );
  }
}
