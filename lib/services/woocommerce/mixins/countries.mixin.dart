// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/models.dart';

/// Mixin to get the countries for the address
///
/// The values are taken from the `countries.json` asset
mixin CountriesMixin {
  Future<List<WooCountry>> getCountriesFromLocalAsset() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/countries.json',
      cache: true,
    );
    return await compute(decodeCountries, jsonString);
  }
}
