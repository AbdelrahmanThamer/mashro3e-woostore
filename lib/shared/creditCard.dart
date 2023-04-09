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

import '../enums/enums.dart';
import '../themes/themeGuide.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({
    Key key,
    this.bankName,
    this.number,
    this.exp,
    this.cardHolderName,
    this.type,
    this.bgColor,
  }) : super(key: key);

  final String bankName, number, exp, cardHolderName;
  final CardType type;
  final Color bgColor;

  Widget _buildCardType() {
    String path = 'assets/images/visa.png';

    switch (type) {
      case CardType.VISA:
        break;

      case CardType.MASTER:
        path = 'assets/images/master_card.png';
        break;

      default:
    }

    return Image.asset(
      path,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1.7 / 1,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.black87,
          borderRadius: ThemeGuide.borderRadius16,
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                bankName,
                style: _theme.textTheme.subtitle2.copyWith(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              number == null || number.isEmpty
                                  ? 'XXXX XXXX XXXX XXXX'
                                  : number,
                              style: _theme.textTheme.headline5.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Exp.',
                                  style: _theme.textTheme.bodyText2.copyWith(
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  exp == null || exp.isEmpty ? 'MM/YY' : exp,
                                  style: _theme.textTheme.bodyText2.copyWith(
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              cardHolderName == null || cardHolderName.isEmpty
                                  ? 'Card Holder'
                                  : cardHolderName,
                              style: _theme.textTheme.bodyText2.copyWith(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            height: 40,
                            width: 50,
                            child: _buildCardType(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
