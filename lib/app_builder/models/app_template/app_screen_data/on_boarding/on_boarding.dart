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
import 'package:path/path.dart' as pp;
import 'package:quiver/strings.dart';

import '../../../models.dart';

@immutable
class AppOnBoardingScreenData extends AppScreenData {
  const AppOnBoardingScreenData({
    int id = AppPrebuiltScreensId.onBoarding,
    AppScreenType screenType = AppScreenType.preBuilt,
    String name = AppPrebuiltScreensNames.onBoarding,
    this.pages = onBoardingDefaultPages,
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.onBoarding,
          screenType: screenType,
        );

  final List<OBPageData> pages;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'pages': pages.map((e) => e.toMap()).toList(),
    };
  }

  factory AppOnBoardingScreenData.fromMap(Map<String, dynamic> map) {
    return AppOnBoardingScreenData(
      id: ModelUtils.createIntProperty(map['id']),
      screenType: AppScreenData.getScreenType(map['screenType']),
      pages: ModelUtils.createListOfType<OBPageData>(
        map['pages'],
        (elem) => OBPageData.fromMap(elem),
      ),
    );
  }

  @override
  AppOnBoardingScreenData copyWith({
    String? name,
    List<OBPageData>? pages,
  }) {
    return AppOnBoardingScreenData(
      id: id,
      screenType: screenType,
      name: name ?? this.name,
      pages: pages ?? this.pages,
    );
  }
}

@immutable
class OBPageData {
  final int id;
  final OBTextData titleData;
  final OBTextData descriptionData;
  final OBAssetData assetData;

  const OBPageData({
    required this.id,
    required this.titleData,
    required this.descriptionData,
    required this.assetData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titleData': titleData.toMap(),
      'descriptionData': descriptionData.toMap(),
      'assetData': assetData.toMap(),
    };
  }

  factory OBPageData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const OBPageData(
        id: 0,
        titleData: OBTextData(),
        descriptionData: OBTextData(),
        assetData: OBAssetData(),
      );
    }

    return OBPageData(
      id: ModelUtils.createIntProperty(map['id']),
      titleData: OBTextData.fromMap(map['titleData']),
      descriptionData: OBTextData.fromMap(map['descriptionData']),
      assetData: OBAssetData.fromMap(map['assetData']),
    );
  }

  OBPageData copyWith({
    OBTextData? titleData,
    OBTextData? descriptionData,
    OBAssetData? assetData,
  }) {
    return OBPageData(
      id: id,
      titleData: titleData ?? this.titleData,
      descriptionData: descriptionData ?? this.descriptionData,
      assetData: assetData ?? this.assetData,
    );
  }
}

@immutable
class OBTextData {
  final String? label;
  final TextStyleData textStyleData;

  const OBTextData({
    this.label,
    this.textStyleData = const TextStyleData(
      alignment: TextAlign.center,
    ),
  });

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'textStyleData': textStyleData.toMap(),
    };
  }

  factory OBTextData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const OBTextData();
    }
    return OBTextData(
      label: ModelUtils.createStringProperty(map['label']),
      textStyleData: TextStyleData.fromMap(map['textStyleData']),
    );
  }

  OBTextData copyWith({
    String? label,
    TextStyleData? textStyleData,
  }) {
    return OBTextData(
      label: label ?? this.label,
      textStyleData: textStyleData ?? this.textStyleData,
    );
  }
}

enum OBAssetType {
  svg,
  png,
  jpg,
  jpeg,
  image,
  undefined,
}

@immutable
class OBAssetData {
  final String? path;
  final double height;
  final double width;
  final BoxFit boxFit;
  final bool allowFullWidth;
  final OBAssetType type;

  const OBAssetData({
    this.path,
    this.height = 200,
    this.width = 200,
    this.boxFit = BoxFit.cover,
    this.allowFullWidth = true,
    this.type = OBAssetType.undefined,
  });

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'height': height,
      'width': width,
      'boxFit': boxFit.name,
      'allowFullWidth': allowFullWidth,
      'type': type.name,
    };
  }

  factory OBAssetData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const OBAssetData();
    }

    return OBAssetData(
      path: ModelUtils.createStringProperty(map['path']),
      height: ModelUtils.createDoubleProperty(map['height'], 200),
      width: ModelUtils.createDoubleProperty(map['width'], 200),
      boxFit: _getFitType(map['boxFit']),
      allowFullWidth: ModelUtils.createBoolProperty(map['allowFullWidth']),
      type: _getAssetType(map['type']),
    );
  }

  static OBAssetType _getAssetType(String? name) {
    switch (name) {
      case 'svg':
        return OBAssetType.svg;

      case 'png':
        return OBAssetType.png;

      case 'jpg':
        return OBAssetType.jpg;

      case 'jpeg':
        return OBAssetType.jpeg;

      default:
        return OBAssetType.undefined;
    }
  }

  static BoxFit _getFitType(String? name) {
    switch (name) {
      case 'contain':
        return BoxFit.contain;
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'fitHeight':
        return BoxFit.fitHeight;
      case 'fitWidth':
        return BoxFit.fitWidth;
      case 'scaleDown':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  OBAssetData copyWith({
    String? path,
    double? height,
    double? width,
    BoxFit? boxFit,
    bool? allowFullWidth,
  }) {
    return OBAssetData(
      path: path ?? this.path,
      height: height ?? this.height,
      width: width ?? this.width,
      boxFit: boxFit ?? this.boxFit,
      allowFullWidth: allowFullWidth ?? this.allowFullWidth,
      type: getOBAssetType(path ?? this.path),
    );
  }

  static OBAssetType getOBAssetType(String? val) {
    if (isBlank(val)) {
      return OBAssetType.undefined;
    }
    final extension = pp.extension(val!);
    switch (extension) {
      case '.svg':
        return OBAssetType.svg;
      case '.jpeg':
        return OBAssetType.image;
      case '.jpg':
        return OBAssetType.image;
      case '.png':
        return OBAssetType.image;
      case '.gif':
        return OBAssetType.image;
      default:
        return OBAssetType.image;
    }
  }
}

const List<OBPageData> onBoardingDefaultPages = [
  OBPageData(
    id: 1,
    titleData: OBTextData(
      label: 'Shop all that you want',
      textStyleData: TextStyleData(
        fontSize: 16,
        fontWeight: 6,
      ),
    ),
    descriptionData: OBTextData(
      label:
          'You get a wide variety of products all just a few clicks away! Hurry get them all',
    ),
    assetData: OBAssetData(),
  ),
  OBPageData(
    id: 2,
    titleData: OBTextData(
      label: 'Easy shopping experience',
      textStyleData: TextStyleData(
        fontSize: 16,
        fontWeight: 6,
      ),
    ),
    descriptionData: OBTextData(
      label:
          'No hassle, just a few clicks and the product is in your house in a few days',
    ),
    assetData: OBAssetData(),
  ),
  OBPageData(
    id: 3,
    titleData: OBTextData(
      label: 'Easy Checkouts',
      textStyleData: TextStyleData(
        fontSize: 16,
        fontWeight: 6,
      ),
    ),
    descriptionData: OBTextData(
      label:
          'Just choose the delivery option and we will take care of the rest',
    ),
    assetData: OBAssetData(),
  ),
];
