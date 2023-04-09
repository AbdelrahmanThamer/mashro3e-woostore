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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_builder/app_builder.dart';
import '../product.dart';
import '../viewModel/productViewModel.dart';
import 'widgets/app_bar.dart';

class ExpandableLayout extends ConsumerWidget {
  const ExpandableLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(providerOfProductViewModel);
    final screenData = provider.screenData;
    final PSImageSectionData isd = screenData.sections
            .firstWhere((element) => element.sectionType == PSSectionType.image)
        as PSImageSectionData;

    double expandedHeight = MediaQuery.of(context).size.width / isd.aspectRatio;
    if (isd.showImageGallery) {
      expandedHeight += 160;
    }
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (screenData.appBarData.show) const PSAppbar(),
        SliverAppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: ProductDetailsScreenLayout.renderLayout(isd),
          ),
          stretch: false,
          expandedHeight: expandedHeight,
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 120),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                if (screenData.sections[i].sectionType == PSSectionType.image) {
                  return const SizedBox();
                }
                return ProductDetailsScreenLayout.renderLayout(
                  screenData.sections[i],
                );
              },
              childCount: screenData.sections.length,
            ),
          ),
        )
      ],
    );
  }
}
