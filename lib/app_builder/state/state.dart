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
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/default_app_template.dart';
import '../../constants/wooConfig.dart';
import '../default_app_builder_template.dart';
import '../models/app_template/app_screen_data/app_screen_data.dart';
import 'database.dart';

final providerOfAppTemplateState =
    StateNotifierProvider<AppTemplateNotifier, AppTemplateState>((ref) {
  return AppTemplateNotifier();
});

class AppTemplateNotifier extends StateNotifier<AppTemplateState> {
  AppTemplateNotifier()
      : super(const AppTemplateState(
          status: AppTemplateStatus.undefined,
          template: AppTemplate(),
        )) {
    fetchActiveTemplate();
  }

  Future<void> fetchActiveTemplate() async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'fetchActiveTemplate',
        className: 'AppTemplateNotifier',
        fileName: 'state.dart',
        start: true,
      );
      state = state.copyWith(status: AppTemplateStatus.loading);
      final dio = Dio(
        BaseOptions(
          baseUrl:
              '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api/app_builder',
          connectTimeout: 10000,
          receiveTimeout: 10000,
        ),
      );

      final Response response =
          await dio.get<Map<String, dynamic>>('/app_template');
      if (response.statusCode == 200) {
        if (response.data is Map && (response.data as Map).isNotEmpty) {
          final template = AppTemplate.fromMap(response.data);

          // create the template from the data
          state = state.copyWith(
            template: template,
            status: AppTemplateStatus.hasData,
          );

          // save the fetched template to database
          final database = AppTemplateDatabase();
          database.saveTemplate(template);
        }
      } else {
        if (response.data is Map &&
            (response.data as Map).containsKey('message')) {
          throw Exception(response.data['message']);
        }
        throw Exception('Could not fetch the active template from server');
      }
    } catch (e, s) {
      Dev.error(
        'Fetch active template',
        error: e is DioError ? e.message : e,
        stackTrace: s,
      );
      getTemplateFromDatabase();
    }
  }

  Future<void> getTemplateFromDatabase() async {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'getTemplateFromDatabase',
        className: 'AppTemplateNotifier',
        fileName: 'state.dart',
        start: true,
      );
      final database = AppTemplateDatabase();
      final result = await database.readActiveTemplate();
      if (result.success && result.data is AppTemplate) {
        state = state.copyWith(
          template: result.data,
          status: AppTemplateStatus.hasData,
        );
      } else {
        throw Exception('Could not get template from database');
      }
    } catch (e, s) {
      Dev.error('Get template from database', error: e, stackTrace: s);
      getDefaultAppBuilderTemplate();
    }
  }

  void getDefaultAppBuilderTemplate() {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'getDefaultAppBuilderTemplate',
        className: 'AppTemplateNotifier',
        fileName: 'state.dart',
        start: true,
      );
      if (defaultAppBuilderTemplateMap.isEmpty) {
        throw Exception('defaultAppBuilderTemplateMap is empty');
      }
      final AppTemplate template =
          AppTemplate.fromMap(defaultAppBuilderTemplateMap);
      state = state.copyWith(
        template: template,
        status: AppTemplateStatus.hasData,
      );
    } catch (e, s) {
      Dev.error('get default app builder template', error: e, stackTrace: s);
      getDefaultTemplate();
    }
  }

  void getDefaultTemplate() {
    try {
      // Function Log
      Dev.debugFunction(
        functionName: 'getDefaultTemplate',
        className: 'AppTemplateNotifier',
        fileName: 'state.dart',
        start: true,
      );
      state = state.copyWith(
        template: AppTemplate.fromMap($__defaultAppTemplateMap__$),
        status: AppTemplateStatus.hasData,
      );
    } catch (e, s) {
      Dev.error('get default template', error: e, stackTrace: s);
      state = state.copyWith(
        template: const AppTemplate(),
        status: AppTemplateStatus.noData,
      );
    }
  }
}

@immutable
class AppTemplateState {
  final AppTemplateStatus status;
  final AppTemplate template;

  const AppTemplateState({
    required this.status,
    required this.template,
  });

  AppTemplateState copyWith({
    AppTemplateStatus? status,
    AppTemplate? template,
  }) {
    return AppTemplateState(
      status: status ?? this.status,
      template: template ?? this.template,
    );
  }
}

enum AppTemplateStatus {
  loading,
  hasData,
  noData,
  undefined,
}
