// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/productModel.dart';
import '../../../review/reviewScreen.dart';
import 'shared/subHeading.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (!product.wooProduct.reviewsAllowed) {
      return const SizedBox();
    }

    final ThemeData _theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ReviewScreen(productId: product.id),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          SubHeading(title: S.of(context).reviews),
          ValueListenableBuilder<int>(
            valueListenable: product.ratingCount,
            builder: (context, value, _) {
              return Text(' ( $value )');
            },
          ),
          const Spacer(),
          const Icon(Icons.star, color: Color(0xFFFBC02D)),
          const SizedBox(width: 5),
          Text(
            product.wooProduct.averageRating,
            style: _theme.textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
