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

enum LoadingIconType {
  circularProgressIndicator,
  cupertinoActivityIndicator,
  spinKitChasingDots,
  spinKitCircle,
  spinKitCubeGrid,
  spinKitDancingSquare,
  spinKitDoubleBounce,
  spinKitDualRing,
  spinKitFadingCircle,
  spinKitFadingCube,
  spinKitFadingFour,
  spinKitFadingGrid,
  spinKitFoldingCube,
  spinKitHourGlass,
  spinKitPianoWave,
  spinKitPouringHourGlass,
  spinKitPouringHourGlassRefined,
  spinKitPulse,
  spinKitPumpingHeart,
  spinKitRing,
  spinKitRipple,
  spinKitRotatingCircle,
  spinKitRotatingPlain,
  spinKitSpinningCircle,
  spinKitSpinningLines,
  spinKitSquareCircle,
  spinKitThreeBounce,
  spinKitThreeInOut,
  spinKitWanderingCubes,
  spinKitWave,
  undefined,
}

class LoadingIconData {
  final String? color;
  final double? size;
  final LoadingIconType type;

  const LoadingIconData({
    this.color,
    this.size,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'size': size,
      'type': type.name,
    };
  }

  factory LoadingIconData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      Dev.warn('Loading Icon Data.fromMap - Map is empty');
      return const DefaultLoadingIconData();
    }
    return LoadingIconData(
      color: ModelUtils.createStringProperty(map['color']),
      size: ModelUtils.createDoubleProperty(map['size']),
      type: _getType(map['type']),
    );
  }

  LoadingIconData copyWithColor(String? color) {
    return LoadingIconData(
      type: type,
      size: size,
      color: color,
    );
  }

  LoadingIconData copyWithSize(double? size) {
    return LoadingIconData(
      type: type,
      size: size,
      color: color,
    );
  }

  LoadingIconData copyWithType(LoadingIconType type) {
    return LoadingIconData(
      color: color,
      size: size,
      type: type,
    );
  }

  static LoadingIconType _getType(String? name) {
    switch (name) {
      case 'circularProgressIndicator':
        return LoadingIconType.circularProgressIndicator;
      case 'cupertinoActivityIndicator':
        return LoadingIconType.cupertinoActivityIndicator;
      case 'spinKitChasingDots':
        return LoadingIconType.spinKitChasingDots;
      case 'spinKitCircle':
        return LoadingIconType.spinKitCircle;
      case 'spinKitCubeGrid':
        return LoadingIconType.spinKitCubeGrid;
      case 'spinKitDancingSquare':
        return LoadingIconType.spinKitDancingSquare;
      case 'spinKitDoubleBounce':
        return LoadingIconType.spinKitDoubleBounce;
      case 'spinKitDualRing':
        return LoadingIconType.spinKitDualRing;
      case 'spinKitFadingCircle':
        return LoadingIconType.spinKitFadingCircle;
      case 'spinKitFadingCube':
        return LoadingIconType.spinKitFadingCube;
      case 'spinKitFadingFour':
        return LoadingIconType.spinKitFadingFour;
      case 'spinKitFadingGrid':
        return LoadingIconType.spinKitFadingGrid;
      case 'spinKitFoldingCube':
        return LoadingIconType.spinKitFoldingCube;
      case 'spinKitHourGlass':
        return LoadingIconType.spinKitHourGlass;
      case 'spinKitPianoWave':
        return LoadingIconType.spinKitPianoWave;
      case 'spinKitPouringHourGlass':
        return LoadingIconType.spinKitPouringHourGlass;
      case 'spinKitPouringHourGlassRefined':
        return LoadingIconType.spinKitPouringHourGlassRefined;
      case 'spinKitPulse':
        return LoadingIconType.spinKitPulse;
      case 'spinKitPumpingHeart':
        return LoadingIconType.spinKitPumpingHeart;
      case 'spinKitRing':
        return LoadingIconType.spinKitRing;
      case 'spinKitRipple':
        return LoadingIconType.spinKitRipple;
      case 'spinKitRotatingCircle':
        return LoadingIconType.spinKitRotatingCircle;
      case 'spinKitRotatingPlain':
        return LoadingIconType.spinKitRotatingPlain;
      case 'spinKitSpinningCircle':
        return LoadingIconType.spinKitSpinningCircle;
      case 'spinKitSpinningLines':
        return LoadingIconType.spinKitSpinningLines;
      case 'spinKitSquareCircle':
        return LoadingIconType.spinKitSquareCircle;
      case 'spinKitThreeBounce':
        return LoadingIconType.spinKitThreeBounce;
      case 'spinKitThreeInOut':
        return LoadingIconType.spinKitThreeInOut;
      case 'spinKitWanderingCubes':
        return LoadingIconType.spinKitWanderingCubes;
      case 'spinKitWave':
        return LoadingIconType.spinKitWave;
      default:
        return LoadingIconType.undefined;
    }
  }
}

class DefaultLoadingIconData extends LoadingIconData {
  const DefaultLoadingIconData()
      : super(
          type: LoadingIconType.spinKitWave,
        );
}
