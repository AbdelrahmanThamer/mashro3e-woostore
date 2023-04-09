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

part of '../customSectionData.dart';

@immutable
class TextSectionData extends CustomSectionData {
  const TextSectionData({
    required int id,
    required String name,
    required this.text,
    required bool show,
    required StyledData styledData,
    this.action = const NoAction(),
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.text,
          styledData: styledData,
        );

  final String text;
  final AppAction action;

  TextSectionData.empty({
    this.action = const NoAction(),
    this.text = '',
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Text Section',
          show: false,
          sectionType: SectionType.text,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'text': text,
      'action': action.toMap(),
    };
  }

  factory TextSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return TextSectionData(
        id: ModelUtils.createIntProperty(map['id']),
        text: ModelUtils.createStringProperty(map['text']),
        show: ModelUtils.createBoolProperty(map['show']),
        name: ModelUtils.createStringProperty(map['name']),
        styledData: StyledData.fromMap(map['styledData']),
        action: AppAction.createActionFromMap(map['action']),
      );
    } catch (_) {
      return TextSectionData.empty();
    }
  }

  @override
  TextSectionData copyWith({
    int? id,
    String? text,
    bool? show,
    String? name,
    StyledData? styledData,
    AppAction? action,
  }) {
    return TextSectionData(
      id: id ?? this.id,
      text: text ?? this.text,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      action: action ?? this.action,
    );
  }
}
