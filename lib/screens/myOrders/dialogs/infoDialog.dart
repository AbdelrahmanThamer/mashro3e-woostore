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

import '../../../generated/l10n.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../shared/customDivider.dart';
import '../../../themes/theme.dart';
import '../../../utils/utils.dart';

/// The container widget for the order info. The contents are
/// displayed as a dialog message.
///
/// ## Note
///
/// - Do `NOT` forget to call the `Navigator.of(context).pop()` method
/// from the dialog. This is required for IOS. On android back button works fine)
///
class OrderInfoDialog extends StatefulWidget {
  const OrderInfoDialog({
    Key key,
    this.order,
  }) : super(key: key);
  final WooOrder order;

  @override
  _OrderInfoDialogState createState() => _OrderInfoDialogState();
}

class _OrderInfoDialogState extends State<OrderInfoDialog>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      curve: const Interval(0.2, 1.0, curve: Curves.decelerate),
      parent: _controller,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.5),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        curve: Curves.decelerate,
        parent: _controller,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.stop();
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? ' ',
            style: theme.textTheme.subtitle1.copyWith(
              color: theme.disabledColor,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              value ?? ' ',
              style: theme.textTheme.subtitle2,
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    final lang = S.of(context);
    final ThemeData _theme = Theme.of(context);
    return ScaleTransition(
      scale: _scaleAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(20),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _theme.colorScheme.background,
              borderRadius: ThemeGuide.borderRadius20,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  lang.order + ' ' + lang.id,
                  style: _theme.textTheme.headline6,
                ),
                const CustomDivider(),
                _buildRow('Order Id', widget.order.id.toString(), _theme),
                _buildRow('Transaction Id', widget.order.transactionId, _theme),
                // Create all the names of the line items in this order
                _buildRow('Name', widget.order.lineItems.first.name, _theme),
                _buildRow('Status', widget.order.status, _theme),
                _buildRow('Date', widget.order.dateCreated, _theme),
                const CustomDivider(),
                // _buildRow('Quantity', 'x ${widget.order.lineItems.length}', _theme),
                // _buildRow(
                //   'Price',
                //
                //   _theme,
                // ),
                const CustomDivider(),
                _buildRow(
                  'Total',
                  Utils.formatPrice(widget.order.total),
                  _theme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
