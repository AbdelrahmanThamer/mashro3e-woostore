// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/foundation.dart';

import '../utils/creator.dart';

class NotificationModel {
  NotificationModel({
    @required this.id,
    @required this.title,
    this.subTitle,
    this.date,
    this.imageUrl,
  })  : assert(id != null),
        assert(title != null);

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? Creator.createRandomString(6);
    title = json['title'] ?? '';
    subTitle = json['subTitle'] ?? '';
    date = json['date'] ?? '';
    imageUrl = json['imageUrl'];
  }

  String id, title, subTitle, date, imageUrl;
}
