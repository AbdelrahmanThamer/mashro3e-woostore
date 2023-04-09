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
class VideoSectionData extends CustomSectionData {
  const VideoSectionData({
    required int id,
    required String name,
    required this.url,
    required bool show,
    required StyledData styledData,
    this.dimensionsData = const DimensionsData(aspectRatio: 1.7),
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.video,
          styledData: styledData,
        );

  final String url;
  final DimensionsData dimensionsData;

  VideoSectionData.empty({
    this.dimensionsData = const DimensionsData(aspectRatio: 1.7),
    this.url = '',
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Video Section',
          show: false,
          sectionType: SectionType.video,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'url': url,
      'dimensionsData': dimensionsData.toMap(),
    };
  }

  factory VideoSectionData.fromMap(Map<String, dynamic> map) {
    try {
      return VideoSectionData(
        id: ModelUtils.createIntProperty(map['id']),
        url: ModelUtils.createStringProperty(map['url']),
        show: ModelUtils.createBoolProperty(map['show']),
        name: ModelUtils.createStringProperty(map['name']),
        styledData: StyledData.fromMap(map['styledData']),
        dimensionsData: DimensionsData.fromMap(map['dimensionsData']),
      );
    } catch (_) {
      return VideoSectionData.empty();
    }
  }

  @override
  VideoSectionData copyWith({
    int? id,
    String? url,
    bool? show,
    String? name,
    StyledData? styledData,
    DimensionsData? dimensionsData,
  }) {
    return VideoSectionData(
      id: id ?? this.id,
      url: url ?? this.url,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      dimensionsData: dimensionsData ?? this.dimensionsData,
    );
  }
}
