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

import '../../../../app_builder/app_builder.dart';

class SectionLayoutDecorator extends StatelessWidget {
  const SectionLayoutDecorator({
    Key? key,
    required this.styledData,
    required this.child,
    this.forcedColor,
  }) : super(key: key);
  final StyledData styledData;
  final Widget child;
  final Color? forcedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: styledData.paddingData.createEdgeInsets(),
      margin: styledData.marginData.createEdgeInsets(),
      decoration: BoxDecoration(
        border: Border.all(
          width: styledData.borderWidth,
          color: HexColor.fromHex(
            styledData.borderColor,
            Colors.transparent,
          )!,
        ),
        color: HexColor.fromHex(styledData.backgroundColor, forcedColor),
        borderRadius: BorderRadius.circular(styledData.borderRadius),
      ),
      child: child,
    );
  }
}

class SliverSectionLayoutDecorator extends StatelessWidget {
  const SliverSectionLayoutDecorator({
    Key? key,
    required this.styledData,
    required this.sliver,
  }) : super(key: key);
  final StyledData styledData;
  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    return SliverContainer(
      padding: styledData.paddingData.createEdgeInsets(),
      margin: styledData.marginData.createEdgeInsets(),
      background: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: styledData.borderWidth,
            color: HexColor.fromHex(
              styledData.borderColor,
              Colors.transparent,
            )!,
          ),
          color: HexColor.fromHex(styledData.backgroundColor),
          borderRadius: BorderRadius.circular(styledData.borderRadius),
        ),
      ),
      sliver: sliver,
    );
  }
}
