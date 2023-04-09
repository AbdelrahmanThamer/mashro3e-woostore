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

import 'package:flutter/foundation.dart';

/// Manages the state of the [view / screen] it is extended to.
/// There are three main states:
///
/// * Loading - shows a loading indicator
/// * Error - shows an error and reload button
/// * Data - show the data it was meant to be shown.
/// * No data - request successful but with no data returned
class BaseProvider with ChangeNotifier {
  // Initial value will be loading always.
  ViewState state = ViewState.LOADING;

  String? _error = '';

  String get error => _error ?? '';

  String _message = '';

  String get message => _message;

  /// Changes the state of the views.
  /// Call this to notify the listeners
  void notifyState(ViewState newState) {
    state = newState;
    notifyListeners();
  }

  void notifyError({String? message}) {
    _error = message;
    notifyState(ViewState.ERROR);
  }

  void notifyLoading() {
    _error = '';
    notifyState(ViewState.LOADING);
  }

  /// Shows this custom message on the screen
  void notifyCustomMessage(String value) {
    _error = '';
    _message = value;
    notifyState(ViewState.CUSTOM_MESSAGE);
  }
}

enum ViewState {
  ERROR,
  LOADING,
  DATA_AVAILABLE,
  NO_DATA_AVAILABLE,
  CUSTOM_MESSAGE,
  undefined,
}
