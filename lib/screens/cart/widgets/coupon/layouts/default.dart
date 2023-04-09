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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../themes/theme.dart';
import '../../../coupons/coupons.dart';

/// The cart coupon layout
class CouponDefaultTile extends StatelessWidget {
  const CouponDefaultTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: ThemeGuide.padding5,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: Icon(
          FontAwesomeIcons.certificate,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          '${lang.apply} ${lang.coupon}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          // Navigate to the Coupon Screen
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => const CouponsScreen(),
          ));
        },
      ),
    );
  }
}
