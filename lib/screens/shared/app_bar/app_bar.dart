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
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../cart/viewModel/viewModel.dart';

class SliverAppBarLayout extends StatelessWidget {
  const SliverAppBarLayout({
    Key? key,
    required this.data,
    this.overrideTitle,
    this.flexibleSpace,
    this.expandedHeight,
    this.bottomWidget,
    this.forceAddActionButtons = const [],
    this.overrideActions,
    this.overrideActionButtons,
  }) : super(key: key);
  final AppBarData data;
  final String? overrideTitle;
  final Widget? flexibleSpace;
  final double? expandedHeight;
  final PreferredSizeWidget? bottomWidget;
  final List<Widget> forceAddActionButtons;

  /// Use this to add custom icon buttons based on the [AppActionType]
  final Map<AppActionType, Widget Function(AppBarActionButtonData)>?
      overrideActionButtons;

  /// Use this to add custom callback functions based on the [AppActionType]
  final Map<AppActionType, Function>? overrideActions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> actionButtons = data.actionButtons.map<Widget>((e) {
      if (e.hidden) {
        return const SizedBox();
      }

      if (overrideActionButtons != null) {
        if (overrideActionButtons!.isNotEmpty &&
            overrideActionButtons!.containsKey(e.action.type)) {
          return overrideActionButtons![e.action.type]!.call(e);
        }
      }

      final Widget icon = IconButton(
        icon: createIcon(e.iconData),
        onPressed: () => createAction(
          context: context,
          action: e.action,
          overrideActions: overrideActions,
        )?.call(),
      );

      // Build a badge for the cart icon
      if (e.action.type == AppActionType.navigation) {
        e.action as NavigationAction;
        if ((e.action as NavigationAction).navigationData.screenId ==
            AppPrebuiltScreensId.cart) {
          // Build a badge over icon
          return Selector<CartViewModel, int>(
            selector: (context, d) => d.totalItems,
            builder: (context, count, w) {
              if (count <= 0) {
                return w!;
              }
              return Badge(
                position: const BadgePosition(
                  top: 5,
                  end: 5,
                ),
                animationType: BadgeAnimationType.fade,
                badgeColor: theme.colorScheme.primary,
                badgeContent: Text(
                  count.toString(),
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
                child: w,
              );
            },
            child: icon,
          );
        }
      }
      return icon;
    }).toList();

    if (forceAddActionButtons.isNotEmpty) {
      actionButtons = [...actionButtons, ...forceAddActionButtons];
    }

    return SliverAppBar(
      centerTitle: data.centerTitle,
      leading: createLeading(context),
      title: createTitle(theme),
      actions: actionButtons,
      pinned: data.pinned,
      floating: data.floating && flexibleSpace == null,
      flexibleSpace: flexibleSpace,
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
        icon: createIcon(data.leading!.iconData),
        onPressed: () => ParseEngine.createAction(
          context: context,
          action: data.leading!.action,
        )?.call(),
      );
    }

    return null;
  }

  static Icon createIcon(IconData iconData) {
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

  static Function? createAction({
    required BuildContext context,
    required AppAction action,
    Map<AppActionType, Function>? overrideActions,
  }) {
    Function? result = ParseEngine.createAction(
      context: context,
      action: action,
    );

    Dev.info(action.toMap());

    // Check for the custom actions
    if (overrideActions != null) {
      overrideActions.forEach((key, value) {
        if (key == action.type) {
          result = value;
        }
      });
    }

    return result;
  }
}
