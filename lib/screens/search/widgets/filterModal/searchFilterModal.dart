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
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/navigationController.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../shared/filter_modal/filter_modal.dart';
import '../../viewModel/searchViewModel.dart';
import 'filterCategories.dart';
import 'filterTags.dart';

class SearchFilterModal extends StatelessWidget {
  const SearchFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(lang.filter),
        actions: const [CloseButton()],
      ),
      body: ChangeNotifierProvider<SearchViewModel>.value(
        value: LocatorService.searchViewModel(),
        child: Padding(
          padding: ThemeGuide.padding20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const FilterOnSale<SearchViewModel>(),
              const Divider(),
              const FilterInStock<SearchViewModel>(),
              const Divider(),
              const FilterFeatured<SearchViewModel>(),
              const Divider(),
              ExpandablePanel(
                theme: theme.brightness == Brightness.dark
                    ? const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.white,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      )
                    : const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.black,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                header: _Heading(text: lang.categories),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: const [
                    SizedBox(height: 10),
                    FilterCategories(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              const Divider(),
              ExpandablePanel(
                theme: theme.brightness == Brightness.dark
                    ? const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.white,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      )
                    : const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.black,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                header: _Heading(text: lang.tags),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: const [
                    SizedBox(height: 10),
                    FilterTags(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              const Divider(),
              ExpandablePanel(
                theme: theme.brightness == Brightness.dark
                    ? const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.white,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      )
                    : const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.black,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                header: _Heading(text: lang.price),
                collapsed: const SizedBox(),
                expanded: const FilterPriceRangeSlider<SearchViewModel>(),
              ),
              const Divider(),
              const FilterAttributes<SearchViewModel>(),
              const SizedBox(height: 40),
              const _ApplyFilterButton(),
              const _ClearFilters(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ClearFilters extends StatelessWidget {
  const _ClearFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return GestureDetector(
      onTap: LocatorService.searchViewModel().clearFilters,
      child: Container(
        padding: ThemeGuide.padding20,
        child: Center(child: Text(lang.clearFilters)),
      ),
    );
  }
}

class _ApplyFilterButton extends StatelessWidget {
  const _ApplyFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SafeArea(
      bottom: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GradientButton(
          onPress: _onPress,
          child: Text(
            lang.apply,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static void _onPress() {
    LocatorService.searchViewModel().fetchData();
    NavigationController.navigator.pop();
  }
}
