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
import 'package:quiver/strings.dart';

import '../../../../app_builder/app_builder.dart';
import '../shared.dart';

class PSTextSectionLayout extends StatelessWidget {
  const PSTextSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSTextSectionData data;

  @override
  Widget build(BuildContext context) {
    if (isBlank(data.text)) {
      return const SizedBox();
    }
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: GestureDetector(
        onTap: () => ParseEngine.createAction(
          context: context,
          action: data.action,
        )?.call(),
        child: Text(
          data.text!,
          style: data.styledData.textStyleData.createTextStyle(),
          textAlign: data.styledData.textStyleData.alignment,
        ),
      ),
    );
  }
}
