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

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    this.title,
    this.showAllButton = false,
    this.showAllButtonOnPressed,
  }) : super(key: key);
  final String? title;
  final bool showAllButton;
  final void Function()? showAllButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: showAllButton
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextButton(
                    child: const Text('Show All'),
                    onPressed: showAllButtonOnPressed,
                  ),
                ],
              )
            : Text(
                title ?? '',
                style: Theme.of(context).textTheme.headline6,
              ),
      ),
    );
  }
}
