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

// @dart=2.9

import 'dart:ui';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../photoView/photoView.dart';
import '../constants.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key key,
    @required this.imagesNotifier,
  }) : super(key: key);

  final ValueNotifier<List<String>> imagesNotifier;

  /// Controller for the swiper
  static final SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height / 1.6;
    return Container(
      height: height,
      child: imagesNotifier.value.isEmpty
          ? const _NoImageContainer()
          : ValueListenableBuilder<List<String>>(
              valueListenable: imagesNotifier,
              builder: (context, list, w) {
                return Column(
                  children: [
                    Expanded(
                      child: Swiper(
                        controller: swiperController,
                        physics: const BouncingScrollPhysics(),
                        loop: false,
                        autoplay: false,
                        autoplayDisableOnInteraction: true,
                        duration: 500,
                        scale: 0.7,
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GalleryPhotoViewWrapper(
                                    images: list,
                                    initialIndex: i,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: list[i].toString(),
                              child: ExtendedCachedImage(
                                imageUrl: list[i],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        pagination: SwiperCustomPagination(
                          builder: (context, config) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipRRect(
                                child: Container(
                                  height: 25,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 4,
                                      sigmaY: 4,
                                    ),
                                    child: SmoothPageIndicator(
                                      controller: config.pageController,
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
                    ),
                    _SmallImageList(
                      imageList: list,
                      controller: swiperController,
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class ImageContainerDraggableSheet extends StatelessWidget {
  const ImageContainerDraggableSheet({
    Key key,
    @required this.imagesNotifier,
  }) : super(key: key);

  final ValueNotifier<List<String>> imagesNotifier;

  /// Controller for the swiper
  static final SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height,
      child: FractionallySizedBox(
        heightFactor: PSLayoutConstants
            .draggableSheetLayoutImageContainerPaginationPosition,
        child: imagesNotifier.value.isEmpty
            ? const _NoImageContainer()
            : ValueListenableBuilder<List<String>>(
                valueListenable: imagesNotifier,
                builder: (context, list, w) {
                  return Swiper(
                    controller: swiperController,
                    physics: const BouncingScrollPhysics(),
                    loop: false,
                    autoplay: false,
                    autoplayDisableOnInteraction: true,
                    duration: 500,
                    scale: 0.7,
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GalleryPhotoViewWrapper(
                                images: list,
                                initialIndex: i,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: list[i].toString(),
                          child: ExtendedCachedImage(
                            imageUrl: list[i],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    pagination: SwiperCustomPagination(
                      builder: (context, config) {
                        return FractionallySizedBox(
                          heightFactor: 0.88,
                          child: Container(
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
                                    controller: config.pageController,
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
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class ImageContainerExpandable extends StatelessWidget {
  const ImageContainerExpandable({
    Key key,
    @required this.imagesNotifier,
  }) : super(key: key);

  final ValueNotifier<List<String>> imagesNotifier;

  /// Controller for the swiper
  static final SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return imagesNotifier.value.isEmpty
        ? const _NoImageContainer()
        : ValueListenableBuilder<List<String>>(
            valueListenable: imagesNotifier,
            builder: (context, list, w) {
              return Swiper(
                controller: swiperController,
                physics: const BouncingScrollPhysics(),
                loop: false,
                autoplay: false,
                autoplayDisableOnInteraction: true,
                duration: 500,
                scale: 0.7,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryPhotoViewWrapper(
                            images: list,
                            initialIndex: i,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: list[i].toString(),
                      child: ExtendedCachedImage(
                        imageUrl: list[i],
                        fit: BoxFit.cover,
                      ),
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
                              controller: config.pageController,
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
              );
            },
          );
  }
}

class _SmallImageList extends StatelessWidget {
  const _SmallImageList({
    Key key,
    this.imageList = const [],
    this.controller,
  }) : super(key: key);

  final List<String> imageList;
  final SwiperController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: ThemeGuide.padding,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              controller?.move(i);
            },
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ExtendedCachedImage(
                  imageUrl: imageList[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: imageList.length,
      ),
    );
  }
}

class _NoImageContainer extends StatelessWidget {
  const _NoImageContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: ThemeGuide.borderRadius16,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Image.asset(
          'assets/images/placeholderImage.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
