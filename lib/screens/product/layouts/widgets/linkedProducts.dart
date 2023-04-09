// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:flutter/material.dart';

import '../../../../developer/dev.log.dart';
import '../../../../locator.dart';
import '../../../../models/models.dart';
import '../../../../shared/itemCard.dart';
import '../../../../themes/theme.dart';
import 'shared/subHeading.dart';

class LinkedProducts extends StatelessWidget {
  const LinkedProducts({
    Key key,
    this.productIds = const [],
    this.title,
  }) : super(key: key);

  final List<int> productIds;
  final String title;

  /// Fetch the products from the server
  Future<List<Product>> _fetchProducts() async {
    try {
      final result = await LocatorService.productsProvider().fetchProductsById(
        productIds,
        shouldCheckInCache: true,
      );

      if (result != null && result.isNotEmpty) {
        return result;
      } else {
        return Future.error('Either value is empty or null');
      }
    } catch (e, s) {
      Dev.error('Fetch Linked Products error', error: e, stackTrace: s);
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (productIds.isEmpty) {
      return const SizedBox();
    }
    return FutureBuilder<List<Product>>(
      future: _fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }

        if (snapshot.hasData) {
          final list = snapshot.data;

          if (title != null && title.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SubHeading(title: title),
                ),
                const SizedBox(height: 10),
                _ListBuilder(list: list),
              ],
            );
          } else {
            return _ListBuilder(list: list);
          }
        }
        return const SizedBox();
      },
    );
  }
}

class _ListBuilder extends StatelessWidget {
  const _ListBuilder({Key key, this.list = const []}) : super(key: key);
  final List<Product> list;

  @override
  Widget build(BuildContext context) {
    if (list == null || list.isEmpty) {
      return const SizedBox();
    }
    return AspectRatio(
      aspectRatio: ThemeGuide.horizontalProductListContainerAspectRatio,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ItemCard(productId: list[i].id),
          );
        },
      ),
    );
  }
}
