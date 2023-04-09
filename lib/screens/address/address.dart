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

import '../../controllers/uiController.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../models/address.model.dart';
import '../../services/woocommerce/woocommerce.service.dart';
import 'addressContainers.dart';
import 'updateAddress.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({
    Key? key,
    required this.isShipping,
  })  : isBilling = !isShipping,
        super(key: key);
  final bool isShipping;
  final bool isBilling;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final WooCustomer? customer =
        LocatorService.userProvider().user.wooCustomer;

    if (customer == null) {
      return Center(
        child: Text('${lang.please} ${lang.login} ${lang.again}'),
      );
    }

    Address address = const Address.empty();

    if (isShipping) {
      // If customer shipping information is not available.
      if (customer.shipping == null ||
          customer.shipping!.address1 == null ||
          customer.shipping!.address1!.isEmpty) {
        return const _NoAddressAvailable(isShipping: true);
      }
      // Create address from WooShipping object
      address = Address.fromWooAddress(shipping: customer.shipping);
    } else {
      // If customer billing information is not available.
      if (customer.billing == null ||
          customer.billing!.address1 == null ||
          customer.billing!.address1!.isEmpty) {
        return const _NoAddressAvailable(isShipping: false);
      }
      // Create address from WooShipping object
      address = BillingAddress.fromWooAddress(billing: customer.billing);
    }

    // If shipping information is available.
    return Scaffold(
      appBar: AppBar(
        title: isShipping
            ? Text(lang.shipping + ' ' + lang.address)
            : Text(lang.billing + ' ' + lang.address),
        actions: <Widget>[
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.edit),
            onPressed: () {
              UiController.showModal(
                context: context,
                child: UpdateAddress(
                  address: address,
                  isShipping: isShipping,
                ),
              );
            },
            tooltip: lang.update,
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        children: [
          AddressContainer.withoutContainer(
            address: address,
            isBillingAddress: isBilling,
          ),
        ],
      ),
    );
  }
}

class _NoAddressAvailable extends StatelessWidget {
  const _NoAddressAvailable({
    Key? key,
    required this.isShipping,
  })  : isBilling = !isShipping,
        super(key: key);
  final bool isShipping;
  final bool isBilling;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: isShipping
            ? Text(lang.shipping + ' ' + lang.address)
            : Text(lang.billing + ' ' + lang.address),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            UiController.showModal(
              context: context,
              child: UpdateAddress(
                address: isShipping
                    ? const Address.empty()
                    : const BillingAddress.empty(),
                isShipping: isShipping,
              ),
            );
          },
          child: Text(lang.addNewAddress),
        ),
      ),
    );
  }
}
