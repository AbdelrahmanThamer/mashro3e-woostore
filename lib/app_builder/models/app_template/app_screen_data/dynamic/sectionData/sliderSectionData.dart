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
class SliderSectionData extends CustomSectionData {
  final double height;
  final double itemBorderRadius;
  final bool autoplay;
  final BoxFit itemImageBoxFit;
  final List<SliderSectionDataItem> items;

  const SliderSectionData({
    required int id,
    required String name,
    required bool show,
    this.height = 200,
    this.itemBorderRadius = 10,
    this.autoplay = false,
    this.itemImageBoxFit = BoxFit.cover,
    required this.items,
    required StyledData styledData,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.slider,
          styledData: styledData,
        );

  SliderSectionData.empty({
    this.height = 200.0,
    this.itemBorderRadius = 0,
    this.autoplay = false,
    this.items = const [],
    this.itemImageBoxFit = BoxFit.cover,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Slider Section',
          show: false,
          sectionType: SectionType.slider,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'height': height,
      'itemBorderRadius': itemBorderRadius,
      'autoplay': autoplay,
      'items': items.map((e) => e.toMap()).toList(),
      'itemImageBoxFit': itemImageBoxFit.name,
    };
  }

  factory SliderSectionData.fromMap(Map<String, dynamic> map) {
    return SliderSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      height: ModelUtils.createDoubleProperty(map['height'], 200),
      itemBorderRadius:
          ModelUtils.createDoubleProperty(map['itemBorderRadius']),
      autoplay: ModelUtils.createBoolProperty(map['autoplay']),
      items: ModelUtils.createListOfType<SliderSectionDataItem>(
        map['items'],
        (elem) => SliderSectionDataItem.fromMap(elem),
      ),
      show: ModelUtils.createBoolProperty(map['show']),
      name: ModelUtils.createStringProperty(map['name']),
      styledData: StyledData.fromMap(map['styledData']),
      itemImageBoxFit: EnumUtils.convertStringToBoxFit(map['itemImageBoxFit']),
    );
  }

  @override
  SliderSectionData copyWith({
    int? id,
    List<SliderSectionDataItem>? items,
    double? height,
    double? itemBorderRadius,
    double? margin,
    bool? autoplay,
    bool? show,
    String? name,
    StyledData? styledData,
    BoxFit? itemImageBoxFit,
  }) {
    return SliderSectionData(
      id: id ?? this.id,
      height: height ?? this.height,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      autoplay: autoplay ?? this.autoplay,
      show: show ?? this.show,
      items: items ?? this.items,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      itemImageBoxFit: itemImageBoxFit ?? this.itemImageBoxFit,
    );
  }
}

@immutable
class SliderSectionDataItem {
  final int id;
  final String imageUrl;
  final String title;
  final AppAction action;

  const SliderSectionDataItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.action = const NoAction(),
  });

  SliderSectionDataItem.empty({
    this.imageUrl = '',
    this.title = '',
    this.action = const NoAction(),
  }) : id = CustomSectionUtils.generateUUID();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'action': action.toMap(),
    };
  }

  factory SliderSectionDataItem.fromMap(Map<String, dynamic> map) {
    try {
      return SliderSectionDataItem(
        id: ModelUtils.createIntProperty(map['id']),
        imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
        title: ModelUtils.createStringProperty(map['title']),
        action: AppAction.createActionFromMap(map['action']),
      );
    } catch (_) {
      return SliderSectionDataItem.empty();
    }
  }

  SliderSectionDataItem copyWith({
    String? imageUrl,
    String? title,
    AppAction? action,
  }) {
    return SliderSectionDataItem(
      id: id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      action: action ?? this.action,
    );
  }
}
