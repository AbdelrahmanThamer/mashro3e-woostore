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
import 'package:quiver/strings.dart';

import '../../../developer/dev.log.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../shared/customLoader.dart';
import '../../../shared/widgets/error/errorReload.dart';
import '../../../shared/widgets/error/noDataAvailable.dart';
import '../../../shared/widgets/links/textLink.dart';
import '../../../themes/theme.dart';
import '../order.model.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.tracking + ' ' + lang.information),
      ),
      body: order.shipmentTracking != null
          ? _InfoContainer(shipmentTracking: order.shipmentTracking!)
          : _Body(order: order),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  bool isLoading = true;
  String? error;
  bool isDataAvailable = false;
  bool noDataAvailable = false;
  late AdvancedShipmentTracking ast;

  @override
  void initState() {
    super.initState();
    _fetchInfo();
  }

  Future<void> _fetchInfo() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      final AdvancedShipmentTracking? result = await LocatorService.wooService()
          .shipmentTracking
          .getTrackingInfo(widget.order.id.toString());
      if (result == null) {
        if (mounted) {
          setState(() {
            isLoading = false;
            noDataAvailable = true;
          });
        }
        return;
      }

      // Important:
      // Set the new value in the order
      widget.order.updateShipmentTracking(result);

      if (mounted) {
        setState(() {
          isLoading = false;
          isDataAvailable = true;
          noDataAvailable = false;
          ast = result;
          error = null;
        });
      }
    } catch (e, s) {
      if (mounted) {
        setState(() {
          isLoading = false;
          noDataAvailable = false;
          error = e.toString();
        });
      }
      Dev.error('Fetch tracking information', error: e, stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CustomLoader();
    }
    if (isNotBlank(error)) {
      return ErrorReload(
        errorMessage: error!,
        reloadFunction: _fetchInfo,
      );
    }
    if (noDataAvailable) {
      return const NoDataAvailableImage();
    }
    if (isDataAvailable) {
      return _InfoContainer(shipmentTracking: ast);
    }
    return const SizedBox();
  }
}

class _InfoContainer extends StatelessWidget {
  const _InfoContainer({
    Key? key,
    required this.shipmentTracking,
  }) : super(key: key);
  final AdvancedShipmentTracking shipmentTracking;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Padding(
      padding: ThemeGuide.padding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ListTile(
            label: lang.id,
            value: shipmentTracking.trackingId,
          ),
          _ListTile(
            label: lang.number,
            value: shipmentTracking.trackingNumber,
          ),
          _ListTile(
            label: lang.provider,
            value: shipmentTracking.trackingProvider,
          ),
          _ListTile(
            label: lang.link,
            valueWidget: TextLink(url: shipmentTracking.trackingLink),
          ),
          _ListTile(
            label: lang.date + ' ' + lang.shipped,
            value: shipmentTracking.dateShipped,
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    Key? key,
    required this.label,
    this.value,
    this.valueWidget,
  }) : super(key: key);

  final String label;
  final String? value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: ThemeGuide.padding10,
      margin: ThemeGuide.marginV5,
      decoration: BoxDecoration(
        color: theme.disabledColor.withAlpha(10),
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.subtitle1,
          ),
          const SizedBox(height: 10),
          if (valueWidget != null)
            valueWidget!
          else
            Text(
              value ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
