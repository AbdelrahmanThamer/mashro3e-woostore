// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:quiver/strings.dart';

class OtpPhoneInfo {
  final String phoneNumber;
  final String? countryCode;

  String get phone =>
      '${isNotBlank(countryCode) ? '$countryCode-' : ''}$phoneNumber';

  const OtpPhoneInfo({
    required this.phoneNumber,
    this.countryCode,
  });

  factory OtpPhoneInfo.fromFullPhone(String fullPhone) {
    String _phoneNumber = fullPhone;
    String? _countryCode;
    if (fullPhone.contains('-')) {
      final tempArr = fullPhone.split('-');
      _countryCode = tempArr[0];
      _phoneNumber = tempArr[1];
    }
    return OtpPhoneInfo(
      phoneNumber: _phoneNumber,
      countryCode: _countryCode,
    );
  }
}
