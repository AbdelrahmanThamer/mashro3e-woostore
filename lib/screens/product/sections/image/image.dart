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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../app_builder/app_builder.dart';
import '../../photoView/photoView.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

final providerOfSwiperControllerProvider =
    Provider.autoDispose<SwiperController>((ref) {
  return SwiperController();
});

class PSImageSectionLayout extends ConsumerWidget {
  const PSImageSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSImageSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget imageContainer = AspectRatio(
      aspectRatio: data.aspectRatio,
      child: ValueListenableBuilder<List<String>>(
        valueListenable:
            ref.read(providerOfProductViewModel).currentProduct.imageNotifier,
        builder: (context, list, _) {
          if (list.isEmpty) {
            return const _NoImageContainer();
          }
          return Swiper(
            controller: ref.read(providerOfSwiperControllerProvider),
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
                    fit: data.styledData.imageBoxFit,
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
          );
        },
      ),
    );

    if (data.showImageGallery) {
      return PSStyledContainerLayout(
        styledData: data.styledData,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

class _ImageGallery extends ConsumerWidget {
  const _ImageGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(providerOfSwiperControllerProvider);
    return ValueListenableBuilder<List<String>>(
      valueListenable:
          ref.read(providerOfProductViewModel).currentProduct.imageNotifier,
      builder: (context, imageList, _) {
        if(imageList.isEmpty){
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => controller.move(i),
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
          ),
        );
      },
    );
  }
}

class _NoImageContainer extends StatelessWidget {
  const _NoImageContainer({Key? key}) : super(key: key);

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
