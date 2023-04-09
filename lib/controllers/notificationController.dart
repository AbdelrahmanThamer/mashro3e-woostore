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

import 'dart:developer';

///
/// ## `Description`
///
/// Takes care of the notification in the local scope.
/// Handle the incoming notification data and reacts to it
/// based on the type of data is provided.
///
class NotificationController {
  static bool _isNotificationClicked = false;
  bool get isNotificationClicked => _isNotificationClicked;
  void setNotificationClicked(bool value) {
    log('setting notification cliccked with value $value');
    _isNotificationClicked = value;
  }

  static Map<String, dynamic> _notificationObject = {};
  Map<String, dynamic> get notificationObject => _notificationObject;
  void setNotificationObject(Map<String, dynamic> object) {
    _notificationObject = object;
  }
}
