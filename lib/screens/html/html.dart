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

import '../../app_builder/app_builder.dart';
import '../../shared/html_view.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/warning_note.dart';

class HtmlScreenLayout extends StatelessWidget {
  const HtmlScreenLayout({Key? key, required this.screenData})
      : super(key: key);
  final AppHtmlScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(data: screenData.appBarData),
          SliverToBoxAdapter(child: _HtmlBody(screenData: screenData)),
        ],
      ),
    );
  }
}

class _HtmlBody extends StatelessWidget {
  const _HtmlBody({
    Key? key,
    required this.screenData,
  }) : super(key: key);

  final AppHtmlScreenData screenData;

  @override
  Widget build(BuildContext context) {
    try {
      return HtmlCustomView(htmlText: screenData.html);
    } catch (e) {
      return const WarningNote(title: 'Not able to display the HTML page');
    }
  }
}
