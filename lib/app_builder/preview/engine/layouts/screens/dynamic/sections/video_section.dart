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

import 'package:flutter/material.dart';

import '../../../../../../models/models.dart';
import 'shared/decorator.dart';

class VideoSectionLayout extends StatelessWidget {
  const VideoSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final VideoSectionData data;

  @override
  Widget build(BuildContext context) {
    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: SliverToBoxAdapter(
        child: AspectRatio(
          aspectRatio: data.dimensionsData.aspectRatio,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Video section is not available in preview, but it will work perfectly in the app',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
