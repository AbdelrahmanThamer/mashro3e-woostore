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
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSProductNameSectionLayout extends ConsumerWidget {
  const PSProductNameSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSProductNameSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: Text(
        ref.read(providerOfProductViewModel).currentProduct.wooProduct.name ??
            'NA',
        style: data.styledData.textStyleData.createTextStyle(),
        textAlign: data.styledData.textStyleData.alignment,
      ),
    );
  }
}
