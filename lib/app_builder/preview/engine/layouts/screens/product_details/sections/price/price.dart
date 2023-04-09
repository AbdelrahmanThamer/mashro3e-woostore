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

import '../../../../../../../models/app_template/app_template.dart';
import '../shared.dart';

class PSPriceSectionLayout extends StatelessWidget {
  const PSPriceSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSPriceSectionData data;

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;

    if (data.styledData.textStyleData.alignment == TextAlign.right) {
      mainAxisAlignment = MainAxisAlignment.end;
    }

    if (data.styledData.textStyleData.alignment == TextAlign.center) {
      mainAxisAlignment = MainAxisAlignment.center;
    }

    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            '\$100',
            style: data.styledData.textStyleData.createTextStyle(),
          ),
          const SizedBox(width: 10),
          const _DiscountPrice(),
          const SizedBox(width: 10),
          const _DiscountPercent(),
        ],
      ),
    );
  }
}

class _DiscountPrice extends StatelessWidget {
  const _DiscountPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '\$200',
      style: TextStyle(
        decoration: TextDecoration.lineThrough,
        color: Colors.grey,
      ),
    );
  }
}

class _DiscountPercent extends StatelessWidget {
  const _DiscountPercent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '50%',
      style: TextStyle(
        color: Colors.green,
      ),
    );
  }
}
