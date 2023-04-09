// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../themes/theme.dart';
import 'animatedButton.dart';
import 'itemCard.dart';

class SectionGenerator extends StatelessWidget {
  const SectionGenerator({
    Key key,
    this.title,
    this.titleWidget,
    this.showMore,
    @required this.data,
    this.isGrid = false,
    this.isMediumGrid = false,
    this.isSmallGrid = false,
    this.visibleItems = 6,
    this.showMoreButtonVisible = true,
  }) : super(key: key);

  /// Show 2 product items in a column inside a row
  const SectionGenerator.grid({
    Key key,
    this.title,
    this.titleWidget,
    this.showMore,
    @required this.data,
    this.isGrid = true,
    this.isMediumGrid = false,
    this.isSmallGrid = false,
    this.visibleItems = 6,
    this.showMoreButtonVisible = true,
  }) : super(key: key);

  const SectionGenerator.mediumGrid({
    Key key,
    this.title,
    this.titleWidget,
    this.showMore,
    @required this.data,
    this.isGrid = false,
    this.isMediumGrid = true,
    this.isSmallGrid = false,
    this.visibleItems = 6,
    this.showMoreButtonVisible = true,
  }) : super(key: key);

  const SectionGenerator.smallGrid({
    Key key,
    this.title,
    this.titleWidget,
    this.showMore,
    @required this.data,
    this.isGrid = false,
    this.isMediumGrid = false,
    this.isSmallGrid = true,
    this.visibleItems = 6,
    this.showMoreButtonVisible = true,
  }) : super(key: key);

  final String title;
  final Widget titleWidget;
  final Function showMore;
  final bool showMoreButtonVisible;
  final List<String> data;

  /// Flag to show 2 items as a row of column
  final bool isGrid;

  /// Flag to show 3 items as a row of column
  final bool isMediumGrid;

  /// Flag to show 4 items as a row of column
  final bool isSmallGrid;

  /// Number of items to show in the small list
  final int visibleItems;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    final _titleWidget = titleWidget ??
        Text(
          title ?? '',
          style: _theme.textTheme.headline6,
        );

    if (data.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: showMoreButtonVisible
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: _titleWidget,
                    ),
                    AnimButton(
                      onTap: () {
                        showMore();
                      },
                      child: Text(
                        S.of(context).seeAll,
                      ),
                    ),
                  ],
                )
              : _titleWidget,
        ),
        // _renderGrid(data, visibleItems),
        if (isGrid)
          SectionGrid(
            data: data,
            visibleItems: visibleItems,
          )
        else if (isMediumGrid)
          SectionGrid.mediumGrid(
            data: data,
            visibleItems: visibleItems,
          )
        else if (!isGrid)
          SectionList(
            data: data,
            visibleItems: visibleItems,
          )
        else
          SectionGrid(
            data: data,
            visibleItems: visibleItems,
          ),
      ],
    );
  }
}

class SectionGrid extends StatelessWidget {
  const SectionGrid({
    Key key,
    @required this.data,
    this.visibleItems = 6,
    this.itemCount = 2,
  }) : super(key: key);

  const SectionGrid.mediumGrid({
    Key key,
    @required this.data,
    this.visibleItems = 6,
    this.itemCount = 3,
  }) : super(key: key);

  @deprecated
  const SectionGrid.smallGrid({
    Key key,
    @required this.data,
    this.visibleItems = 6,
    this.itemCount = 4,
  }) : super(key: key);

  final List<String> data;
  final int visibleItems;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final newData = data.take(visibleItems).toList();
    // Show this widget if the item count is 2
    return GridView.count(
      shrinkWrap: true,
      padding: ThemeGuide.padding10,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: itemCount,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: ThemeGuide.productItemCardAspectRatio,
      children: newData.map<Widget>((i) {
        return ItemCard(productId: i);
      }).toList(),
    );
  }
}

class SectionList extends StatelessWidget {
  const SectionList({
    Key key,
    @required this.data,
    this.visibleItems = 6,
  }) : super(key: key);

  final List<String> data;
  final int visibleItems;

  @override
  Widget build(BuildContext context) {
    final newData = data.take(visibleItems).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: AspectRatio(
        aspectRatio: ThemeGuide.horizontalProductListContainerAspectRatio,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: newData?.length ?? 0,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: ItemCard(
                productId: data[i],
              ),
            );
          },
        ),
      ),
    );
  }
}
