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

abstract class CoCartConstants {
  static const String defaultApiPath = '/wp-json/cocart';
  static const String coCartKeyHeaderResponse = 'x-cocart-api';
  static const String cookieNamePattern = 'wp_cocart_session';

  // For local storage
  static const String cartKey = 'wpCartKey';
  static const String cookie = 'wpCookie';
}
