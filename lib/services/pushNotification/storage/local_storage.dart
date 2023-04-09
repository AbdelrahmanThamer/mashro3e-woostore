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

import 'package:hive/hive.dart';

import '../models/notification.dart';

abstract class PSNotificationLocalStorage {
  static const String notificationBox = 'notificationBox';

  static Future<Box> _getNotificationBox() async {
    if (Hive.isBoxOpen(notificationBox)) {
      return Hive.box(notificationBox);
    } else {
      return await Hive.openBox(notificationBox);
    }
  }

  static Future<void> closeNotificationBox() async {
    if (Hive.isBoxOpen(notificationBox)) {
      Hive.box(notificationBox).close();
    }
  }

  static Future<void> clearAllNotifications() async {
    final box = await _getNotificationBox();
    await box.clear();
  }

  /// Saves a notification to the local storage
  static Future<void> saveNotification(PSNotification notification) async {
    final box = await _getNotificationBox();
    box.put(notification.id, notification.toMap());
  }

  /// Delete the specified notification from local storage
  static Future<void> deleteNotification(PSNotification notification) async {
    final box = await _getNotificationBox();
    box.delete(notification.id);
  }

  /// Get the full list of notifications
  static Future<List<PSNotification>> getNotifications() async {
    final box = await _getNotificationBox();
    final List<PSNotification> result = [];
    for (final o in box.values) {
      if (o == null) {
        continue;
      }
      result.add(PSNotification.fromMap(Map<String, dynamic>.from(o)));
    }
    result.sort((n1, n2) {
      return n2.timeStamp?.compareTo(n1.timeStamp ?? 0) ?? 0;
    });
    return result;
  }
}
