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

class HorizontalListSectionLayout extends StatelessWidget {
  const HorizontalListSectionLayout({
    Key? key,
    required this.itemDimensionsData,
    required this.itemBuilder,
    this.itemCount = 0,
  }) : super(key: key);
  final DimensionsData itemDimensionsData;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemDimensionsData.height,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

/// Returns a sliver list
class VerticalListSectionLayout extends StatelessWidget {
  const VerticalListSectionLayout({
    Key? key,
    required this.itemBuilder,
    this.itemCount = 0,
  }) : super(key: key);
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
    );
  }
}

/// Returns a sliver list
class GridListSectionLayout extends StatelessWidget {
  const GridListSectionLayout({
    Key? key,
    required this.itemDimensionsData,
    required this.itemBuilder,
    this.itemCount = 0,
    this.columns = 2,
    this.spacing = 10,
    this.aspectRatio,
  }) : super(key: key);
  final DimensionsData itemDimensionsData;
  final int itemCount;
  final int columns;
  final Widget Function(BuildContext, int) itemBuilder;
  final double spacing;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: aspectRatio ?? itemDimensionsData.aspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
    );
  }
}
