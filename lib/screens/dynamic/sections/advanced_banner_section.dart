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

import '../../../app_builder/app_builder.dart';
import 'layouts/layouts.dart';
import 'shared/decorator.dart';
import 'shared/section_title.dart';

class AdvancedBannerSectionLayout extends StatelessWidget {
  const AdvancedBannerSectionLayout({
    Key? key,
    required this.data,
  })  : listLayout = false,
        super(key: key);

  const AdvancedBannerSectionLayout.listLayout({
    Key? key,
    required this.data,
  })  : listLayout = true,
        super(key: key);

  final AdvancedBannerSectionData data;
  final bool listLayout;

  @override
  Widget build(BuildContext context) {
    final showBottomBar =
        isNotBlank(data.bottomDescription) || isNotBlank(data.actionButtonText);

    final mainWidget = GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: data.action,
      )?.call(),
      child: Provider<AdvancedBannerSectionData>(
        create: (context) => data,
        child: DefaultTextStyle(
          style: TextStyle(
            color: HexColor.fromHex(
              data.headingTextStyleData.color,
              Theme.of(context).textTheme.bodyText2?.color,
            )?.withAlpha(220),
          ),
          child: showBottomBar
              ? Stack(
                  children: [
                    _Body(listLayout: listLayout),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: _BottomBar(),
                    ),
                  ],
                )
              : _Body(listLayout: listLayout),
        ),
      ),
    );

    if (listLayout) {
      return SectionLayoutDecorator(
        styledData: data.styledData,
        child: mainWidget,
      );
    }
    return SliverContainer(
      padding: data.styledData.paddingData.createEdgeInsets(),
      margin: data.styledData.marginData.createEdgeInsets(),
      background: ClipRRect(
        borderRadius: BorderRadius.circular(data.styledData.borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              width: data.styledData.borderWidth,
              color: HexColor.fromHex(
                data.styledData.borderColor,
                Colors.transparent,
              )!,
            ),
            color: HexColor.fromHex(data.styledData.backgroundColor),
          ),
        ),
      ),
      sliver: SliverToBoxAdapter(child: mainWidget),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
        Provider.of<AdvancedBannerSectionData>(context, listen: false);
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
  const _Body({Key? key, this.listLayout = false}) : super(key: key);
  final bool listLayout;

  @override
  Widget build(BuildContext context) {
    final state =
        Provider.of<AdvancedBannerSectionData>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: ThemeGuide.padding10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.showNewLabel) const Text('New'),
              if (state.showNewLabel)
                const Flexible(child: SizedBox(height: 5)),
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
        ),
        const SizedBox(height: 10),
        if (listLayout)
          Expanded(
            child: Center(
              child: ExtendedCachedImage(
                imageUrl: state.imageUrl,
                fit: state.itemImageBoxFit,
                borderRadius: BorderRadius.circular(
                  state.imageBorderRadius ?? 8,
                ),
              ),
            ),
          )
        else
          Flexible(
            child: Center(
              child: ExtendedCachedImage(
                imageUrl: state.imageUrl,
                fit: state.itemImageBoxFit,
                borderRadius: BorderRadius.circular(
                  state.imageBorderRadius ?? 8,
                ),
              ),
            ),
          )
      ],
    );
  }
}

class AdvancedBannerListSectionLayout extends StatelessWidget {
  const AdvancedBannerListSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final AdvancedBannerListSectionData data;

  @override
  Widget build(BuildContext context) {
    final list = data.items;
    Widget listWidget = SliverToBoxAdapter(
      child: HorizontalListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(left: data.itemPadding),
            child: SizedBox(
              width: data.itemDimensionsData.width,
              child: AdvancedBannerSectionLayout.listLayout(data: list[i]),
            ),
          );
        },
      ),
    );

    if (data.layout == SectionLayout.verticalList) {
      listWidget = VerticalListSectionLayout(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(bottom: data.itemPadding),
            child: SizedBox(
              height: data.itemDimensionsData.height,
              child: AdvancedBannerSectionLayout.listLayout(data: list[i]),
            ),
          );
        },
      );
    }

    if (data.layout == SectionLayout.grid) {
      listWidget = GridListSectionLayout(
        itemCount: list.length,
        itemDimensionsData: data.itemDimensionsData,
        columns: data.columns,
        spacing: data.itemPadding,
        itemBuilder: (context, i) {
          return AdvancedBannerSectionLayout.listLayout(data: list[i]);
        },
      );
    }

    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: isNotBlank(data.title)
          ? MultiSliver(children: [SectionTitle(title: data.title), listWidget])
          : listWidget,
    );
  }
}
