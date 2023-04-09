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

import 'package:quiver/strings.dart';

import '../app_builder/app_builder.dart';
import '../developer/dev.log.dart';

class Utils {
  /// Capitalize the first character of the string parameter
  static String capitalize(String value) {
    if (isBlank(value)) {
      return '';
    }
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }

  /// Calculate the discount from the given prices
  static String? calculateDiscount({
    String? salePrice,
    String? regularPrice,
  }) {
    try {
      if (salePrice != null &&
          regularPrice != null &&
          salePrice.isNotEmpty &&
          regularPrice.isNotEmpty) {
        final p = double.parse(salePrice);
        final rp = double.parse(regularPrice);
        if (p < rp) {
          final double diff = rp - p;
          return ((diff / rp) * 100).toStringAsFixed(0) + ' % off';
        }
      }
      return null;
    } catch (e) {
      Dev.error('calculateDiscount error', error: e);
      return null;
    }
  }

  ///
  /// `Description`
  ///
  /// Render the price for the item cards.
  /// Returns a currency symbol if it is not empty else returns
  /// the currency code
  ///
  static String formatPrice(dynamic amount, {bool forceShowCurrency = false}) {
    if (amount == null) {
      return '';
    }

    amount = amount.toString();

    // Experimental
    // if (!amount.contains(RegExp(r'\.[0-9]+$'))) {
    //   amount = amount.split('.')[0] + '.00';
    // }

    if (forceShowCurrency) {
      return ParseEngine.currency.toUpperCase() + ' $amount';
    }

    return ParseEngine.currencySymbol.isNotEmpty
        ? ParseEngine.currencySymbol + ' $amount'
        : ParseEngine.currency + ' $amount';
  }

  /// Format the card number from the string
  static String formatCardNumber(String? value) {
    if (value != null) {
      String result = '';

      for (var i = 0; i < value.length; i++) {
        if (i == 0) {
          result += value[i];
        } else if ((i % 4) == 0) {
          result += ' ' + value[i];
        } else {
          result += value[i];
        }
      }
      return result;
    } else {
      return '';
    }
  }

  /// Remove all the HTML tags from the text
  static String removeAllHtmlTags(String? htmlText) {
    if (htmlText == null) {
      return '';
    }
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  /// Renders an exception by removing the Exception Keyword
  static String renderException(dynamic e) {
    if (e == null || e is! Exception) {
      return '';
    }
    return e.toString().replaceAll('Exception:', '').trim();
  }
}
