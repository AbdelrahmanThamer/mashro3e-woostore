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

import '../../generated/l10n.dart';
import '../../models/address.model.dart';
import '../../themes/theme.dart';

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    Key? key,
    required this.address,
    required this.isBillingAddress,
    this.padding = const EdgeInsets.all(10.0),
  })  : withoutContainer = false,
        super(key: key);

  const AddressContainer.withoutContainer({
    Key? key,
    required this.address,
    required this.isBillingAddress,
  })  : withoutContainer = true,
        padding = const EdgeInsets.all(0),
        super(key: key);

  final Address address;
  final bool isBillingAddress;
  final bool withoutContainer;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);

    if (withoutContainer) {
      return _renderColumn(_theme, lang);
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: ThemeGuide.borderRadius,
        color: _theme.colorScheme.background,
      ),
      child: _renderColumn(_theme, lang),
    );
  }

  Widget _renderColumn(ThemeData _theme, S lang) {
    return Column(
      children: <Widget>[
        if (isBillingAddress)
          CustomTableRow(
            label: lang.emailLabel,
            value: (address as BillingAddress).email,
            color: _theme.disabledColor.withAlpha(10),
          ),
        if (isBillingAddress)
          CustomTableRow(
            label: lang.phone,
            value: (address as BillingAddress).phone,
          ),
        CustomTableRow(
          label: lang.street,
          value: address.address1,
          color: _theme.disabledColor.withAlpha(10),
        ),
        CustomTableRow(
          label: lang.apartment,
          value: address.address2,
        ),
        CustomTableRow(
          label: lang.city,
          value: address.city,
          color: _theme.disabledColor.withAlpha(10),
        ),
        CustomTableRow(
          label: lang.postCode,
          value: address.postCode,
        ),
        CustomTableRow(
          label: lang.state,
          value: address.state,
          color: _theme.disabledColor.withAlpha(10),
        ),
        CustomTableRow(
          label: lang.country,
          value: address.country,
        ),
      ],
    );
  }
}

class CustomTableRow extends StatelessWidget {
  const CustomTableRow({
    Key? key,
    required this.label,
    required this.value,
    this.color,
  }) : super(key: key);

  final String? label, value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label ?? '',
            style: _theme.textTheme.bodyText1,
          ),
          const Flexible(child: SizedBox(width: 20)),
          Flexible(
            flex: 5,
            child: Text(
              value ?? '',
              style: _theme.textTheme.bodyText1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
