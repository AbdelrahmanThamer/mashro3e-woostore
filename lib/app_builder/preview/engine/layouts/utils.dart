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

abstract class ParseEngineLayoutUtils {
  static MainAxisAlignment convertTextAlignToMainAxisAlignment(
    TextAlign? textAlign,
  ) {
    switch (textAlign) {
      case TextAlign.left:
        return MainAxisAlignment.start;

      case TextAlign.center:
        return MainAxisAlignment.center;

      case TextAlign.right:
        return MainAxisAlignment.end;

      default:
        return MainAxisAlignment.start;
    }
  }

  static CrossAxisAlignment convertTextAlignToCrossAxisAlignment(
    TextAlign? textAlign,
  ) {
    switch (textAlign) {
      case TextAlign.left:
        return CrossAxisAlignment.start;

      case TextAlign.center:
        return CrossAxisAlignment.center;

      case TextAlign.right:
        return CrossAxisAlignment.end;

      default:
        return CrossAxisAlignment.start;
    }
  }

  static WrapAlignment convertTextAlignToWrapAlignment(
    TextAlign? textAlign,
  ) {
    switch (textAlign) {
      case TextAlign.left:
        return WrapAlignment.start;

      case TextAlign.center:
        return WrapAlignment.center;

      case TextAlign.right:
        return WrapAlignment.end;

      default:
        return WrapAlignment.start;
    }
  }
}
