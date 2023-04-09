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

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../generated/l10n.dart';
import '../../services/pushNotification/models/notification.dart';
import '../../services/pushNotification/storage/local_storage.dart';
import '../../shared/customLoader.dart';
import '../../shared/widgets/error/errorReload.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import '../../themes/themeGuide.dart';
import '../../utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<PSNotification> _notificationsList = [];

  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _notificationsList = null;
    isLoading = null;
    error = null;
    PSNotificationLocalStorage.closeNotificationBox();
    super.dispose();
  }

  Future<void> getData() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          error = '';
        });
      }
      _notificationsList = await PSNotificationLocalStorage.getNotifications();
      if (mounted) {
        setState(() {
          isLoading = false;
          error = '';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          error = Utils.renderException(e);
        });
      }
    }
  }

  void dismissNotification(PSNotification notification) {
    _notificationsList.remove(notification);
    PSNotificationLocalStorage.deleteNotification(notification);
    if (mounted) {
      setState(() {});
    }
  }

  void clearAll() {
    PSNotificationLocalStorage.clearAllNotifications();
    if (mounted) {
      setState(() {
        _notificationsList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notifications),
        actions: [
          IconButton(
            onPressed: clearAll,
            icon: const Icon(Icons.clear_all_rounded),
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: _renderBody(),
    );
  }

  Widget _renderBody() {
    if (isLoading) {
      return const Center(child: CustomLoader());
    }

    if (isNotBlank(error)) {
      return ErrorReload(
        errorMessage: error,
        reloadFunction: getData,
      );
    }

    if (_notificationsList.isEmpty) {
      return const NoDataAvailableImage();
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: ThemeGuide.listPadding,
      itemCount: _notificationsList.length,
      itemBuilder: (context, int index) {
        return _NotificationListItem(
          notification: _notificationsList[index],
          dismissFunction: dismissNotification,
        );
      },
    );
  }
}

class _NotificationListItem extends StatelessWidget {
  const _NotificationListItem({
    Key key,
    this.notification,
    this.dismissFunction,
  }) : super(key: key);
  final PSNotification notification;
  final void Function(PSNotification) dismissFunction;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Dismissible(
      onDismissed: (direction) {
        if (dismissFunction != null && dismissFunction is Function) {
          dismissFunction(notification);
        }
      },
      background: Container(
        margin: ThemeGuide.marginV5,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: ThemeGuide.borderRadius10,
        ),
      ),
      key: ValueKey(notification.id),
      child: Container(
        margin: ThemeGuide.marginV5,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: _theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    notification.time,
                    style: ThemeGuide.isDarkMode(context)
                        ? const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.w500,
                          )
                        : const TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                notification.body,
                style: ThemeGuide.isDarkMode(context)
                    ? const TextStyle(
                        color: Colors.white70,
                      )
                    : const TextStyle(
                        color: Colors.black54,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
