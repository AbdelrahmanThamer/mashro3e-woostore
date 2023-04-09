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

import '../models/notificationsModel.dart';

class NotificationsProvider with ChangeNotifier {
  final List<NotificationModel> _notificationsList = [];
  List<NotificationModel> get notificationsList => _notificationsList;

  Future<void> fetchData() async {
    // Call your API (HTTP request) here to fetch data
    await Future.delayed(const Duration(seconds: 1));
    NOTIFICATIONS_DATA.toList().forEach((n) {
      final NotificationModel obj = NotificationModel.fromJson(n);
      _notificationsList.add(obj);
    });
    notifyListeners();
  }

  void dismissNotification(NotificationModel notification) {
    _notificationsList.remove(notification);
    notifyListeners();
  }
}

const url =
    'https://github.com/AniketMalik/image-hosting/blob/master/ecommerce_app/Photo%20Assets/app_icon_thumbnail.jpg?raw=true';

// Mock Data
const NOTIFICATIONS_DATA = [
  {
    'id': 'etixkf',
    'title': 'Automated value-added implementation',
    'date': '12-07-2020',
    'subTitle': 'curae donec pharetra magna vestibulum aliquet ultrices erat',
    'imageUrl': url,
  },
  {
    'id': 'wigdux',
    'title': 'Versatile fault-tolerant internet solution',
    'date': '12-07-2020',
    'subTitle': 'mauris ullamcorper purus sit amet nulla quisque arcu libero',
    'imageUrl': url,
  },
  {
    'id': 'ccnbvc',
    'title': 'Multi-tiered demand-driven intranet',
    'date': '12-07-2020',
    'subTitle': 'quis turpis eget',
    'imageUrl': url,
  },
  {
    'id': 'tszzeh',
    'title': 'Reduced asynchronous matrix',
    'date': '12-07-2020',
    'subTitle':
        'ligula suspendisse ornare consequat lectus in est risus auctor sed',
    'imageUrl': url,
  },
  {
    'id': 'kyhawg',
    'title': 'Progressive composite pricing structure',
    'date': '12-07-2020',
    'subTitle': 'eget tincidunt eget',
    'imageUrl': url,
  },
  {
    'id': 'smtqxp',
    'title': 'Organized fault-tolerant synergy',
    'date': '12-07-2020',
    'subTitle': 'amet justo morbi ut odio cras mi',
    'imageUrl': url,
  },
  {
    'id': 'hewagf',
    'title': 'Inverse local orchestration',
    'date': '12-07-2020',
    'subTitle': 'eleifend luctus ultricies',
    'imageUrl': url,
  },
  {
    'id': 'tqllxq',
    'title': 'Proactive actuating customer loyalty',
    'date': '12-07-2020',
    'subTitle': 'lectus pellentesque at nulla',
    'imageUrl': url,
  },
  {
    'id': 'fypept',
    'title': 'Balanced heuristic time-frame',
    'date': '12-07-2020',
    'subTitle': 'lectus pellentesque at nulla',
    'imageUrl': url,
  },
  {
    'id': 'wpczvm',
    'title': 'Progressive local knowledge user',
    'date': '12-07-2020',
    'subTitle': 'nunc purus phasellus in felis donec semper',
    'imageUrl': url,
  },
  {
    'id': 'oafext',
    'title': 'Multi-channelled 5th generation policy',
    'date': '12-07-2020',
    'subTitle': 'quisque id justo sit amet sapien dignissim vestibulum',
    'imageUrl': url,
  },
  {
    'id': 'ruiyrd',
    'title': 'De-engineered tangible framework',
    'date': '12-07-2020',
    'subTitle':
        'sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar',
    'imageUrl': url,
  },
  {
    'id': 'ljwmfs',
    'title': 'Horizontal full-range throughput',
    'date': '12-07-2020',
    'subTitle': 'eu magna vulputate luctus cum sociis',
    'imageUrl': url,
  },
  {
    'id': 'wewquw',
    'title': 'Exclusive 24/7 throughput',
    'date': '12-07-2020',
    'subTitle': 'ut tellus nulla',
    'imageUrl': url,
  },
  {
    'id': 'tezdmz',
    'title': 'Optional intermediate time-frame',
    'date': '12-07-2020',
    'subTitle': 'eu nibh quisque',
    'imageUrl': url,
  },
  {
    'id': 'cawqwd',
    'title': 'Programmable 24 hour open system',
    'date': '12-07-2020',
    'subTitle': 'tortor sollicitudin mi sit amet lobortis',
    'imageUrl': url,
  },
  {
    'id': 'nggfke',
    'title': 'Multi-channelled encompassing moratorium',
    'date': '12-07-2020',
    'subTitle':
        'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus',
    'imageUrl': url,
  },
  {
    'id': 'dragis',
    'title': 'Reactive transitional installation',
    'date': '12-07-2020',
    'subTitle': 'sit amet eleifend pede libero quis',
    'imageUrl': url,
  },
  {
    'id': 'kzuddb',
    'title': 'Organized static parallelism',
    'date': '12-07-2020',
    'subTitle': 'morbi odio odio elementum eu',
    'imageUrl': url,
  },
  {
    'id': 'goapfd',
    'title': 'Business-focused local extranet',
    'date': '12-07-2020',
    'subTitle':
        'blandit lacinia erat vestibulum sed magna at nunc commodo placerat',
    'imageUrl': url,
  }
];
