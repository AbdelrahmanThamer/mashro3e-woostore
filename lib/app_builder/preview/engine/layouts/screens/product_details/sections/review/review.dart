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
import '../../../../utils.dart';
import '../shared.dart';

class PSReviewSectionLayout extends StatelessWidget {
  const PSReviewSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSReviewSectionData data;

  @override
  Widget build(BuildContext context) {
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: Row(
        mainAxisAlignment:
            ParseEngineLayoutUtils.convertTextAlignToMainAxisAlignment(
          data.styledData.textStyleData.alignment,
        ),
        children: [
          Text(
            'Review',
            style: data.styledData.textStyleData.createTextStyle(),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: data.styledData.textStyleData.fontSize,
          )
        ],
      ),
    );
  }
}
