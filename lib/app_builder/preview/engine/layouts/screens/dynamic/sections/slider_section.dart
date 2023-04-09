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
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../models/models.dart';
import '../../../../engine.dart';
import 'shared/decorator.dart';

class SliderSectionLayout extends StatelessWidget {
  const SliderSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);

  final SliderSectionData data;

  static final SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: data.height,
          child: Swiper(
            controller: swiperController,
            physics: const BouncingScrollPhysics(),
            loop: false,
            autoplay: data.autoplay,
            autoplayDisableOnInteraction: true,
            duration: 500,
            scale: 0.7,
            itemCount: data.items.length,
            itemBuilder: (context, i) {
              return _CardItem(
                item: data.items[i],
                imageBoxFit: data.itemImageBoxFit,
                borderRadius: data.itemBorderRadius,
              );
            },
            pagination: SwiperCustomPagination(
              builder: (context, config) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: SmoothPageIndicator(
                      controller: config.pageController!,
                      count: config.itemCount,
                      effect: const WormEffect(
                        dotWidth: 20,
                        dotHeight: 3,
                        radius: 2,
                        dotColor: Color(0x35000000),
                        activeDotColor: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    Key? key,
    required this.item,
    this.borderRadius = 10,
    this.imageBoxFit = BoxFit.cover,
  }) : super(key: key);

  final BoxFit imageBoxFit;
  final SliderSectionDataItem item;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: item.action,
      )?.call(),
      child: ExtendedCachedImage(
        imageUrl: item.imageUrl,
        borderRadius: BorderRadius.circular(borderRadius),
        fit: imageBoxFit,
      ),
    );
  }
}
