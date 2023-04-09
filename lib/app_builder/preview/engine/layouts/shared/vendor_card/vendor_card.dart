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
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../../../models/models.dart';
import '../../../../../utils.dart';

class VendorCardLayout extends StatelessWidget {
  const VendorCardLayout({
    Key? key,
    this.data = const VendorData(),
    required this.layoutData,
  }) : super(key: key);

  final VendorData data;
  final VendorCardLayoutData layoutData;

  @override
  Widget build(BuildContext context) {
    final VendorCardLayoutType type = layoutData.layoutType;
    final theme = Theme.of(context);
    if (type == VendorCardLayoutType.original) {
      return Container(
        padding: layoutData.styledData.paddingData.createEdgeInsets(),
        margin: layoutData.styledData.marginData.createEdgeInsets(),
        height: layoutData.styledData.dimensionsData.height,
        width: layoutData.styledData.dimensionsData.width,
        decoration: BoxDecoration(
          color: HexColor.fromHex(
            layoutData.styledData.backgroundColor,
            theme.colorScheme.background,
          ),
          borderRadius: BorderRadius.circular(
            layoutData.styledData.borderRadius,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.6,
                child: Tooltip(
                  message: 'Store Logo',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ExtendedCachedImage(imageUrl: data.logo),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _VendorCardInfo(
              layoutData: layoutData,
              data: data,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ],
        ),
      );
    }

    if (type == VendorCardLayoutType.originalWithBanner) {
      return SizedBox(
        height: layoutData.styledData.dimensionsData.height,
        child: Container(
          padding: layoutData.styledData.paddingData.createEdgeInsets(),
          margin: layoutData.styledData.marginData.createEdgeInsets(),
          height: layoutData.styledData.dimensionsData.height,
          width: layoutData.styledData.dimensionsData.width,
          decoration: BoxDecoration(
            color: HexColor.fromHex(
              layoutData.styledData.backgroundColor,
              theme.colorScheme.background,
            ),
            borderRadius: BorderRadius.circular(
              layoutData.styledData.borderRadius,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Tooltip(
                  message: 'Store Banner Image',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      layoutData.styledData.borderRadius,
                    ),
                    child: ExtendedCachedImage(imageUrl: data.banner),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _VendorCardInfo(layoutData: layoutData, data: data),
                    Flexible(
                      child: SizedBox(
                        height: 50,
                        child: Tooltip(
                          message: 'Store Logo',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ExtendedCachedImage(imageUrl: data.logo),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (type == VendorCardLayoutType.horizontal) {
      return Container(
        padding: layoutData.styledData.paddingData.createEdgeInsets(),
        margin: layoutData.styledData.marginData.createEdgeInsets(),
        height: layoutData.styledData.dimensionsData.height,
        width: layoutData.styledData.dimensionsData.width,
        decoration: BoxDecoration(
          color: HexColor.fromHex(
            layoutData.styledData.backgroundColor,
            theme.colorScheme.background,
          ),
          borderRadius: BorderRadius.circular(
            layoutData.styledData.borderRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _VendorCardInfo(layoutData: layoutData, data: data),
              Flexible(
                child: Tooltip(
                  message: 'Store Logo',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ExtendedCachedImage(imageUrl: data.logo),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (type == VendorCardLayoutType.horizontalGradient) {
      return Container(
        padding: layoutData.styledData.paddingData.createEdgeInsets(),
        margin: layoutData.styledData.marginData.createEdgeInsets(),
        height: layoutData.styledData.dimensionsData.height,
        width: layoutData.styledData.dimensionsData.width,
        decoration: BoxDecoration(
          color: HexColor.fromHex(
            layoutData.styledData.backgroundColor,
            theme.colorScheme.background,
          ),
          borderRadius: BorderRadius.circular(
            layoutData.styledData.borderRadius,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            layoutData.styledData.borderRadius,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    layoutData.styledData.borderRadius,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white60),
                    child: ExtendedCachedImage(imageUrl: data.banner),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.1, 0.9],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                left: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _VendorCardInfo.horizontalGradient(
                      layoutData: layoutData,
                      data: data,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 70,
                        child: Tooltip(
                          message: 'Store Logo',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ExtendedCachedImage(imageUrl: data.logo),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }
}

class _VendorCardInfo extends StatelessWidget {
  const _VendorCardInfo({
    Key? key,
    this.data = const VendorData(),
    required this.layoutData,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  })  : horizontalGradient = false,
        super(key: key);

  const _VendorCardInfo.horizontalGradient({
    Key? key,
    this.data = const VendorData(),
    required this.layoutData,
  })  : horizontalGradient = true,
        crossAxisAlignment = CrossAxisAlignment.start,
        super(key: key);

  final VendorData data;
  final VendorCardLayoutData layoutData;
  final CrossAxisAlignment crossAxisAlignment;
  final bool horizontalGradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isNotBlank(data.name) ? data.name : 'Vendor',
          style: layoutData.styledData.textStyleData.createTextStyle(
            forcedColor: horizontalGradient ? Colors.white : null,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              EvaIcons.star,
              color: Color(0xFFF9A825),
              size: 16,
            ),
            SizedBox(width: 5),
            Text(
              '4.5',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(width: 5),
            Text(
              '( 10 )',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
