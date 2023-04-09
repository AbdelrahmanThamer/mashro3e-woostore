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

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../app_builder/app_builder.dart';
import '../screens/cart/viewModel/viewModel.dart';

class TabbarNavigation extends ConsumerWidget {
  const TabbarNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTemplate = ref.watch(providerOfAppTemplateState).template;
    if (appTemplate.appTabs.isEmpty) {
      return const SizedBox();
    }
    final ThemeData _theme = Theme.of(context);
    return CupertinoTabScaffold(
      controller: ParseEngine.tabController,
      tabBar: CupertinoTabBar(
        // activeColor: ThemeGuide.isDarkMode(context)
        //     ? AppColors.tabbarDark
        //     : AppColors.tabbar,
        items: appTemplate.appTabs.map<BottomNavigationBarItem>((e) {
          if (e.appScreenData is AppCartScreenData) {
            return _buildCartTab(
              theme: _theme,
              icon: Icon(e.iconData),
              activeIcon: Icon(e.activeIconData),
            );
          }
          return BottomNavigationBarItem(
            icon: Icon(e.iconData),
            activeIcon: ActiveTab(icon: Icon(e.activeIconData)),
          );
        }).toList(),
        backgroundColor: _theme.scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
      ),
      tabBuilder: (context, i) {
        return ParseEngine.createTabScreen(
            appTemplate.appTabs[i].appScreenData);
      },
    );
  }

  BottomNavigationBarItem _buildCartTab({
    required ThemeData theme,
    required Icon icon,
    required Icon activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Selector<CartViewModel, int>(
        selector: (context, d) => d.totalItems,
        builder: (context, count, w) {
          if (count <= 0) {
            return w!;
          }
          return Badge(
            toAnimate: false,
            badgeColor: theme.colorScheme.primary,
            badgeContent: Text(
              count.toString(),
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            child: w,
          );
        },
        child: icon,
      ),
      activeIcon: Selector<CartViewModel, int>(
        selector: (context, d) => d.totalItems,
        builder: (context, count, w) {
          if (count <= 0) {
            return w!;
          }
          return Badge(
            animationType: BadgeAnimationType.fade,
            badgeColor: theme.colorScheme.primary,
            badgeContent: Text(
              count.toString(),
              style: TextStyle(color: theme.colorScheme.onSecondary),
            ),
            child: w,
          );
        },
        child: ActiveTab(icon: activeIcon),
      ),
    );
  }
}

class ActiveTab extends StatelessWidget {
  const ActiveTab({Key? key, required this.icon}) : super(key: key);
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, double value, widget) {
        return Transform.scale(
          scale: value,
          child: widget,
        );
      },
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return _createGradient(Theme.of(context)).createShader(bounds);
        },
        child: icon,
      ),
    );
  }

  LinearGradient _createGradient(ThemeData theme) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: const [0.5, 0],
      colors: <Color>[
        theme.colorScheme.primary,
        Colors.white,
      ],
      tileMode: TileMode.mirror,
    );
  }
}
