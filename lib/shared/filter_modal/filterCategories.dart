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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../developer/dev.log.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../services/woocommerce/woocommerce.service.dart';
import '../../../../shared/widgets/error/errorReload.dart';
import 'filter_view_model.dart';
import 'shared/listItem.dart';

class FilterCategories<T extends FilterViewModel> extends StatefulWidget {
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
        setState(() {
          isError = false;
          isLoading = false;
          hasData = false;
        });
        return;
      }

      setState(() {
        isError = false;
        isLoading = false;
        hasData = true;
      });
    } catch (e, s) {
      Dev.error('Fetch tags error', error: e, stackTrace: s);
      setState(() {
        isError = true;
        isLoading = false;
      });
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

class _CategoriesLayout<T extends FilterViewModel> extends StatelessWidget {
  const _CategoriesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final provider = Provider.of<T>(context, listen: false);
    final categoriesMap = provider.categoriesMap;

    List<WooProductCategory> parentList = const [];

    if (categoriesMap.isNotEmpty) {
      if (categoriesMap.keys.isNotEmpty) {
        parentList = categoriesMap.keys.toList();
      }
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(lang.noDataAvailable),
      );
    }

    if (parentList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(lang.noDataAvailable),
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Selector<T, WooStoreFilters>(
            selector: (context, d) => d.filters,
            shouldRebuild: (a, b) => a.parentCategoryId != b.parentCategoryId,
            builder: (context, searchFilters, w) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: parentList.length,
                itemBuilder: (context, i) {
                  return HorizontalListTextItem(
                    text: parentList[i].name,
                    onTap: () => provider.setParentCategory(parentList[i]),
                    isSelected:
                        parentList[i].id == searchFilters.parentCategoryId,
                  );
                },
              );
            },
          ),
        ),
        Selector<T, WooStoreFilters>(
          selector: (context, d) => d.filters,
          shouldRebuild: (a, b) {
            if (a.parentCategoryId != b.parentCategoryId ||
                a.childCategoryId != b.childCategoryId) {
              return true;
            }
            return false;
          },
          builder: (context, searchFilters, w) {
            List<WooProductCategory> childList = const [];

            final parentCat = parentList.firstWhereOrNull(
                (element) => element.id == searchFilters.parentCategoryId);
            childList = categoriesMap[parentCat] ?? const [];

            final double height = childList.isNotEmpty ? 40 : 0;
            final margin = childList.isNotEmpty
                ? const EdgeInsets.only(top: 20)
                : const EdgeInsets.only(top: 0);
            return AnimatedContainer(
              margin: margin,
              duration: const Duration(milliseconds: 800),
              height: height,
              curve: Curves.fastLinearToSlowEaseIn,
              child: childList.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: childList.length,
                      itemBuilder: (context, i) {
                        return HorizontalListTextItem(
                          text: childList[i].name,
                          isSelected:
                              searchFilters.childCategoryId == childList[i].id,
                          onTap: () => provider.setChildCategory(childList[i]),
                        );
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}
