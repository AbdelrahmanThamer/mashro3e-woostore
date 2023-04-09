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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/appStrings.dart';

class NoUserFoundWithImage extends StatelessWidget {
  const NoUserFoundWithImage({
    Key? key,
    this.imageHeight = 150,
    this.imageWidth,
    this.imageColor,
  }) : super(key: key);

  final double? imageHeight;
  final double? imageWidth;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    Color? _imageColor = imageColor;
    _imageColor ??= Theme.of(context).brightness == Brightness.dark
        ? Colors.white60
        : Colors.black12;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/no-data-ghost.svg',
            height: imageHeight,
            width: imageWidth,
            color: _imageColor,
          ),
          const SizedBox(height: 10),
          const Text('${AppStrings.no} ${AppStrings.user} ${AppStrings.found}'),
        ],
      ),
    );
  }
}
