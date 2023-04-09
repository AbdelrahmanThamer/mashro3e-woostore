// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

part of 'app_bars.dart';

@immutable
class AppBarData {
  final String? title;
  final String? logo;
  final AppBarActionButtonData? leading;
  final List<AppBarActionButtonData> actionButtons;
  final bool show;

  final bool centerTitle;
  final bool pinned;
  final bool floating;

  const AppBarData({
    this.title,
    this.logo,
    this.leading,
    this.actionButtons = const [],
    this.centerTitle = false,
    this.pinned = false,
    this.floating = true,
    this.show = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'logo': logo,
      'leading': leading?.toMap(),
      'actionButtons': actionButtons.map((e) => e.toMap()).toList(),
      'centerTitle': centerTitle,
      'pinned': pinned,
      'floating': floating,
      'show': show,
    };
  }

  factory AppBarData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const AppBarData();
    }
    return AppBarData(
      title: ModelUtils.createStringProperty(map['title']),
      logo: ModelUtils.createStringProperty(map['logo']),
      leading: AppBarActionButtonData.fromMap(map['leading']),
      actionButtons: ModelUtils.createListOfType<AppBarActionButtonData>(
        map['actionButtons'],
        (e) => AppBarActionButtonData.fromMap(e),
      ),
      centerTitle: ModelUtils.createBoolProperty(map['centerTitle'], false),
      pinned: ModelUtils.createBoolProperty(map['pinned'], false),
      floating: ModelUtils.createBoolProperty(map['floating'], true),
      show: ModelUtils.createBoolProperty(map['show'], true),
    );
  }

  AppBarData copyWith({
    String? title,
    String? logo,
    AppBarActionButtonData? leading,
    List<AppBarActionButtonData>? actionButtons,
    bool? centerTitle,
    bool? pinned,
    bool? floating,
    bool? show,
  }) {
    return AppBarData(
      title: title ?? this.title,
      logo: logo ?? this.logo,
      leading: leading ?? this.leading,
      actionButtons: actionButtons ?? this.actionButtons,
      centerTitle: centerTitle ?? this.centerTitle,
      pinned: pinned ?? this.pinned,
      floating: floating ?? this.floating,
      show: show ?? this.show,
    );
  }
}

class AppBarActionButtonData {
  /// Id to identify the item
  final int id;
  final IconData iconData;
  final String? tooltip;
  final AppAction action;
  final String? color;
  final double? size;
  final bool allowDelete, allowChangeAction;
  final bool hidden;

  const AppBarActionButtonData({
    this.id = 0,
    this.iconData = EvaIcons.radioButtonOff,
    this.tooltip,
    this.action = const NoAction(),
    this.color,
    this.size = 24,
    this.allowDelete = true,
    this.hidden = false,
    this.allowChangeAction = true,
  });

  AppBarActionButtonData.newItem({
    this.iconData = Icons.more_vert_rounded,
    this.tooltip,
    this.action = const NoAction(),
    this.color,
    this.size = 24,
    this.allowDelete = true,
    this.hidden = false,
    this.allowChangeAction = true,
  }) : id = Random().nextInt(1000);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'iconData': {
        'codePoint': iconData.codePoint,
        'fontFamily': iconData.fontFamily,
        'fontPackage': iconData.fontPackage,
      },
      'tooltip': tooltip,
      'action': action.toMap(),
      'color': color,
      'size': size,
      'allowDelete': allowDelete,
      'allowChangeAction': allowChangeAction,
      'hidden': hidden,
    };
  }

  factory AppBarActionButtonData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const AppBarActionButtonData(hidden: true);
    }
    return AppBarActionButtonData(
      id: ModelUtils.createIntProperty(map['id']),
      iconData: IconData(
        ModelUtils.createIntProperty(map['iconData']['codePoint']),
        fontFamily:
            ModelUtils.createStringProperty(map['iconData']['fontFamily']),
        fontPackage:
            ModelUtils.createStringProperty(map['iconData']['fontPackage']),
      ),
      tooltip: ModelUtils.createStringProperty(map['tooltip']),
      color: ModelUtils.createStringProperty(map['color']),
      size: ModelUtils.createDoubleProperty(map['size'], 24),
      action: AppAction.createActionFromMap(map['action']),
      allowDelete: ModelUtils.createBoolProperty(map['allowDelete']),
      hidden: ModelUtils.createBoolProperty(map['hidden']),
      allowChangeAction:
          ModelUtils.createBoolProperty(map['allowChangeAction']),
    );
  }

  @override
  String toString() {
    return 'AppBarIconData{id: $id, tooltip: $tooltip, size: $size}';
  }

  AppBarActionButtonData copyWith({
    IconData? iconData,
    String? tooltip,
    String? color,
    double? size,
    AppAction? action,
    bool? hidden,
  }) {
    return AppBarActionButtonData(
      id: id,
      iconData: iconData ?? this.iconData,
      tooltip: tooltip ?? this.tooltip,
      action: action ?? this.action,
      color: color ?? this.color,
      size: size ?? this.size,
      hidden: hidden ?? this.hidden,
      allowDelete: allowDelete,
      allowChangeAction: allowChangeAction,
    );
  }
}
