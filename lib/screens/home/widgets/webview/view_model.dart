// // Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
// // All Rights Reserved.
// //
// // NOTICE: All information contained herein is, and remains the
// // property of Aniket Malik. The intellectual and technical concepts
// // contained herein are proprietary to Aniket Malik and are protected
// // by trade secret or copyright law.
// //
// // Dissemination of this information or reproduction of this material
// // is strictly forbidden unless prior written permission is obtained from
// // Aniket Malik.
//
// // @dart=2.9
//
// import 'dart:async';
//
// import 'package:flutter/foundation.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../../controllers/navigationController.dart';
//
// class HomeExternalLinkWebViewModel with ChangeNotifier {
//   HomeExternalLinkWebViewModel(this.initialUrl)
//       : controller = Completer<WebViewController>();
//
//   /// This is the initial url that the webview must load.
//   final String initialUrl;
//
//   /// A controller for the web view in which all the actions will
//   /// be performed.
//   final Completer<WebViewController> controller;
//
//   void updateLoading(bool value) {
//     _onLoading(value);
//   }
//
//   void updateError(String message) {
//     _onError(message);
//   }
//
//   /// Check if the order is complete based on the URL of the
//   /// web view
//   Future<void> onPageFinished(String url) async {
//     // Custom logic to check for any type of data in the url
//     // This is the url of the webpage opened
//     final uri = Uri.tryParse(url);
//     // Search for `woostore_pro_product_id` query param
//     // If the product is found then push to the product screen
//     if (uri.queryParameters.containsKey('woostore_pro_product_id')) {
//       NavigationController.navigator.push(ProductScreenRoute(
//         id: uri.queryParameters['woostore_pro_product_id'],
//       ));
//     }
//
//     // Required to call to update the loading status.
//     _onLoading(false);
//   }
//
//   //**********************************************************
//   //  Events
//   //**********************************************************
//
//   /// Loading event
//   bool _isLoading = true;
//
//   /// Get the loading value
//   bool get isLoading => _isLoading;
//
//   /// Success flag to verify if data fetching event was successfully.
//   bool _isSuccess = false;
//
//   /// Get the success value
//   bool get isSuccess => _isSuccess;
//
//   /// Error flag for any error while fetching
//   bool _isError = false;
//
//   /// Get the error value
//   bool get isError => _isError;
//
//   /// Error message
//   String _errorMessage = '';
//
//   /// Get the error message value
//   String get errorMessage => _errorMessage;
//
//   //**********************************************************
//   //  Event Helper Functions
//   //**********************************************************
//
//   /// Changes the flags to reflect loading event and notify the listeners.
//   void _onLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
//
//   /// Notifies about the error
//   void _onError(String message) {
//     _isLoading = false;
//     _isSuccess = false;
//     _isError = true;
//     _errorMessage = message;
//     notifyListeners();
//   }
// }
