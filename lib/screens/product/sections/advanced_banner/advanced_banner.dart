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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../../../app_builder/app_builder.dart';
import '../shared.dart';

class PSAdvancedBannerSectionLayout extends StatelessWidget {
  const PSAdvancedBannerSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSAdvancedBannerSectionData data;

  @override
  Widget build(BuildContext context) {
    final showBottomBar =
        isNotBlank(data.bottomDescription) || isNotBlank(data.actionButtonText);

    final mainWidget = GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: data.action,
      )?.call(),
      child: Provider<PSAdvancedBannerSectionData>(
        create: (context) => data,
        child: DefaultTextStyle(
          style: TextStyle(
            color: HexColor.fromHex(
              data.headingTextStyleData.color,
              Theme.of(context).textTheme.bodyText2?.color,
            ),
          ),
          child: showBottomBar
              ? Stack(
                  children: const [
                    _Body(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: _BottomBar(),
                    ),
                  ],
                )
              : const _Body(),
        ),
      ),
    );

    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: mainWidget,
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        Provider.of<PSAdvancedBannerSectionData>(context, listen: false);
    final theme = Theme.of(context);
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isNotBlank(state.bottomDescription))
                Flexible(flex: 3, child: Text(state.bottomDescription!))
              else
                const Flexible(
                  flex: 3,
                  child: SizedBox(),
                ),
              if (isNotBlank(state.actionButtonText))
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    state.actionButtonText!,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        Provider.of<PSAdvancedBannerSectionData>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.showNewLabel) const Text('New'),
            if (state.showNewLabel) const Flexible(child: SizedBox(height: 5)),
            Flexible(
              child: Text(
                state.heading ?? 'NA',
                style: state.headingTextStyleData.createTextStyle(),
              ),
            ),
            if (isNotBlank(state.description))
              const Flexible(child: SizedBox(height: 5)),
            if (isNotBlank(state.description))
              Flexible(child: Text(state.description ?? 'NA')),
            if (isNotBlank(state.description))
              const Flexible(child: SizedBox(height: 5)),
          ],
        ),
        const SizedBox(height: 10),
        if (isNotBlank(state.imageUrl))
          Flexible(
            child: ExtendedCachedImage(
              imageUrl: state.imageUrl,
              fit: state.itemImageBoxFit,
              borderRadius:
                  BorderRadius.circular(state.imageBorderRadius ?? 10),
            ),
          )
      ],
    );
  }
}
