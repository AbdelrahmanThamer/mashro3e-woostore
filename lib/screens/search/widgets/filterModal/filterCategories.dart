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
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../../../developer/dev.log.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../services/woocommerce/models/models.dart';
import '../../../../shared/widgets/error/errorReload.dart';
import '../../viewModel/searchViewModel.dart';
import 'shared/listItem.dart';

class FilterCategories extends StatefulWidget {
  const FilterCategories({Key? key}) : super(key: key);

  @override
  _FilterCategoriesState createState() => _FilterCategoriesState();
}

class _FilterCategoriesState extends State<FilterCategories> {
  bool isLoading = true;
  bool hasData = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    // fetch the filters if not already present
    if (LocatorService.categoriesProvider().categoriesMap.isEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _fetch();
      });
    } else {
      isLoading = false;
      hasData = true;
      isError = false;
    }
  }

  /// Fetch the wooProduct tags from backend and store them for
  /// future reference
  Future<void> _fetch() async {
    try {
      final result = await LocatorService.categoriesProvider().getCategories();
      if (result.isEmpty) {
        // show no data available
        if (mounted) {
          setState(() {
            isError = false;
            isLoading = false;
            hasData = false;
          });
        }
        return;
      }

      if (mounted) {
        setState(() {
          isError = false;
          isLoading = false;
          hasData = true;
        });
      }
    } catch (e, s) {
      Dev.error('Fetch tags error', error: e, stackTrace: s);
      if (mounted) {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final S lang = S.of(context);
    if (isLoading) {
      return const LinearProgressIndicator(minHeight: 2);
    }

    if (isError) {
      return ErrorReload(
        errorMessage: lang.somethingWentWrong,
        reloadFunction: _fetch,
      );
    }

    if (hasData) {
      return const _CategoriesLayout();
    }

    return Center(
      child: Text(lang.noDataAvailable),
    );
  }
}

class _CategoriesLayout extends StatelessWidget {
  const _CategoriesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesMap = LocatorService.searchViewModel().categoriesMap;

    List<WooProductCategory> parentList = const [];

    if (categoriesMap.keys.isNotEmpty) {
      parentList = categoriesMap.keys.toList();
    }

    if (parentList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(S.of(context).noDataAvailable),
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Selector<SearchViewModel, WooStoreFilters>(
            selector: (context, d) => d.searchFilters,
            shouldRebuild: (a, b) => a.parentCategoryId != b.parentCategoryId,
            builder: (context, searchFilters, w) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: parentList.length,
                itemBuilder: (context, i) {
                  return HorizontalListTextItem(
                    text: parentList[i].name,
                    onTap: () => LocatorService.searchViewModel()
                        .setParentCategory(parentList[i]),
                    isSelected:
                        parentList[i].id == searchFilters.parentCategoryId,
                  );
                },
              );
            },
          ),
        ),
        Selector<SearchViewModel, WooStoreFilters>(
          selector: (context, d) => d.searchFilters,
          shouldRebuild: (a, b) {
            if (a.parentCategoryId != b.parentCategoryId ||
                a.childCategoryId != b.childCategoryId) {
              return true;
            }
            return false;
          },
          builder: (context, searchFilters, w) {
            final List<WooProductCategory> childList =
                categoriesMap[searchFilters.parentCategoryId] ?? const [];
            final double height = childList.isNotEmpty ? 40 : 0;
            final margin = childList.isNotEmpty
                ? const EdgeInsets.only(top: 20)
                : const EdgeInsets.only(top: 0);
            return AnimatedContainer(
              margin: margin,
              duration: const Duration(milliseconds: 800),
              height: height,
              curve: Curves.fastLinearToSlowEaseIn,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: childList.length,
                itemBuilder: (context, i) {
                  return HorizontalListTextItem(
                      text: childList[i].name,
                      isSelected:
                          searchFilters.childCategoryId == childList[i].id,
                      onTap: () => LocatorService.searchViewModel()
                          .setChildCategory(childList[i]));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
