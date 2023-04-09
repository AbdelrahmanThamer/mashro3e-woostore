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

import '../../../../../../../models/app_template/app_template.dart';
import '../shared.dart';

class PSTagsSectionLayout extends StatelessWidget {
  const PSTagsSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context) {
    Widget w = _HorizontalList(data: data);

    if (data.itemListConfig.listType == ItemListType.grid) {
      w = _GridList(data: data);
    }
    if (data.itemListConfig.listType == ItemListType.wrap) {
      w = _WrapList(data: data);
    }
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: data.showTitle
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tags'),
                const SizedBox(height: 10),
                w,
              ],
            )
          : w,
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(right: data.itemListConfig.itemPadding),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Tag$i',
                style: data.styledData.textStyleData.createTextStyle(),
              ),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}

class _GridList extends StatelessWidget {
  const _GridList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: 4,
      crossAxisSpacing: data.itemListConfig.itemPadding,
      mainAxisSpacing: data.itemListConfig.itemPadding,
      crossAxisCount: data.itemListConfig.gridColumns,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        5,
        (i) {
          return TextButton(
            onPressed: () {},
            child: Text(
              'Tag$i',
              style: data.styledData.textStyleData.createTextStyle(),
            ),
          );
        },
      ),
    );
  }
}

class _WrapList extends StatelessWidget {
  const _WrapList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final PSTagsSectionData data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: data.itemListConfig.itemPadding,
      runSpacing: data.itemListConfig.itemPadding,
      children: List.generate(
        5,
        (i) {
          return TextButton(
            onPressed: () {},
            child: Text(
              'Tag$i',
              style: data.styledData.textStyleData.createTextStyle(),
            ),
          );
        },
      ),
    );
  }
}
