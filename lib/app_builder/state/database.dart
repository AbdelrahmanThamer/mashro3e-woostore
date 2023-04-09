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

import 'dart:convert';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiver/strings.dart';

import '../app_builder.dart';
import 'model.dart';

abstract class AppTemplateDatabaseInterface {
  static const String templateBoxKey = 'templateBox';
  static const String activeTemplateKey = 'activeTemplate';

  Future<ActionResponse> saveTemplate(AppTemplate template);

  Future<ActionResponse<AppTemplate>> readActiveTemplate();
}

class AppTemplateDatabase implements AppTemplateDatabaseInterface {
  @override
  Future<ActionResponse<AppTemplate>> readActiveTemplate() async {
    try {
      final box =
          await Hive.openBox(AppTemplateDatabaseInterface.templateBoxKey);
      final String? activeTemplateId = await box.get(
        AppTemplateDatabaseInterface.activeTemplateKey,
      );

      if (isBlank(activeTemplateId)) {
        throw Exception('No active template id found');
      }

      final String? jsonString = await box.get(activeTemplateId);
      if (isBlank(jsonString)) {
        throw Exception('Active template map data was empty');
      }

      final templateMap =
          Map.from(await compute(jsonDecode, jsonString!) as Map)
              .cast<String, dynamic>();

      if (templateMap.isNotEmpty) {
        final AppTemplate t = AppTemplate.fromMap(templateMap);
        return ActionResponse<AppTemplate>.success(data: t);
      }

      throw Exception('Could not find the template');
    } catch (e, s) {
      Dev.error('readActiveTemplate error', error: e, stackTrace: s);
      return ActionResponse.failure(
        message: ExceptionUtils.renderException(e),
      );
    }
  }

  @override
  Future<ActionResponse> saveTemplate(AppTemplate template) async {
    try {
      final String jsonString = await compute(jsonEncode, template.toMap());

      final box =
          await Hive.openBox(AppTemplateDatabaseInterface.templateBoxKey);

      // Save the template
      await box.put(template.id.toString(), jsonString);

      // Save the active template id
      await box.put(
        AppTemplateDatabaseInterface.activeTemplateKey,
        template.id.toString(),
      );

      return const ActionResponse.success();
    } catch (e, s) {
      Dev.error('SaveTemplate Error', error: e, stackTrace: s);
      return ActionResponse.failure(message: ExceptionUtils.renderException(e));
    }
  }
}
