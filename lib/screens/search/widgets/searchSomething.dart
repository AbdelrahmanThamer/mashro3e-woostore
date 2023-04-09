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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class SearchSomething extends StatelessWidget {
  const SearchSomething({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    if (Theme.of(context).brightness == Brightness.dark) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              EvaIcons.searchOutline,
              size: 130,
              color: Colors.white60,
            ),
            const SizedBox(height: 20),
            Text(lang.searchSomething),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              EvaIcons.searchOutline,
              size: 130,
              color: Colors.black12,
            ),
            const SizedBox(height: 20),
            Text(lang.searchSomething),
          ],
        ),
      );
    }
  }
}
