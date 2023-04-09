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

//**********************************************************
// Shared
//**********************************************************

import 'package:am_common_packages/am_common_packages.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../../models/models.dart';

class RatingBarLayout extends StatelessWidget {
  const RatingBarLayout({
    Key? key,
    this.size = 12,
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);
  final double size;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: const Color(0xFFF9A825),
          size: size,
        ),
        Icon(
          Icons.star,
          color: const Color(0xFFF9A825),
          size: size,
        ),
        Icon(
          Icons.star,
          color: const Color(0xFFF9A825),
          size: size,
        ),
        Icon(
          Icons.star,
          color: const Color(0xFFF9A825),
          size: size,
        ),
        Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            '4.22 (3)',
            style: TextStyle(
              fontSize: size,
              color: Colors.grey,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}

class LikeButtonLayout extends StatelessWidget {
  const LikeButtonLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(EvaIcons.heartOutline, size: 22);
  }
}

class ImageContainerLayout extends StatelessWidget {
  const ImageContainerLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final ImageSectionData data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(data.borderRadius),
      child: Image.asset(
        'assets/images/placeholder-image.png',
        height: double.infinity,
        width: double.infinity,
        // height: expanded ? double.infinity : data.height,
        // width: expanded ? double.infinity : data.width,
        fit: data.boxFit,
      ),
    );
  }
}

class AddToCartButtonLayout extends StatelessWidget {
  const AddToCartButtonLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ThemeGuide.padding5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: ThemeGuide.borderRadius5,
      ),
      child: const Icon(Icons.add_rounded, size: 22),
    );
  }
}

class RatingLayout extends StatelessWidget {
  const RatingLayout({
    Key? key,
    this.ratingCount = '0',
  }) : super(key: key);
  final String ratingCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ThemeGuide.padding5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: ThemeGuide.borderRadius5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.star,
            color: Color(0xFFF9A825),
            size: 12,
          ),
          const SizedBox(width: 5),
          Text(
            ratingCount,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
