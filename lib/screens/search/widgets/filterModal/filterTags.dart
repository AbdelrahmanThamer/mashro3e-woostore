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

import '../../../../developer/dev.log.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../services/woocommerce/woocommerce.service.dart';
import '../../../../shared/widgets/error/errorReload.dart';
import '../../viewModel/searchViewModel.dart';
import 'shared/listItem.dart';

/// Fetch the tags for the application to use as a filter in the
/// search field
class FilterTags extends StatefulWidget {
  const FilterTags({Key? key}) : super(key: key);

  @override
  _FilterTagsState createState() => _FilterTagsState();
}

class _FilterTagsState extends State<FilterTags> {
  late SearchViewModel viewModel;

  bool isLoading = true;
  bool hasData = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    viewModel = Provider.of<SearchViewModel>(context, listen: false);

    // fetch the filters if not already present
    if (viewModel.tags.isEmpty) {
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
      final result = await LocatorService.tagsViewModel().getTags();
      if (result.isEmpty) {
        // show no data available
        setState(() {
          isError = false;
          isLoading = false;
          hasData = false;
        });
      }

      // If the data is available then populate the tags list in the
      // search view model.
      viewModel.setTagsList(result);
      // updateSelectedTag();
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
    final lang = S.of(context);
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
      return const _ListContainer();
    }

    return Center(
      child: Text(lang.noDataAvailable),
    );
  }
}

class _ListContainer extends StatelessWidget {
  const _ListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchViewModel>(context, listen: false);
    final list = provider.tags;

    if (list.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 40,
      child: Selector<SearchViewModel, WooStoreFilters>(
        selector: (context, d) => d.filters,
        shouldRebuild: (a, b) => a.tagId != b.tagId,
        builder: (context, searchFilters, w) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, i) {
              return HorizontalListTextItem(
                text: list[i].name,
                onTap: () => provider.setTag(list[i]),
                isSelected: list[i].id == searchFilters.tagId,
              );
            },
          );
        },
      ),
    );
  }
}
