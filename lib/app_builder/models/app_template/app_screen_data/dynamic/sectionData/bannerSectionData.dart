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

part of '../customSectionData.dart';

@immutable
class BannerSectionData extends CustomSectionData {
  const BannerSectionData({
    required int id,
    required String name,
    required this.imageUrl,
    required this.imageBorderRadius,
    required bool show,
    required StyledData styledData,
    this.imageBoxFit = BoxFit.cover,
    this.action = const NoAction(),
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.banner,
          styledData: styledData,
        );

  final String imageUrl;
  final double imageBorderRadius;

  final AppAction action;
  final BoxFit imageBoxFit;

  BannerSectionData.empty({
    this.action = const NoAction(),
    this.imageUrl = '',
    this.imageBorderRadius = 0,
    this.imageBoxFit = BoxFit.cover,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Banner Section',
          show: false,
          sectionType: SectionType.banner,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'imageUrl': imageUrl,
      'imageBorderRadius': imageBorderRadius.toString(),
      'action': action.toMap(),
      'imageBoxFit': imageBoxFit.name,
    };
  }

  factory BannerSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return BannerSectionData(
        id: ModelUtils.createIntProperty(map['id']),
        imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
        imageBorderRadius:
            ModelUtils.createDoubleProperty(map['imageBorderRadius']),
        show: ModelUtils.createBoolProperty(map['show']),
        name: ModelUtils.createStringProperty(map['name']),
        styledData: StyledData.fromMap(map['styledData']),
        action: AppAction.createActionFromMap(map['action']),
        imageBoxFit: EnumUtils.convertStringToBoxFit(map['imageBoxFit']),
      );
    } catch (_) {
      return BannerSectionData.empty();
    }
  }

  @override
  BannerSectionData copyWith({
    int? id,
    String? imageUrl,
    double? imageBorderRadius,
    bool? show,
    String? name,
    StyledData? styledData,
    AppAction? action,
    BoxFit? imageBoxFit,
  }) {
    return BannerSectionData(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      imageBorderRadius: imageBorderRadius ?? this.imageBorderRadius,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      action: action ?? this.action,
      imageBoxFit: imageBoxFit ?? this.imageBoxFit,
    );
  }
}
