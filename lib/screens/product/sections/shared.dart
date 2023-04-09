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

import '../../../app_builder/app_builder.dart';

class PSStyledContainerLayout extends StatelessWidget {
  const PSStyledContainerLayout({
    Key? key,
    required this.styledData,
    required this.child,
  }) : super(key: key);
  final StyledData styledData;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: styledData.marginData.createEdgeInsets(),
      padding: styledData.paddingData.createEdgeInsets(),
      decoration: BoxDecoration(
        color: HexColor.fromHex(
          styledData.backgroundColor,
          Theme.of(context).colorScheme.background,
        ),
        borderRadius: BorderRadius.circular(styledData.borderRadius),
      ),
      child: child,
    );
  }
}
