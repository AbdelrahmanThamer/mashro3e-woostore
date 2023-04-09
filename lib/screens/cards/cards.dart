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

import 'package:flutter/material.dart';

import '../../controllers/navigationController.dart';
import '../../generated/l10n.dart';
import '../../themes/theme.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.your + ' ' + lang.cards),
        actions: const <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.add),
            onPressed: _addCardInfo,
          ),
        ],
      ),
      body: const Padding(
        padding: ThemeGuide.padding16,
        child: _PrimaryCard(),
      ),
    );
  }

  static void _addCardInfo() {
    NavigationController.navigator.push(const AddNewCardScreenRoute());
  }
}

class _PrimaryCard extends StatelessWidget {
  const _PrimaryCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
