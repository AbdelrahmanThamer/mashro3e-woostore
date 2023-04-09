// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:am_common_packages/am_common_packages.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../services/woocommerce/woocommerce.service.dart';
import '../../utils/colors.utils.dart';
import 'filter_view_model.dart';

class SelectedFiltersWidget extends StatelessWidget {
  const SelectedFiltersWidget({
    Key? key,
    required this.filterViewModel,
    this.renderAsSliverAppBar = true,
  }) : super(key: key);
  final FilterViewModel filterViewModel;

  /// To render the widget as a sliver app bar
  final bool renderAsSliverAppBar;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FilterViewModel>.value(
      value: filterViewModel,
      child: Selector<FilterViewModel, WooStoreFilters>(
        selector: (context, p) => p.filters,
        builder: (context, filters, _) {
          final tagWidget = buildTag(filters.tagId);
          final parentCat = buildCategory(filters.parentCategoryId);
          final childCat = buildCategory(filters.childCategoryId);
          final attrs = buildAttributes(filters.taxonomyQueryList, context);

          if (tagWidget != null ||
              childCat != null ||
              parentCat != null ||
              attrs != null) {
            final Widget main = Row(
              children: [
                Text('${S.of(context).filter}:'),
                const SizedBox(width: 2),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (attrs != null && attrs.isNotEmpty)
                        ...attrs
                            .map((e) =>
                                e == null ? const SizedBox() : _Box(child: e))
                            .toList(),
                      if (tagWidget != null) _Box(child: tagWidget),
                      if (parentCat != null) _Box(child: parentCat),
                      if (childCat != null) _Box(child: childCat),
                    ],
                  ),
                ),
              ],
            );

            if (!renderAsSliverAppBar) {
              return main;
            }

            return SliverPadding(
              padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
              sliver: SliverAppBar(
                floating: true,
                elevation: 0,
                toolbarHeight: -15,
                automaticallyImplyLeading: false,
                flexibleSpace: main,
              ),
            );
          }

          if (!renderAsSliverAppBar) {
            return const SizedBox();
          }
          return const SliverToBoxAdapter(child: SizedBox());
        },
      ),
    );
  }

  Widget? buildTag(int? tagId) {
    if (tagId == null || tagId <= 0) {
      return null;
    }
    final tag = LocatorService.tagsViewModel().findTagById(tagId);
    if (tag == null) {
      return null;
    }
    return Text('${tag.name}');
  }

  Widget? buildCategory(int? categoryId) {
    if (categoryId == null || categoryId <= 0) {
      return null;
    }
    final category =
        LocatorService.categoriesProvider().findCategoryById(categoryId);
    if (category == null) {
      return null;
    }
    return Text('${category.name}');
  }

  List<Widget?>? buildAttributes(
    List<WooProductTaxonomyQuery>? taxonomyList,
    BuildContext context,
  ) {
    final paList = filterViewModel.paList;
    if (paList.isEmpty || taxonomyList == null || taxonomyList.isEmpty) {
      return null;
    }

    /// List to hold the selected attributes
    final List<Widget?> selectedAttrListWidget = [];

    for (final taxonomy in taxonomyList) {
      // find the attribute
      final WooStoreProductAttribute? attribute = paList.firstWhereOrNull(
        (element) => element.slug == taxonomy.taxonomySlug,
      );

      // if you cannot find attribute, then move to next taxonomy
      if (attribute == null) {
        continue;
      }

      // If you have the attribute, build the widget based on the term selected
      // find the term and it's value
      if (attribute.terms == null || attribute.terms!.isEmpty) {
        // If the terms are empty then continue to the next
        continue;
      }
      final WooStoreProductAttributeTerm? term = attribute.terms!
          .firstWhereOrNull((element) => element.termId == taxonomy.termId);

      // Continue to next taxonomy if you cannot find the term
      if (term == null) {
        continue;
      }

      // if the term and attribute is available then build the widget
      Widget selectedWidget = Text('${term.name}');
      if (attribute.type == WooStoreProductAttributeType.color) {
        if (term.value != null) {
          selectedWidget = Row(
            children: [
              Text('${term.name}'),
              const SizedBox(width: 10),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: HexColor.fromDynamicString(term.value!),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          );
        }
      } else if (attribute.type == WooStoreProductAttributeType.image) {
        if (term.value != null) {
          selectedWidget = Row(
            children: [
              Text('${term.name}'),
              const SizedBox(width: 10),
              SizedBox(
                height: 20,
                width: 20,
                child: ExtendedCachedImage(imageUrl: term.value),
              ),
            ],
          );
        }
      }
      selectedAttrListWidget.add(selectedWidget);
    }

    if (selectedAttrListWidget.isEmpty) {
      return null;
    } else {
      return selectedAttrListWidget;
    }
  }
}

class _Box extends StatelessWidget {
  const _Box({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: ThemeGuide.marginH5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: ThemeGuide.borderRadius,
        color: Theme.of(context).colorScheme.background,
      ),
      child: child,
    );
  }
}
