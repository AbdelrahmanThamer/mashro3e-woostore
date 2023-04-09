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

import '../../../../../../models/models.dart';
import 'shared/decorator.dart';

class DividerSectionLayout extends StatelessWidget {
  const DividerSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final DividerSectionData data;

  @override
  Widget build(BuildContext context) {
    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: data.height,
        ),
      ),
    );
  }
}
