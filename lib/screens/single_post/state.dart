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
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

import '../../constants/wooConfig.dart';
import '../../models/models.dart';

final providerOfSinglePostState = StateNotifierProvider.autoDispose
    .family<SinglePostStateNotifier, SinglePostState, int>((ref, postId) {
  return SinglePostStateNotifier(postId);
});

class SinglePostStateNotifier extends StateNotifier<SinglePostState> {
  SinglePostStateNotifier(int postId) : super(const SinglePostState()) {
    fetchPost(postId);
  }

  static const String baseUrl =
      '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api/posts';

  Future<void> fetchPost(int postId) async {
    try {
      state = state.copyWith(status: SinglePostStateStatus.loading);
      final result = await Dio().get('$baseUrl/$postId');
      if (result.statusCode == 200 &&
          result.data is Map &&
          (result.data as Map).containsKey('content')) {
        final wp = WordpressPost.fromMap(result.data);
        state = state.copyWith(
          post: wp,
          status: SinglePostStateStatus.hasData,
        );
      } else {
        throw Exception(
            'Could not get the post from server. Server responded with a statusCode of ${result.statusCode}');
      }
    } on DioError catch (e, s) {
      Dev.error('Dio error Fetch single post', error: e, stackTrace: s);
      String errorMessage = ExceptionUtils.renderException(e);
      if (e.response != null && e.response!.data != null) {
        if (e.response!.data is Map && (e.response!.data as Map).isNotEmpty) {
          e.response!.data as Map;
          if (e.response!.data.containsKey('message')) {
            errorMessage =
                ExceptionUtils.renderException(e.response!.data['message']);
          }
        } else {
          errorMessage = ExceptionUtils.renderException(e.response!.data);
        }
      } else {
        errorMessage = e.message;
      }
      state = state.copyWith(
        status: SinglePostStateStatus.error,
        post: null,
        errorMessage: errorMessage,
      );
    } catch (e, s) {
      Dev.error('Fetch single post error', error: e, stackTrace: s);
      state = state.copyWith(
        status: SinglePostStateStatus.error,
        post: null,
        errorMessage: ExceptionUtils.renderException(e),
      );
    }
  }
}

@immutable
class SinglePostState {
  final SinglePostStateStatus status;
  final WordpressPost? post;
  final String? errorMessage;

  const SinglePostState({
    this.status = SinglePostStateStatus.undefined,
    this.post,
    this.errorMessage,
  });

  SinglePostState copyWith({
    SinglePostStateStatus? status,
    WordpressPost? post,
    String? errorMessage,
  }) {
    return SinglePostState(
      status: status ?? this.status,
      post: post ?? this.post,
      errorMessage: errorMessage,
    );
  }
}

enum SinglePostStateStatus {
  loading,
  hasData,
  noData,
  error,
  undefined,
}
