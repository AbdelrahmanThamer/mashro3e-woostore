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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quiver/strings.dart';

import '../../../../../models/app_template/app_template.dart';

class OnBoardingScreenLayout extends StatelessWidget {
  const OnBoardingScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppOnBoardingScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntroductionScreen(
      dotsDecorator: DotsDecorator(
        color: theme.colorScheme.primary.withAlpha(80),
        activeColor: theme.colorScheme.primary,
      ),
      pages: createPages(context),
      onDone: () {
        // When done button is press
      },
      showBackButton: false,
      showSkipButton: true,
      showNextButton: false,
      skip: const Text('Skip'),
      done: const Text(
        'Done',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  List<PageViewModel> createPages(BuildContext context) {
    final pages = <PageViewModel>[];

    for (final page in screenData.pages) {
      Widget? titleWidget;
      if (isNotBlank(page.titleData.label)) {
        titleWidget = Text(
          page.titleData.label!,
          style: page.titleData.textStyleData.createTextStyle(),
          textAlign: page.descriptionData.textStyleData.alignment,
        );
      }
      Widget? assetWidget;

      if (isNotBlank(page.assetData.path)) {
        final file = File(page.assetData.path!);
        final fileExists = file.existsSync();
        if (fileExists) {
          if (page.assetData.type == OBAssetType.image) {
            assetWidget = Image.file(
              File(page.assetData.path!),
              height: page.assetData.height,
              width: page.assetData.allowFullWidth
                  ? double.infinity
                  : page.assetData.width,
              fit: page.assetData.boxFit,
            );
          }
          if (page.assetData.type == OBAssetType.svg) {
            assetWidget = SvgPicture.file(
              File(page.assetData.path!),
              height: page.assetData.height,
              width: page.assetData.allowFullWidth
                  ? double.infinity
                  : page.assetData.width,
              fit: page.assetData.boxFit,
            );
          }
        }
      }

      Widget? descriptionWidget;
      if (isNotBlank(page.descriptionData.label)) {
        descriptionWidget = Text(
          page.descriptionData.label!,
          style: page.descriptionData.textStyleData.createTextStyle(),
          textAlign: page.descriptionData.textStyleData.alignment,
        );
      }

      pages.add(PageViewModel(
        titleWidget: titleWidget,
        image: assetWidget ??
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
        bodyWidget: descriptionWidget,
      ));
    }

    return pages;
  }
}
