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
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../controllers/uiController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../themes/themeGuide.dart';
import 'filterModal/searchFilterModal.dart';
import 'sort_bottom_sheet.dart';

///
/// `Description`
///
/// Button to initiate the search action.
///
class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(EvaIcons.search),
      onPressed: () => _onSearch(context),
    );
  }

  void _onSearch(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isBlank(LocatorService.searchViewModel().searchTerm)) {
      final lang = S.of(context);
      UiController.showNotification(
        context: context,
        title: lang.oops,
        message: lang.nothingToSearch,
      );
    } else {
      LocatorService.searchViewModel().fetchData();
    }
  }
}

///
/// `Description`
///
/// Button to initiate Search filter action
///
class SearchFilterButton extends StatelessWidget {
  const SearchFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).filter,
      icon: const Icon(EvaIcons.optionsOutline),
      onPressed: () {
        UiController.showModal(
          context: context,
          child: const SearchFilterModal(),
        );
      },
    );
  }
}

class SearchSortButton extends StatelessWidget {
  const SearchSortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).sort,
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        UiController.modalBottomSheet(
          context: context,
          child: const SearchSortBottomSheet(),
        );
      },
    );
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    return Material(
      color: theme.appBarTheme.backgroundColor,
      elevation: ThemeGuide.isDarkMode(context)
          ? ParseEngine
              .appTemplate.appThemes.darkThemeData.appBarThemeData.elevation
          : ParseEngine
              .appTemplate.appThemes.lightThemeData.appBarThemeData.elevation,
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 20, right: 10),
        child: Row(
          children: [
            const _BackButton(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withAlpha(10),
                  borderRadius: ThemeGuide.borderRadius10,
                ),
                child: TextFormField(
                  maxLines: 1,
                  initialValue: LocatorService.searchViewModel().searchTerm,
                  onChanged: _onChange,
                  onEditingComplete: () => _onSearch(context),
                  decoration: InputDecoration(hintText: lang.search),
                ),
              ),
            ),
            const SearchSortButton(),
            const SearchFilterButton(),
          ],
        ),
      ),
    );
  }

  static void _onChange(String value) {
    LocatorService.searchViewModel().setSearchTerm = value;
  }

  void _onSearch(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isBlank(LocatorService.searchViewModel().searchTerm)) {
      final lang = S.of(context);
      UiController.showNotification(
        context: context,
        title: lang.oops,
        message: lang.nothingToSearch,
      );
    } else {
      LocatorService.searchViewModel().fetchData();
    }
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    if (canPop) {
      return const BackButton();
    }
    return const SizedBox();
  }
}
