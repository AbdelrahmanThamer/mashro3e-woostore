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
import 'package:quiver/strings.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../generated/l10n.dart';
import '../../viewModel/productViewModel.dart';
import '../shared.dart';

class PSReviewSectionLayout extends ConsumerWidget {
  const PSReviewSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSReviewSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.read(providerOfProductViewModel).currentProduct;
    if (!(product.wooProduct.reviewsAllowed ?? false)) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: NavigateToReviewScreenAction(
          productData: ProductData(id: product.id),
        ),
      )?.call(),
      child: PSStyledContainerLayout(
        styledData: data.styledData,
        child: Row(
          mainAxisAlignment:
              ParseEngineLayoutUtils.convertTextAlignToMainAxisAlignment(
            data.styledData.textStyleData.alignment,
          ),
          children: [
            Text(
              S.of(context).reviews,
              style: data.styledData.textStyleData.createTextStyle(),
            ),
            const Spacer(),
            const Icon(Icons.star, color: Color(0xFFFBC02D)),
            if (isNotBlank(product.wooProduct.averageRating))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  product.wooProduct.averageRating!,
                  style: data.styledData.textStyleData.createTextStyle(),
                ),
              ),
            ValueListenableBuilder<int>(
              valueListenable: product.ratingCount,
              builder: (context, value, _) {
                return Text(' ( $value )');
              },
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: data.styledData.textStyleData.fontSize,
            )
          ],
        ),
      ),
    );
  }
}
