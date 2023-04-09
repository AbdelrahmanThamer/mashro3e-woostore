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

import 'dart:ui';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../../models/app_template/app_template.dart';
import '../shared.dart';

class PSImageSectionLayout extends StatelessWidget {
  const PSImageSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSImageSectionData data;

  @override
  Widget build(BuildContext context) {
    final Widget imageContainer = AspectRatio(
      aspectRatio: data.aspectRatio,
      child: Swiper(
        controller: SwiperController(),
        physics: const BouncingScrollPhysics(),
        loop: false,
        autoplay: false,
        autoplayDisableOnInteraction: true,
        duration: 500,
        scale: 0.7,
        itemCount: 3,
        itemBuilder: (context, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(data.styledData.borderRadius),
            child: Image.asset(
              'assets/images/placeholder-image.png',
              fit: data.styledData.imageBoxFit,
            ),
          );
        },
        pagination: SwiperCustomPagination(
          builder: (context, config) {
            return Container(
              padding: ThemeGuide.padding10,
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: ThemeGuide.borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: SmoothPageIndicator(
                      controller: config.pageController ?? PageController(),
                      count: config.itemCount,
                      effect: const WormEffect(
                        dotWidth: 40,
                        dotHeight: 3,
                        radius: 2,
                        dotColor: Color(0x35000000),
                        activeDotColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    if (data.showImageGallery) {
      return PSStyledContainerLayout(
        styledData: data.styledData,
        child: Column(
          children: [
            imageContainer,
            const Flexible(child: _ImageGallery()),
          ],
        ),
      );
    }
    return PSStyledContainerLayout(
      child: imageContainer,
      styledData: data.styledData,
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ClipRRect(
              child: Image.asset('assets/images/placeholder-image.png'),
              borderRadius: ThemeGuide.borderRadius10,
            ),
            const SizedBox(width: 10),
            ClipRRect(
              child: Image.asset('assets/images/placeholder-image.png'),
              borderRadius: ThemeGuide.borderRadius10,
            ),
            const SizedBox(width: 10),
            ClipRRect(
              child: Image.asset('assets/images/placeholder-image.png'),
              borderRadius: ThemeGuide.borderRadius10,
            ),
          ],
        ),
      ),
    );
  }
}
