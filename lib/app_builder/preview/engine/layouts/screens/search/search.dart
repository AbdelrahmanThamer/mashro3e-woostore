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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../../models/app_template/app_template.dart';

class SearchScreenLayout extends StatelessWidget {
  const SearchScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppSearchScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextFormField(
          initialValue: '',
          // enabled: false,
          decoration: const InputDecoration(hintText: 'Search'),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.filter_list_rounded),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(EvaIcons.optionsOutline),
          ),
        ],
      ),
    );
  }
}
