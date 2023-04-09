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

part of 'models.dart';

/// Data object for country data from woocommerce
class WooCountry {
  final String code;
  final String name;
  final List<WooState> states;

  const WooCountry({
    this.code = '',
    this.name = '',
    this.states = const [],
  });

  factory WooCountry.fromMap(Map<String, dynamic> map) {
    return WooCountry(
      code: map['code']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      states: map['states'] != null
          ? (map['states'] as List)
              .map<WooState>((e) => WooState.fromMap(e))
              .toList()
          : const [],
    );
  }

  const WooCountry.empty({
    this.code = '',
    this.name = '',
    this.states = const [],
  });

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'code': code,
      'name': name,
      'states': states,
    } as Map<String, dynamic>;
  }
}

/// Data object for states data from woocommerce
class WooState {
  final String code;
  final String name;

  const WooState({
    this.code = '',
    this.name = '',
  });

  const WooState.empty({
    this.code = '',
    this.name = '',
  });

  factory WooState.fromMap(Map<String, dynamic> map) {
    return WooState(
      code: map['code']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
    };
  }
}

/// Top level decode function to use in a different isolate for better
/// performance
///
/// Must pass the data from countries.json in asset folder which
/// returns a list
List<WooCountry> decodeCountries(String jsonString) {
  final List<Map<String, dynamic>> decodedList =
      List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  return decodedList.map<WooCountry>((map) => WooCountry.fromMap(map)).toList();
}
