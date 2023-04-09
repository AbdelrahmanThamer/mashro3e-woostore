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

/// Holds information about the behaviour for various sections in the
/// home screen
abstract class HomeConfig {
  /// Defines the scheme in which the external link in the home sections
  /// must be open
  ///
  /// Please note that this setting will be applied to all the sections
  /// which use external link.
  ///
  /// Possible values:
  /// • in-app-webview
  /// • browser
  static const String openExternalLinkScheme = 'in-app-webview';
}
