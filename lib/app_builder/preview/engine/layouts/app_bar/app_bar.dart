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
import 'package:quiver/strings.dart';

import '../../../../models/models.dart';
import '../../engine.dart';

class SliverAppBarLayout extends StatelessWidget {
  const SliverAppBarLayout({
    Key? key,
    required this.data,
    this.overrideTitle,
    this.flexibleSpace,
    this.expandedHeight,
    this.bottomWidget,
  }) : super(key: key);
  final AppBarData data;
  final String? overrideTitle;
  final Widget? flexibleSpace;
  final double? expandedHeight;
  final PreferredSizeWidget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actionButtons = data.actionButtons.map<Widget>((e) {
      if (e.hidden) {
        return const SizedBox();
      }

      return IconButton(
        icon: _createIcon(e.iconData),
        onPressed: () => ParseEngine.createAction(
          context: context,
          action: e.action,
        )?.call(),
      );
    }).toList();

    return SliverAppBar(
      centerTitle: data.centerTitle,
      leading: createLeading(context),
      title: createTitle(theme),
      actions: actionButtons,
      pinned: data.pinned,
      floating: data.floating && flexibleSpace == null,
      flexibleSpace: flexibleSpace,
      stretch: true,
      expandedHeight: expandedHeight,
      bottom: bottomWidget,
    );
  }

  Widget? createTitle(ThemeData theme) {
    if (isNotBlank(data.logo)) {
      return ExtendedCachedImage(imageUrl: data.logo!);
    }

    if (isNotBlank(data.title)) {
      return Text(
        data.title!,
        style: TextStyle(color: theme.textTheme.bodyText2?.color),
      );
    }

    if (isNotBlank(overrideTitle)) {
      return Text(
        overrideTitle!,
        style: TextStyle(color: theme.textTheme.bodyText2?.color),
      );
    }

    return null;
  }

  Widget? createLeading(BuildContext context) {
    if (data.leading != null && data.leading!.hidden == false) {
      return IconButton(
        tooltip: data.leading!.tooltip,
        iconSize: data.leading!.size,
        icon: _createIcon(data.leading!.iconData),
        onPressed: () => ParseEngine.createAction(
          context: context,
          action: data.leading!.action,
        )?.call(),
      );
    }

    return null;
  }

  Icon _createIcon(IconData iconData) {
    IconData result = IconData(iconData.codePoint);

    if (isNotBlank(iconData.fontFamily)) {
      result = IconData(iconData.codePoint, fontFamily: iconData.fontFamily);
    }

    if (isNotBlank(iconData.fontPackage)) {
      result = IconData(iconData.codePoint, fontFamily: iconData.fontFamily);
    }
    if (isNotBlank(iconData.fontPackage) && isNotBlank(iconData.fontFamily)) {
      result = IconData(
        iconData.codePoint,
        fontFamily: iconData.fontFamily,
        fontPackage: iconData.fontPackage,
      );
    }
    return Icon(result);
  }
}
