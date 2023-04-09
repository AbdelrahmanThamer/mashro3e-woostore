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

import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

/// ## Description
///
/// Data class for push notification messages.
@immutable
class PSNotification {
  final int? id;
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final String? time;

  /// Milliseconds since epoch
  final int? timeStamp;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const PSNotification({
    this.id,
    this.title,
    this.body,
    this.data,
    this.time,
    this.timeStamp,
  });

  static PSNotification fromRemoteMessage(RemoteMessage remoteMessage) {
    return PSNotification(
      id: Random().nextInt(10000),
      title: remoteMessage.notification?.title ?? '',
      body: remoteMessage.notification?.body ?? '',
      data: remoteMessage.data,
      time: DateFormat('d MMM \'\'yy h:mm a')
          .format(remoteMessage.sentTime ?? DateTime.now()),
      timeStamp: remoteMessage.sentTime?.millisecondsSinceEpoch,
    );
  }

  PSNotification copyWith({
    int? id,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    String? time,
    int? timeStamp,
  }) {
    return PSNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      time: time ?? this.time,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  String toString() {
    return 'PSNotification{id: $id, title: $title, body: $body, data: $data, time: $time, timeStamp: $timeStamp}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PSNotification &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          body == other.body &&
          data == other.data &&
          timeStamp == other.timeStamp &&
          time == other.time);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      body.hashCode ^
      data.hashCode ^
      timeStamp.hashCode ^
      time.hashCode;

  factory PSNotification.fromMap(Map<String, dynamic> map) {
    return PSNotification(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      data: map['data'] != null ? Map<String, dynamic>.from(map['data']) : {},
      time: map['time'] as String,
      timeStamp: map['timeStamp'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': id,
      'title': title,
      'body': body,
      'data': data,
      'time': time,
      'timeStamp': timeStamp,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
