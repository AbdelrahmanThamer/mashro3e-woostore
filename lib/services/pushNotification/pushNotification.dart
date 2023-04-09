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

import 'dart:convert';
import 'dart:math' as math;

import 'package:am_common_packages/am_common_packages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiver/strings.dart';

import '../storage/localStorage.dart';
import 'models/notification.dart';
import 'storage/local_storage.dart';

/// FCM Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initiate Hive DB
  await Hive.initFlutter();
  // Save the notification
  PSNotificationLocalStorage.saveNotification(
    PSNotification.fromRemoteMessage(message),
  );
}

/// Handles all the push notification related functionality of the application.
/// Creates and refreshes [deviceToken], register notification handlers.
abstract class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// The token to identify the device for push notifications.
  static String _deviceToken = '';

  /// Getter for deviceToken
  String get deviceToken => _deviceToken;

  /// Initializes the tasks required to run at application startup or when
  /// the application is run for the very first time.
  static Future<void> initialize() async {
    await registerNotification();
    await configLocalNotification();
  }

  /// Request permissions
  static Future<void> requestPermissions() async {
    await _firebaseMessaging.requestPermission();
  }

  /// Initial notification setup on application startup.
  static Future<void> registerNotification() async {
    // Force show notification on iOS and Android
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    // Handle notification when the application is in session
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = 'New Notification';
      String body = 'You have new notifications, come and check them out.';

      if (message.notification != null) {
        title = message.notification?.title ?? title;
        body = message.notification?.body ?? body;
      }

      showNotification(
        title: title,
        body: body,
        payload: message,
      );

      // Save the notification
      PSNotificationLocalStorage.saveNotification(
        PSNotification.fromRemoteMessage(message),
      );
    });

    // Handle notification when the application is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    // Handle background message here
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// FCM handler when the application wakes from a terminated state.
    final RemoteMessage? _initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (_initialMessage != null) {
      // It means the application woke up from a terminated state.
      // Probably add to notifications storage
    }
  }

  /// Generates, stores, updates and returns the device token for the
  /// application
  ///
  /// [callBack] is called on new Token generation if there is no previous
  /// token saved or there is new token which is different from the
  /// old saved one.
  static Future<String?> generateDeviceToken(
      {required Function(String) callBack}) async {
    try {
      final token = await _firebaseMessaging.getToken();

      if (isBlank(token)) {
        return null;
      }

      // Check for saved token
      final savedToken =
          await LocalStorage.getString(LocalStorageConstants.USER_PUSH_TOKEN);

      // compare saved token with new token
      if (savedToken != null && savedToken == token) {
        return savedToken;
      }

      _deviceToken = token!;
      await LocalStorage.setString(
          LocalStorageConstants.USER_PUSH_TOKEN, token);
      callBack(token);
      return token;
    } catch (_) {
      return null;
    }
  }

  /// Listens for a refresh token.
  ///
  /// ## `IMPORTANT`
  /// Run on app initialization after the user data is downloaded.
  /// Run only after the user data is fetched.
  static void listenForRefreshedToken(Function(String) callBack) {
    _firebaseMessaging.onTokenRefresh.listen((String token) async {
      // Check for saved token
      final savedToken =
          await LocalStorage.getString(LocalStorageConstants.USER_PUSH_TOKEN);

      // compare saved token with new token
      if (savedToken != null && savedToken == token) {
        return;
      }
      _deviceToken = token;
      await LocalStorage.setString(
          LocalStorageConstants.USER_PUSH_TOKEN, token);
      callBack(token);
    }, cancelOnError: true);
  }

  /// Used to subscribe to specific topics
  static Future<void> subscribeToTopic({required String topic}) async {
    if (isBlank(topic)) {
      return;
    }
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  /// Used to subscribe to specific topics
  static Future<void> subscribeToMultipleTopics(List<String>? topics) async {
    Dev.info('Setting up notification topics');
    if (topics == null || topics.isEmpty) {
      return;
    }
    for (final val in topics) {
      await _firebaseMessaging.subscribeToTopic(val);
    }
  }

  /// Configure how the local notifications are shown to the user when the
  /// application is in different states.
  static Future<void> configLocalNotification() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      if (isNotBlank(payload)) {
        final message = json.decode(payload!);

        // Cancel so that the notification is not added many times
        _flutterLocalNotificationsPlugin.cancel(message['id'] as int);
      }

      return;
    });
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    RemoteMessage? payload,
  }) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'main_notification_channel',
      'All Notifications',
      channelDescription: 'Processes all notifications',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.max,
      visibility: NotificationVisibility.public,
      ticker: 'Notification',
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    final int _notificationId =
        payload?.notification?.hashCode ?? math.Random().nextInt(100);
    await _flutterLocalNotificationsPlugin.show(
      _notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: json.encode({
        'id': _notificationId,
        'data': payload?.data,
        'notification': {'title': title, 'body': body}
      }),
    );
  }
}
