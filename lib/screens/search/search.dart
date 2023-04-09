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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../providers/utils/viewStateController.dart';
import 'viewModel/searchViewModel.dart';
import 'widgets/searchAppBar.dart';
import 'widgets/searchItemList.dart';
import 'widgets/searchSomething.dart';

class SearchScreenLayout extends StatelessWidget {
  const SearchScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(),
      body: ChangeNotifierProvider<SearchViewModel>.value(
        value: LocatorService.searchViewModel(),
        child: ViewStateController<SearchViewModel>(
          fetchData: LocatorService.searchViewModel().fetchData,
          disposeFunction: LocatorService.searchViewModel().reset,
          customMessageWidget: const SearchSomething(),
          child: const SearchItemList(),
        ),
      ),
    );
  }
}
