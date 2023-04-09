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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/models.dart';
import '../../../../engine.dart';
import 'shared/decorator.dart';

class BannerSectionLayout extends StatelessWidget {
  const BannerSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BannerSectionData data;

  @override
  Widget build(BuildContext context) {
    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: SliverToBoxAdapter(
        child: GestureDetector(
          onTap: () => ParseEngine.createAction(
            context: context,
            action: data.action,
          )?.call(),
          child: ExtendedCachedImage(
            imageUrl: data.imageUrl,
            borderRadius: BorderRadius.circular(data.imageBorderRadius),
            fit: data.imageBoxFit,
          ),
        ),
      ),
    );
  }
}
