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

import '../../../../app_builder/app_builder.dart';
import '../../../../generated/l10n.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSPointsAndRewardsSectionLayout extends ConsumerWidget {
  const PSPointsAndRewardsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSPointsAndRewardsSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = S.of(context);
    if (ref
        .read(providerOfAppTemplateState)
        .template
        .appConfigurationData
        .enablePointsAndRewardsSupport) {
    } else {
      return const SizedBox();
    }

    final int? value = ref.watch(
      providerOfProductViewModel.select((p) => p.points),
    );

    if (value == null || value <= 0) {
      return const SizedBox();
    }

    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: Text(
        '${lang.pointsMessage1} $value ${lang.pointsMessage2}',
        style: data.styledData.textStyleData.createTextStyle(),
        textAlign: data.styledData.textStyleData.alignment,
      ),
    );
  }
}
