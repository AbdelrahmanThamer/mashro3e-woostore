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
import 'dart:math';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiver/strings.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:woocommerce/models/customer.dart';

import '../app_builder/app_builder.dart';
import '../constants/appStrings.dart';
import '../constants/config.dart';
import '../core/network/network.dart';
import '../locator.dart';
import '../models/models.dart';
import '../services/pushNotification/pushNotification.dart';
import '../services/storage/localStorage.dart';
import '../services/woocommerce/woocommerce.service.dart';
import 'navigationController.dart';

abstract class AuthController {
  // Validates the password
  static String? validatePassword(dynamic password) {
    final int len = password.toString().length;
    if (len < 6) {
      return len == 0
          ? AppStrings.invalidPasswordEmpty
          : AppStrings.invalidPasswordTooShort;
    } else {
      return null;
    }
  }

  // Validates the confirm password field
  static String? validateConfirmPassword(
      String confirmPassword, String password) {
    return password.toString() != confirmPassword.toString()
        ? AppStrings.invalidPasswordNoMatch
        : null;
  }

  static bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }

  // Save the credentials to local storage for later use upon startup
  static Future<void> saveCredentials(dynamic userId, String? email) async {
    if (userId is int) {
      await LocalStorage.setInt(LocalStorageConstants.USER_ID, userId);
    } else if (userId is String) {
      await LocalStorage.setString(LocalStorageConstants.USER_ID, userId);
    }
    await LocalStorage.setString(LocalStorageConstants.EMAIL, email ?? '');
    await LocalStorage.setString(LocalStorageConstants.INITIAL_INSTALL, 'done');
  }

  /// `Login Specific functions:`

  // Login to the app with email and password
  static Future<WooCustomer?> login(String email, String password) async {
    final WooCustomer? result = await LocatorService.wooService().login(
      email: email,
      password: password,
    );

    if (result != null) {
      await performAfterLoginActions(result);
    }

    return result;
  }

  static Stream<NetworkEventStatus> loginApple() async* {
    try {
      // NEW IMPLEMENTATION
      final f_auth.UserCredential credential = await _signInWithApple();
      if (isNotBlank(credential.user?.email)) {
        // Send loading notification
        yield const NetworkEventStatus.loading();
        // call the woo service to create a user
        final WooCustomer? customer =
            await LocatorService.wooService().wc.loginApple(
                  email: credential.user!.email!,
                  fullName: credential.user?.displayName,
                );
        if (customer != null) {
          await performAfterLoginActions(customer);
          yield NetworkEventStatus<WooCustomer>.success(response: customer);
          return;
        } else {
          yield const NetworkEventStatus<String>.failed(
            response: AppStrings.socialLoginFailedMessage,
          );
        }
      } else {
        yield const NetworkEventStatus<String>.failed(
          response: AppStrings.invalidEmailEmpty,
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  static Stream<NetworkEventStatus> loginFacebook() async* {
    final LoginResult result = await FacebookAuth.instance.login();

    switch (result.status) {
      case LoginStatus.operationInProgress:
        break;
      case LoginStatus.success:
        final AccessToken? accessToken = result.accessToken;
        if (accessToken == null) {
          throw Exception('Access token not found');
        }
        // Notify of the loading
        yield const NetworkEventStatus.loading();
        final WooCustomer? customer = await LocatorService.wooService()
            .wc
            .loginFacebook(token: accessToken.token);

        if (customer != null) {
          await performAfterLoginActions(customer);
          yield NetworkEventStatus<WooCustomer>.success(response: customer);
          return;
        }
        yield const NetworkEventStatus<String>.failed(
          response: AppStrings.socialLoginFailedMessage,
        );

        break;
      case LoginStatus.cancelled:
        throw Exception(
            '${AppStrings.cancelled} ${AppStrings.by} ${AppStrings.user}');
      case LoginStatus.failed:
        throw Exception(result.message);
    }
  }

  static Stream<NetworkEventStatus> loginGoogle() async* {
    try {
      final GoogleSignIn _googleSignIn =
          GoogleSignIn(scopes: ['email', 'profile']);
      final GoogleSignInAccount? res = await _googleSignIn.signIn();
      if (res == null) {
        throw Exception(
            '${AppStrings.cancelled} ${AppStrings.by} ${AppStrings.user}');
      } else {
        final GoogleSignInAuthentication auth = await res.authentication;
        if (auth.accessToken == null) {
          throw Exception(AppStrings.authTokenUnavailable);
        }
        // Notify of the loading
        yield const NetworkEventStatus.loading();
        final WooCustomer? customer = await LocatorService.wooService()
            .wc
            .loginGoogle(token: auth.accessToken);
        if (customer != null) {
          await performAfterLoginActions(customer);
          yield NetworkEventStatus<WooCustomer>.success(response: customer);
          return;
        }
        yield const NetworkEventStatus<String>.failed(
          response: AppStrings.socialLoginFailedMessage,
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  static Stream<NetworkEventStatus> loginPhone({
    required String phone,
    String? countryCode,
    required String phoneNumber,
  }) async* {
    yield const NetworkEventStatus.loading();
    final WooCustomer? customer =
        await LocatorService.wooService().wc.loginPhone(
              phone: phone,
              phoneNumber: phoneNumber,
              countryCode: countryCode,
              useDigitsPlugin: kEnableDigitsPluginSupport,
            );
    if (customer != null) {
      await performAfterLoginActions(customer);
      yield NetworkEventStatus<WooCustomer>.success(response: customer);
      return;
    }
    yield const NetworkEventStatus<String>.failed(
      response: AppStrings.socialLoginFailedMessage,
    );
  }

  /// This is the function which is required to be called after every
  /// successful login.
  ///
  /// Handles cart and user synchronization and other required
  /// actions to be performed after a successful login attempt.
  static Future<bool> performAfterLoginActions(WooCustomer? customer) async {
    if (customer != null) {
      // Set the user instance in UserProvider
      LocatorService.userProvider().setUser(User.fromWooCustomer(customer));

      // Required to set auth header for cart sync
      LocatorService.wooService().cart.setAuthToken(
            await LocatorService.wooService().wc.getAuthTokenFromDb(),
          );
      LocatorService.cartViewModel().getCartAfterLogin();

      // Initialize push notifications tasks
      manageNotificationsOnSuccessfulAuth();

      return true;
    }
    return false;
  }

  // Logout function
  static Future<void> logout() async {
    LocatorService.userProvider().updateUserPushToken('');
    await LocatorService.wooService().logout();
    LocalStorage.remove(LocalStorageConstants.EMAIL);
    LocalStorage.remove(LocalStorageConstants.shouldContinueWithoutLogin);
    LocatorService.cartViewModel().resetCart();
    LocatorService.userProvider().removeUser();
    NavigationController.navigator.replaceAll([const LoginRoute()]);
  }

  // Logout function without navigation events
  static Future<void> logoutWithoutNavigation() async {
    LocatorService.userProvider().updateUserPushToken('');
    await LocatorService.wooService().logout();
    LocalStorage.remove(LocalStorageConstants.EMAIL);
    LocalStorage.remove(LocalStorageConstants.shouldContinueWithoutLogin);
    LocatorService.cartViewModel().resetCart();
    LocatorService.userProvider().removeUser();
  }

  // `SignUp specific functions:`

  // Creates a new users for the app with email and password
  static Future<WooCustomer> signUp({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? phone,
    Map<String, dynamic>? extraData,
  }) async {
    // Create a customer
    final WooCustomer wooCustomer = WooCustomer(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
      phone: phone,
    );

    final result = await LocatorService.wooService().signUp(
      wooCustomer,
      extraData: extraData,
    );

    // Add user to UserProvider
    LocatorService.userProvider().setUser(User.fromWooCustomer(result));

    // Initialize push notifications tasks
    manageNotificationsOnSuccessfulAuth();

    return result;
  }

  /// Perform the required notification tasks on a successful
  /// authentication
  static Future<void> manageNotificationsOnSuccessfulAuth() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'manageNotificationsOnSuccessfulAuth',
      className: 'AuthController',
      fileName: 'authController.dart',
      start: true,
    );

    PushNotificationService.requestPermissions();

    // Now generate new FCM Token
    PushNotificationService.generateDeviceToken(
        callBack: LocatorService.userProvider().updateUserPushToken);

    // Start listening for user device token update
    PushNotificationService.listenForRefreshedToken(
        LocatorService.userProvider().updateUserPushToken);

    PushNotificationService.subscribeToMultipleTopics(
      ParseEngine.notificationTopics,
    );

    // Function Log
    Dev.debugFunction(
      functionName: 'manageNotificationsOnSuccessfulAuth',
      className: 'AuthController',
      fileName: 'authController.dart',
      start: false,
    );
  }

  /// Check if the customer is already logged in the application
  /// Perform any actions necessary based on user logged in status
  static Future<bool> isCustomerLoggedIn() async {
    // Function Log
    Dev.debugFunction(
      functionName: 'isCustomerLoggedIn',
      className: 'AuthController',
      fileName: 'authController.dart',
      start: true,
    );

    final result = await LocatorService.wooService().isLoggedIn();
    Dev.debug('Is Logged in - $result');

    if (result) {
      // If the user is logged in then get the user data from
      // server and populate the user instance in background
      LocatorService.userProvider().getUserInBackground();

      // Initialize push notifications tasks
      manageNotificationsOnSuccessfulAuth();
    }

    // Function Log
    Dev.debugFunction(
      functionName: 'isCustomerLoggedIn',
      className: 'AuthController',
      fileName: 'authController.dart',
      start: false,
    );

    return result;
  }

  static void navigateToTabbar() {
    NavigationController.navigator.replaceAll([const TabbarNavigationRoute()]);
  }
}

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<f_auth.UserCredential> _signInWithApple() async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = _generateNonce();
  final nonce = _sha256ofString(rawNonce);

  // Request credential for the currently signed in Apple account.
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = f_auth.OAuthProvider('apple.com').credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  return await f_auth.FirebaseAuth.instance
      .signInWithCredential(oauthCredential);
}
