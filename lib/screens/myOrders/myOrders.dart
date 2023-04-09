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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy;

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../providers/utils/viewStateController.dart';
import '../../shared/widgets/user/noUserFound.dart';
import '../../themes/themeGuide.dart';
import '../shared/app_bar/app_bar.dart';
import 'order.model.dart';
import 'viewModel/viewModel.dart';
import 'widgets/tabPageBuilder.dart';

AutoDisposeProvider<AppMyOrdersScreenData> providerOfMyOrdersScreenLayoutData =
    Provider.autoDispose<AppMyOrdersScreenData>((ref) {
  return const AppMyOrdersScreenData();
});

class MyOrdersScreenLayout extends StatelessWidget {
  const MyOrdersScreenLayout({
    Key? key,
    this.screenData,
  }) : super(key: key);

  final AppMyOrdersScreenData? screenData;

  @override
  Widget build(BuildContext context) {
    final _screenData = screenData ??
        ParseEngine.getScreenData(
          screenId: AppPrebuiltScreensId.myOrders,
        ) as AppMyOrdersScreenData;
    providerOfMyOrdersScreenLayoutData =
        Provider.autoDispose<AppMyOrdersScreenData>((ref) {
      return _screenData;
    });
    final ThemeData _theme = Theme.of(context);
    return DefaultTabController(
      length: 6,
      child: Theme(
        data: _theme.copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: legacy.ChangeNotifierProvider<MyOrdersViewModel>.value(
          value: LocatorService.myOrdersViewModel(),
          child: const Scaffold(body: _Body()),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenData = ref.read(providerOfMyOrdersScreenLayoutData);
    final provider =
        legacy.Provider.of<MyOrdersViewModel>(context, listen: false);

    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    final bool isDarkMode =
        LocatorService.themeProvider().themeMode == ThemeMode.dark || false;
    return CustomScrollView(
      slivers: [
        if (screenData.appBarData.show)
          SliverAppBarLayout(
            forceAddActionButtons: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: LocatorService.myOrdersViewModel().fetchData,
              ),
            ],
            data: screenData.appBarData,
            overrideTitle: S.of(context).orders,
            bottomWidget: TabBar(
              indicator: BoxDecoration(
                borderRadius: ThemeGuide.borderRadius,
                color: _theme.colorScheme.primary.withAlpha(100),
              ),
              labelColor: isDarkMode ? Colors.white : Colors.black,
              unselectedLabelColor:
                  isDarkMode ? Colors.white30 : Colors.black26,
              isScrollable: true,
              tabs: <Widget>[
                Tab(child: Center(child: Text(lang.all))),
                Tab(child: Center(child: Text(lang.completed))),
                Tab(child: Center(child: Text(lang.pending))),
                Tab(child: Center(child: Text(lang.processing))),
                Tab(child: Center(child: Text(lang.cancelled))),
                Tab(child: Center(child: Text(lang.failed))),
              ],
            ),
          ),
        SliverFillRemaining(
          child: ViewStateController<MyOrdersViewModel>(
            customMessageWidget: const NoUserFoundWithImage(),
            fetchData: provider.fetchData,
            child: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                TabPage(orderStatus: OrderStatus.all),
                TabPage(orderStatus: OrderStatus.completed),
                TabPage(orderStatus: OrderStatus.pending),
                TabPage(orderStatus: OrderStatus.processing),
                TabPage(orderStatus: OrderStatus.cancelled),
                TabPage(orderStatus: OrderStatus.failed),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
