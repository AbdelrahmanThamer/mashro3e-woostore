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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce_error.dart';

import '../constants/config.dart';
import '../controllers/authController.dart';
import '../controllers/navigationController.dart';
import '../controllers/uiController.dart';
import '../developer/dev.log.dart';
import '../generated/l10n.dart';
import '../locator.dart';
import '../models/userModel.dart';
import '../services/storage/localStorage.dart';
import '../services/verify_otp/verify_otp.dart';
import '../utils/utils.dart';

///
/// ## `Description`
///
/// Provider that handles `User` data in the state.
/// Cares about the user data after it has been loaded into memory from the server.
///
class UserProvider with ChangeNotifier {
  //**********************************************************
  //  Data Holders
  //**********************************************************

  /// User instance
  User _user = User.empty();

  /// Getter for user instance
  User get user => _user;

  /// Updated user to change data on the server
  /// This variable needs to be set as null when update
  /// action is completed to save memory
  Map _updatedCustomerData = {};

  //**********************************************************
  //  Public Functions
  //**********************************************************

  /// Sets the new User provided in the main state of the application.
  ///
  /// [saveToDB] flag is used to determine if the new data
  /// must be saved in the database or not.
  ///
  /// By default it saves the new user passed to the function
  /// unless explicitly forced not to save the provided user instance.
  ///
  /// Will always save the [user.id] and [user.email] as AUTH CREDENTIALS in
  /// local DB if they are not null or empty
  void setUser(
    User user, {
    bool saveToDB = true,
    bool saveCredentials = false,
  }) {
    Dev.info('Set User ${user.toMap()}');
    _user = user;
    notifyListeners();
    if (saveToDB) {
      saveUserToDB(user);
    }

    if (isNotBlank(user.id) && isNotBlank(user.email)) {
      AuthController.saveCredentials(user.id, user.email);
    }
  }

  /// Delete the saved instance of the user in the disk
  Future<void> removeUser() async {
    Dev.debug('Removing user');
    await LocalStorage.secureRemove(LocalStorageConstants.USER);
    _user = User.empty();
    notifyListeners();
  }

