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

class PSQuantitySectionLayout extends StatelessWidget {
  const PSQuantitySectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSQuantitySectionData data;

  @override
  Widget build(BuildContext context) {
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: Row(
        children: [
          Text(
            'Quantity',
            style: data.styledData.textStyleData.createTextStyle(),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          Text(
            '1',
            style: data.styledData.textStyleData.createTextStyle(),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
