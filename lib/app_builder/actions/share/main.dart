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
class ShareAction extends AppAction {
  const ShareAction({
    this.subject,
    this.content,
  }) : super(type: AppActionType.share);

  final String? subject;
  final String? content;

  factory ShareAction.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const ShareAction();
      }
      return ShareAction(
        subject: ModelUtils.createStringProperty(map['subject']),
        content: ModelUtils.createStringProperty(map['content']),
      );
    } catch (_) {
      return const ShareAction();
    }
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'subject': subject,
      'content': content,
    };
  }

  @override
  ShareAction copyWith({
    String? subject,
    String? content,
  }) {
    return ShareAction(
      subject: subject ?? this.subject,
      content: content ?? this.content,
    );
  }
}