  /// Save the user instance into DB which is currently set on the
  /// [_user] field of User Provider
  Future<bool> saveUserToDB(User? user) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'saveUserToDB',
      className: 'UserProvider',
      fileName: 'userProvider.dart',
      start: true,
    );

    if (user == null) {
      return false;
    }
    try {
      // Create a user json string
      final String userJsonString = json.encode(user.toMap());
      Dev.info('User String json encode  $userJsonString');
      await LocalStorage.secureWrite(
          LocalStorageConstants.USER, userJsonString);
      // Function Log
      Dev.debugFunction(
        functionName: 'saveUserToDB',
        className: 'UserProvider',
        fileName: 'userProvider.dart',
        start: false,
      );
      return true;
    } catch (e, s) {
      Dev.error('Save user to db error: ', error: e, stackTrace: s);
      return false;
    }
  }

  /// Get the user instance from DB and set it in the provider
  Future<User?> getUserFromDB() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'getUserFromDB',
      className: 'UserProvider',
      fileName: 'userProvider.dart',
      start: true,
    );

    try {
      // Get the data from local storage
      final String? userJsonString =
          await LocalStorage.secureRead(LocalStorageConstants.USER);
      if (userJsonString == null || userJsonString.isEmpty) {
        Dev.warn('User Json string is empty');
        return null;
      }
      final map = json.decode(userJsonString) as Map<String, dynamic>;
      final User _user = User.fromMap(map);

      // Function Log
      Dev.debugFunction(
        functionName: 'getUserFromDB',
        className: 'UserProvider',
        fileName: 'userProvider.dart',
        start: false,
      );

      return _user;
    } catch (e, s) {
      Dev.error('Get user from DB', error: e, stackTrace: s);
      return null;
    }
  }

  /// Get the User's data in background.
  ///
  /// Creates a user instance from the saved User in the disk for
  /// widgets to consume until the new data is fetched.
  ///
  /// Fetch the updated customer data
  ///
  /// Update the saved instance in the disk
  Future<void> getUserInBackground() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'getUserInBackground',
      className: 'UserProvider',
      fileName: 'userProvider.dart',
      start: true,
    );

    // Set the user from DB
    final User? user = await getUserFromDB();

    if (user != null) {
      // save the user
      setUser(user, saveToDB: false);
    }

    // Get the user from server
    try {
      final WooCustomer? result =
          await LocatorService.wooService().wc.getCustomerByIdWithApi(
                id: int.tryParse(user?.id ?? '0') ?? 0,
              );

      if (result != null) {
        final User newUser = User.fromWooCustomer(result);
        // set the wooCustomer in the user instance
        setUser(newUser);
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'getUserInBackground',
        className: 'UserProvider',
        fileName: 'userProvider.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Get user in background error', error: e, stackTrace: s);
      if (isBlank(_user.email)) {
        setUser(User.empty());
      }
    }
  }

  /// Get the user from the server and updates the new user value
  /// Usually called from the edit profile web view
  Future<void> getRefreshedUserFromServer({bool notify = true}) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'getRefreshedUserFromServer',
      className: 'UserProvider',
      fileName: 'userProvider.dart',
      start: true,
    );
    try {
      final WooCustomer? result =
          await LocatorService.wooService().wc.getCustomerById(
                id: int.tryParse(user.id) ?? 0,
              );

      if (result != null) {
        final User newUser = User.fromWooCustomer(result);
        // set the wooCustomer in the user instance
        setUser(newUser);
      }

      if (notify) {
        notifyListeners();
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'getRefreshedUserFromServer',
        className: 'UserProvider',
        fileName: 'userProvider.dart',
        start: false,
      );
    } catch (e, s) {
      Dev.error('Get Refreshed User from server', error: e, stackTrace: s);
    }
  }

  /// Updates the [_updatedCustomer] value to the server
  Future<void> updatedUserData(BuildContext context) async {
    user.phone = 'asdfljsalfj';
    notifyListeners();
    if (_updatedCustomerData.isEmpty) {
      final lang = S.of(context);
      UiController.showNotification(
        context: context,
        title: lang.cancelled,
        message: lang.nothingToUpdate,
        color: Colors.red,
        position: FlushbarPosition.BOTTOM,
      );
      return;
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'updateUserData',
      className: 'UserProvider',
      fileName: 'userProvider.dart',
      start: true,
    );

    Dev.info(_updatedCustomerData);
    try {
      // check if the phone value is also updated
      // if yes, then ask for otp for verification
      // if verified, then update the data
      // else remove the phone value, update other data
      // and show that phone value is not updated because
      // it was not verified.
      if (_updatedCustomerData.containsKey('phone')) {
        final String phoneValue = _updatedCustomerData['phone'];
        if (!await _verifyPhone(context: context, phone: phoneValue)) {
          // remove the phone data and move forward
          _updatedCustomerData.remove('phone');

          // show notification that phone cannot be verified and
          // hence will not be updated
          final lang = S.of(context);
          UiController.showNotification(
            context: context,
            title: '${lang.verification} ${lang.failed}',
            message: lang.cannotVerifyPhone,
            color: Colors.red,
            position: FlushbarPosition.BOTTOM,
          );
        } else {
          // add the phone info to the updated data
          if (phoneValue.contains('-')) {
            final tempArr = phoneValue.split('-');
            _updatedCustomerData.addAll({
              'phone_info': {
                'country_code': tempArr[0],
                'phone_number': tempArr[1],
                'use_digits_plugin': kEnableDigitsPluginSupport,
              }
            });
          }
        }
      }

      _onLoading(true);
      final WooCustomer? result =
          await LocatorService.wooService().wc.updateCustomerWithApi(
                id: _user.wooCustomer?.id,
                data: _updatedCustomerData,
              );

      if (result == null) {
        _onError(S.of(context).somethingWentWrong);
        return;
      }

      // Important to update the wooCustomer in user
      _user.updateWooCustomerInformation(result);
      _onSuccessful();

      final lang = S.of(context);
      UiController.showNotification(
        context: context,
        title: lang.success,
        message: lang.profile + ' ' + lang.updated,
        color: Colors.green,
        position: FlushbarPosition.BOTTOM,
      );

      // Change the value to release memory
      _disposeCustomerData();

      // Function Log
      Dev.debugFunction(
        functionName: 'updateUserData',
        className: 'UserProvider',
        fileName: 'userProvider.dart',
        start: false,
      );

      saveUserToDB(_user);
    } catch (e, s) {
      if (e is WooCommerceError && e.code == 'invalid_token') {
        _errorMessage = '';
        _isLoading = false;
        _isError = false;
        notifyListeners();
        _forceLogin(
          () => NavigationController.navigator.push(
            const EditProfileRoute(),
          ),
        );
      } else {
        _onError(
            (e is WooCommerceError ? e.message : Utils.renderException(e))!);
      }
      Dev.error('Update user data', error: e, stackTrace: s);
    }
  }

  Future<bool> _verifyPhone({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      final result = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return VerifyOtpScreen(
              phone: phone,
              onSuccess: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop(true);
                }
              });
        },
      );
      if (result == null) {
        return false;
      } else {
        return true;
      }
    } catch (e, s) {
      Dev.error('_verifyOtp from user provider', error: e, stackTrace: s);
      return false;
    }
  }

  /// Updates the [_updatedCustomer] shipping or billing value to the
  /// server without notifying the listeners.
  ///
  /// Used only by Update Address Modal
  Future<bool> updateShippingOrBilling(
    Map<String, dynamic>? addressInfo, {
    BuildContext? context,
  }) async {
    if (addressInfo == null) {
      if (context != null) {
        final lang = S.of(context);
        UiController.showNotification(
          context: context,
          title: lang.cancelled,
          message: lang.nothingToUpdate,
          color: Colors.red,
          position: FlushbarPosition.BOTTOM,
        );
      }
      return false;
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'updateShippingOrBilling',
      className: 'UserProvider',
      fileName: 'userProvider.dart',
      start: true,
    );
    try {
      final WooCustomer? result =
          await LocatorService.wooService().wc.updateCustomerWithApi(
                id: _user.wooCustomer?.id,
                data: addressInfo,
              );

      if (result == null) {
        return false;
      }

      if (context != null) {
        final lang = S.of(context);
        UiController.showNotification(
          context: context,
          title: lang.success,
          message: '${lang.address} ${lang.updated}',
          color: Colors.green,
          position: FlushbarPosition.BOTTOM,
        );
      }

      // Important to update the wooCustomer in user
      _user.updateWooCustomerInformation(result);

      // Function Log
      Dev.debugFunction(
        functionName: 'updateShippingOrBilling',
        className: 'UserProvider',
        fileName: 'userProvider.dart',
        start: false,
      );

      return true;
    } catch (e) {
      if (e is WooCommerceError && e.code == 'invalid_token') {
        final isShipping = addressInfo.containsKey('shipping');
        _forceLogin(
          () => NavigationController.navigator.push(
            AddressScreenRoute(isShipping: isShipping),
          ),
        );
      }
      rethrow;
    }
  }

  /// Updates the user's push notification token
  Future<void> updateUserPushToken(String token) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'updateUserPushToken',
      className: 'UserProvider',
      fileName: 'userProvider.dart',
      start: true,
    );

    if (user.wooCustomer == null || user.wooCustomer?.id == null) {
      Dev.debug('No user found to update, returning');
      return;
    }

    if (isBlank(token)) {
      Dev.debug('No token provided to update, returning');
      return;
    }

    try {
      final WooCustomer? result =
          await LocatorService.wooService().wc.updateCustomerWithApi(
        id: _user.wooCustomer?.id,
        data: {'deviceToken': token},
      );

      if (result == null) {
        Dev.error('Push token update resulted in null');
      }

      // Function Log
      Dev.debugFunction(
        functionName: 'updateUserPushToken',
        className: 'UserProvider',
        fileName: 'userProvider.dart',
        start: false,
      );
    } catch (e, s) {
      _onError('');
      Dev.error('Update user device push token data', error: e, stackTrace: s);
    }
  }

  //**********************************************************
  //  User Update functions (Locally)
  //**********************************************************

  void updateFirstName(String value) {
    final Map f = {'first_name': value};
    _updatedCustomerData.addAll(f);
    _updateShippingInfo(f);
    _updateBillingInfo(f);
  }

  void updateLastName(String value) {
    final Map f = {'last_name': value};
    _updatedCustomerData.addAll(f);
    _updateShippingInfo(f);
    _updateBillingInfo(f);
  }

  void updateEmail(String value) {
    final Map f = {'user_email': value};
    _updatedCustomerData.addAll(f);
    _updateBillingInfo(f);
  }

  void updatePhone(String value) {
    final Map f = {'phone': value};
    _updatedCustomerData.addAll(f);
  }

  /// Update the password of the user
  Future<void> updatePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    try {
      // Get user email to update the password for the account
      final email = _user.email;
      if (isBlank(email)) {
        throw Exception(
            'User\'s email cannot be empty to update the password. Please add an email address for this account to update the password.');
      }

      await LocatorService.wooService().wc.updatePasswordWithApiV2(
        data: {
          'password': newPassword,
          'old_password': oldPassword,
          'email': email,
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  //**********************************************************
  //  Helpers
  //**********************************************************

  /// Initialize the data information
  void _disposeCustomerData() {
    _updatedCustomerData = {};
  }

  /// Update the shipping information
  void _updateShippingInfo(Map value) {
    final bool isPresent = _updatedCustomerData['shipping'] != null;
    if (isPresent) {
      (_updatedCustomerData['shipping'] as Map).addAll(value);
    } else {
      _updatedCustomerData['shipping'] = {};
      (_updatedCustomerData['shipping'] as Map).addAll(value);
    }
  }

  /// Update the billing information
  void _updateBillingInfo(Map value) {
    final bool isPresent = _updatedCustomerData['billing'] != null;
    if (isPresent) {
      (_updatedCustomerData['billing'] as Map).addAll(value);
    } else {
      _updatedCustomerData['billing'] = {};
      (_updatedCustomerData['billing'] as Map).addAll(value);
    }
  }

  /// Shows the login screen to the user to login in an event
  /// of [invalid_token] error from the server
  void _forceLogin(Function? navigateTo) {
    AuthController.logoutWithoutNavigation();
    NavigationController.navigator.replaceAll([
      LoginFromXRoute(
        onSuccess: navigateTo != null
            ? navigateTo()
            : () => NavigationController.navigator.push(
                  const TabbarNavigationRoute(),
                ),
      ),
    ]);
  }

  //**********************************************************
  //  Events
  //**********************************************************

  /// Loading event
  bool _isLoading = false;

  /// Get the loading value
  bool get isLoading => _isLoading;

  /// Success flag to verify if data fetching event was successfully.
  bool _isSuccess = false;

  /// Get the success value
  bool get isSuccess => _isSuccess;

  /// Flag to show if data is available
  bool _hasData = false;

  /// Getter for the data availability flag
  bool get hasData => _hasData;

  /// Error flag for any error while fetching
  bool _isError = false;

  /// Get the error value
  bool get isError => _isError;

  /// Error message
  String _errorMessage = '';

  /// Get the error message value
  String get errorMessage => _errorMessage;

  //**********************************************************
  //  Event Helper Functions
  //**********************************************************

  /// Changes the flags to reflect loading event and notify the listeners.
  void _onLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Changes the flags to reflect success and notify the listeners.
  void _onSuccessful({bool hasData = true}) {
    _isLoading = false;
    _isSuccess = true;
    _hasData = hasData;
    _isError = false;
    _errorMessage = '';
    notifyListeners();
  }

  /// Notifies about the error
  void _onError(String message) {
    _isLoading = false;
    _isSuccess = false;
    _isError = true;
    _errorMessage = message;
    notifyListeners();
  }
}
