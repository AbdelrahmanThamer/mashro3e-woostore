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

import '../../../utils/style.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    Key? key,
    this.label,
    this.value,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.valueWidget,
  }) : super(key: key);

  const RowItem.noPadding({
    Key? key,
    this.label,
    this.value,
    this.padding = const EdgeInsets.all(0),
    this.valueWidget,
  }) : super(key: key);
  final String? label;
  final String? value;
  final EdgeInsets padding;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label != null ? '$label :' : '',
            style: UIStyle.isDarkMode(context)
                ? const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  )
                : const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
          ),
          const SizedBox(width: 10),
          if (valueWidget != null)
            valueWidget!
          else
            Expanded(
              child: Text(
                value ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
