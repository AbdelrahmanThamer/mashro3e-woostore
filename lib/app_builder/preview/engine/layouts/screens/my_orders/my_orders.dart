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

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';

class MyOrdersScreenLayout extends StatelessWidget {
  const MyOrdersScreenLayout({Key? key, required this.screenData})
      : super(key: key);
  final AppMyOrdersScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(
              data: screenData.appBarData,
              overrideTitle: 'My Orders',
            ),
        ],
      ),
    );
  }
}
