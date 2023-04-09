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

import '../../enums/enums.dart';
import '../../generated/l10n.dart';
import '../../shared/customLoader.dart';

/// Handles the pagination for a listed screen
class PaginationController extends StateNotifier<PaginationState> {
  PaginationController({
    required this.fetchMoreData,
  }) : super(PaginationState.ideal) {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  final Future<FetchActionResponse> Function(int) fetchMoreData;

  /// Page number
  int page = 2;

  /// Controller for the grid view
  late final ScrollController _scrollController;

  ScrollController get scrollController => _scrollController;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreData();
    }
  }

  Future<void> _getMoreData() async {
    if (state == PaginationState.lastData || state == PaginationState.noData) {
      return;
    }
    if (state != PaginationState.loading) {
      state = PaginationState.loading;

      // Fetch more data
      final result = await fetchMoreData(page);

      if (result == FetchActionResponse.Failed) {
        state = PaginationState.failed;
      } else if (result == FetchActionResponse.LastData) {
        state = PaginationState.lastData;
      } else if (result == FetchActionResponse.NoDataAvailable) {
        state = PaginationState.noData;
      } else {
        // If the fetch action was successful
        state = PaginationState.ideal;
        page++;
      }
    }
  }
}

enum PaginationState {
  ideal,
  loading,
  failed,
  noData,
  lastData,
}

class PaginationLoadingIndicator extends ConsumerWidget {
  const PaginationLoadingIndicator({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final AutoDisposeStateNotifierProvider<PaginationController, PaginationState>
      controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller);

    Widget widget = const SizedBox();
    double height = 200;

    if (state == PaginationState.lastData || state == PaginationState.noData) {
      widget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            S.of(context).endOfList,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
      height = 100;
    }

    if (state == PaginationState.loading) {
      widget = const CustomLoader();
      height = 100;
    }

    return SizedBox(height: height, child: widget);
  }
}
