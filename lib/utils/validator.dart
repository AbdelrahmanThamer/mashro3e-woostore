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

typedef CreditCardExpValidator<T> = String Function(T value);

class Validator {
  /// Card month expiry validator
  static CreditCardExpValidator creditCardExpMonth() {
    return (valueCandidate) {
      final int tempValue = int.tryParse(valueCandidate);
      if (tempValue == null) {
        return null;
      }
      if (tempValue < 1 || tempValue > 12) {
        return null;
      }
      return null;
    };
  }

  /// Card year expiry validator
  static CreditCardExpValidator creditCardExpYear() {
    return (valueCandidate) {
      final int tempValue = int.tryParse(valueCandidate);
      if (tempValue == null) {
        return null;
      }
      final int presentYear = DateTime.now().year;
      if (tempValue < presentYear) {
        return null;
      }
      if (tempValue > 3000) {
        return null;
      }
      return null;
    };
  }
}
