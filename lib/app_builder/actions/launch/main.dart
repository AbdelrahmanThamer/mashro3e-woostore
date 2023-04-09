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
import 'package:flutter/material.dart';

import '../actions.dart';

/// ## Description
///
/// Action to open a launch related application based on the url
/// scheme
@immutable
class LaunchAction extends AppAction {
  const LaunchAction({
    this.url,
  }) : super(type: AppActionType.launch);

  /// The URL to link to the
  final String? url;

  factory LaunchAction.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const LaunchAction();
      }
      return LaunchAction(url: ModelUtils.createStringProperty(map['url']));
    } catch (_) {
      return const LaunchAction();
    }
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'url': url,
    };
  }

  @override
  LaunchAction copyWith({
    String? url,
  }) {
    return LaunchAction(url: url ?? this.url);
  }
}
