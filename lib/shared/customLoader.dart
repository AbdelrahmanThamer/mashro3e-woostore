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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../app_builder/app_builder.dart';

class CustomLoader extends ConsumerWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoadingIconData data =
        ref.watch(providerOfAppTemplateState).template.globalLoadingIconData;
    final bool isDarkMode =
        Theme.of(context).brightness == ThemeData.dark().brightness;
    final Color color =
        HexColor.fromHex(data.color, isDarkMode ? Colors.white : Colors.black)!;
    final double size = data.size ?? 40;
    return renderLoadingAnimationWidget(
      type: data.type,
      color: color,
      size: size,
    );
  }

  Widget renderLoadingAnimationWidget({
    required LoadingIconType type,
    required Color color,
    required double size,
  }) {
    switch (type) {
      case LoadingIconType.circularProgressIndicator:
        return SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(color: color),
        );

      case LoadingIconType.cupertinoActivityIndicator:
        return SizedBox(
          height: size,
          width: size,
          child: CupertinoActivityIndicator(color: color),
        );

      case LoadingIconType.spinKitChasingDots:
        return SpinKitChasingDots(color: color, size: size);

      case LoadingIconType.spinKitCircle:
        return SpinKitCircle(color: color, size: size);

      case LoadingIconType.spinKitCubeGrid:
        return SpinKitCubeGrid(color: color, size: size);

      case LoadingIconType.spinKitDancingSquare:
        return SpinKitDancingSquare(color: color, size: size);

      case LoadingIconType.spinKitDoubleBounce:
        return SpinKitDoubleBounce(color: color, size: size);

      case LoadingIconType.spinKitDualRing:
        return SpinKitDualRing(color: color, size: size);

      case LoadingIconType.spinKitFadingCircle:
        return SpinKitFadingCircle(color: color, size: size);

      case LoadingIconType.spinKitFadingCube:
        return SpinKitFadingCube(color: color, size: size);

      case LoadingIconType.spinKitFadingFour:
        return SpinKitFadingFour(color: color, size: size);

      case LoadingIconType.spinKitFadingGrid:
        return SpinKitFadingGrid(color: color, size: size);

      case LoadingIconType.spinKitFoldingCube:
        return SpinKitFoldingCube(color: color, size: size);

      case LoadingIconType.spinKitHourGlass:
        return SpinKitHourGlass(color: color, size: size);

      case LoadingIconType.spinKitPianoWave:
        return SpinKitPianoWave(color: color, size: size);

      case LoadingIconType.spinKitPouringHourGlass:
        return SpinKitPouringHourGlass(color: color, size: size);

      case LoadingIconType.spinKitPouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(color: color, size: size);

      case LoadingIconType.spinKitPulse:
        return SpinKitPulse(color: color, size: size);

      case LoadingIconType.spinKitPumpingHeart:
        return SpinKitPumpingHeart(color: color, size: size);

      case LoadingIconType.spinKitRing:
        return SpinKitRing(color: color, size: size);

      case LoadingIconType.spinKitRipple:
        return SpinKitRipple(color: color, size: size);

      case LoadingIconType.spinKitRotatingCircle:
        return SpinKitRotatingCircle(color: color, size: size);

      case LoadingIconType.spinKitRotatingPlain:
        return SpinKitRotatingPlain(color: color, size: size);

      case LoadingIconType.spinKitSpinningCircle:
        return SpinKitSpinningCircle(color: color, size: size);

      case LoadingIconType.spinKitSpinningLines:
        return SpinKitSpinningLines(color: color, size: size);

      case LoadingIconType.spinKitSquareCircle:
        return SpinKitSquareCircle(color: color, size: size);

      case LoadingIconType.spinKitThreeBounce:
        return SpinKitThreeBounce(color: color, size: size);

      case LoadingIconType.spinKitThreeInOut:
        return SpinKitThreeInOut(color: color, size: size);

      case LoadingIconType.spinKitWanderingCubes:
        return SpinKitWanderingCubes(color: color, size: size);

      case LoadingIconType.spinKitWave:
        return SpinKitWave(color: color, size: size);

      default:
        return SizedBox(
          height: size,
          width: size,
          child: const CircularProgressIndicator(),
        );
    }
  }
}
