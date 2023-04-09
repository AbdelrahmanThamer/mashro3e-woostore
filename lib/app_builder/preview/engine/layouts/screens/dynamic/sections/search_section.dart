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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/models.dart';
import '../../../../../../ui/slivers/sliver_container.dart';
import '../../../../../../utils.dart';


class SearchSectionLayout extends StatelessWidget {
  const SearchSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final SearchSectionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverContainer(
      padding: data.styledData.paddingData.createEdgeInsets(),
      margin: data.styledData.marginData.createEdgeInsets(),
      background: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: data.styledData.borderWidth,
            color: HexColor.fromHex(
              data.styledData.borderColor,
              Colors.transparent,
            )!,
          ),
          color: HexColor.fromHex(
            data.styledData.backgroundColor,
            theme.colorScheme.background,
          ),
          borderRadius: BorderRadius.circular(data.styledData.borderRadius),
        ),
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Icon(
              EvaIcons.search,
              size: data.styledData.textStyleData.fontSize + 5,
              color: HexColor.fromHex(
                data.styledData.textStyleData.color,
                theme.iconTheme.color,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Search',
              style: data.styledData.textStyleData.createTextStyle(
                forcedColor: theme.textTheme.bodyText2?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
