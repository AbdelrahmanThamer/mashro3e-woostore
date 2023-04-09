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

part of 'product.dart';

class PSTextSectionData extends PSSectionData {
  final String? text;
  final AppAction action;

  const PSTextSectionData({
    required int id,
    this.text = 'Some Awesome text',
    StyledData? styledData,
    this.action = const NoAction(),
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.text,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'text': text,
      'action': action.toMap(),
    };
  }

  factory PSTextSectionData.fromMap(Map<String, dynamic> map) {
    return PSTextSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      text: ModelUtils.createStringProperty(map['text']),
      styledData: StyledData.fromMap(map['styledData']),
      action: AppAction.createActionFromMap(map['action']),
    );
  }

  @override
  PSTextSectionData copyWith({
    String? text,
    StyledData? styledData,
    AppAction? action,
  }) {
    return PSTextSectionData(
      id: id,
      text: text ?? this.text,
      styledData: styledData ?? this.styledData,
      action: action ?? this.action,
    );
  }
}

class PSBannerSectionData extends PSSectionData {
  final String imageUrl;
  final AppAction action;

  const PSBannerSectionData({
    required int id,
    this.imageUrl = '',
    StyledData? styledData = const StyledData(
      marginData: PSSectionData.defaultMarginData,
      borderRadius: 10,
    ),
    this.action = const NoAction(),
  }) : super(
          id: id,
          styledData: styledData ?? PSSectionData.defaultStyledData,
          sectionType: PSSectionType.banner,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'imageUrl': imageUrl,
      'action': action.toMap(),
    };
  }

  factory PSBannerSectionData.fromMap(Map<String, dynamic> map) {
    return PSBannerSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
      styledData: StyledData.fromMap(map['styledData']),
      action: AppAction.createActionFromMap(map['action']),
    );
  }

  @override
  PSBannerSectionData copyWith({
    String? imageUrl,
    StyledData? styledData,
    AppAction? action,
  }) {
    return PSBannerSectionData(
      id: id,
      imageUrl: imageUrl ?? this.imageUrl,
      styledData: styledData ?? this.styledData,
      action: action ?? this.action,
    );
  }
}

class PSAdvancedBannerSectionData extends PSSectionData {
  final bool showNewLabel;
  final String? heading;
  final TextStyleData headingTextStyleData;
  final double? imageBorderRadius;
  final String? imageUrl;
  final String? description;
  final String? bottomDescription;
  final String? actionButtonText;
  final AppAction action;
  final BoxFit itemImageBoxFit;

  const PSAdvancedBannerSectionData({
    required int id,
    this.action = const NoAction(),
    this.showNewLabel = false,
    this.heading = '',
    this.headingTextStyleData = const TextStyleData(
      fontSize: 28,
      fontWeight: 6,
    ),
    this.imageUrl,
    this.description,
    this.imageBorderRadius = 0,
    this.bottomDescription,
    this.actionButtonText,
    StyledData? styledData,
    this.itemImageBoxFit = BoxFit.cover,
  }) : super(
          id: id,
          sectionType: PSSectionType.advancedBanner,
          styledData: styledData ?? PSSectionData.defaultStyledData,
        );

  factory PSAdvancedBannerSectionData.fromMap(Map<String, dynamic> map) {
    return PSAdvancedBannerSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      showNewLabel: ModelUtils.createBoolProperty(map['showNewLabel']),
      heading: ModelUtils.createStringProperty(map['heading']),
      headingTextStyleData: TextStyleData.fromMap(map['headingTextStyleData']),
      imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
      description: ModelUtils.createStringProperty(map['description']),
      imageBorderRadius:
          ModelUtils.createDoubleProperty(map['imageBorderRadius']),
      bottomDescription:
          ModelUtils.createStringProperty(map['bottomDescription']),
      actionButtonText:
          ModelUtils.createStringProperty(map['actionButtonText']),
      styledData: StyledData.fromMap(map['styledData']),
      action: AppAction.createActionFromMap(map['action']),
      itemImageBoxFit: EnumUtils.convertStringToBoxFit(map['itemImageBoxFit']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'showNewLabel': showNewLabel,
      'heading': heading,
      'headingTextStyleData': headingTextStyleData.toMap(),
      'imageBorderRadius': imageBorderRadius,
      'imageUrl': imageUrl,
      'description': description,
      'bottomDescription': bottomDescription,
      'actionButtonText': actionButtonText,
      'action': action.toMap(),
      'itemImageBoxFit': itemImageBoxFit.name,
    };
  }

  @override
  PSAdvancedBannerSectionData copyWith({
    bool? showNewLabel,
    String? heading,
    double? imageBorderRadius,
    String? imageUrl,
    String? description,
    String? bottomDescription,
    String? actionButtonText,
    bool? show,
    String? name,
    StyledData? styledData,
    AppAction? action,
    BoxFit? itemImageBoxFit,
    TextStyleData? headingTextStyleData,
  }) {
    return PSAdvancedBannerSectionData(
      id: id,
      showNewLabel: showNewLabel ?? this.showNewLabel,
      heading: heading ?? this.heading,
      headingTextStyleData: headingTextStyleData ?? this.headingTextStyleData,
      imageBorderRadius: imageBorderRadius ?? this.imageBorderRadius,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      bottomDescription: bottomDescription ?? this.bottomDescription,
      actionButtonText: actionButtonText ?? this.actionButtonText,
      styledData: styledData ?? this.styledData,
      action: action ?? this.action,
      itemImageBoxFit: itemImageBoxFit ?? this.itemImageBoxFit,
    );
  }
}
