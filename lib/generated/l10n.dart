// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure that you want to logout?`
  String get logoutAreYouSure {
    return Intl.message(
      'Are you sure that you want to logout?',
      name: 'logoutAreYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Logout failed`
  String get logoutFailed {
    return Intl.message(
      'Logout failed',
      name: 'logoutFailed',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login with email and password`
  String get loginTagLine {
    return Intl.message(
      'Login with email and password',
      name: 'loginTagLine',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continueWithFacebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get continueWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'continueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Go anonymous`
  String get goAnonymous {
    return Intl.message(
      'Go anonymous',
      name: 'goAnonymous',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account ?`
  String get loginQues {
    return Intl.message(
      'Don\'t have an account ?',
      name: 'loginQues',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signupButton {
    return Intl.message(
      'Sign up',
      name: 'signupButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to discover amazing things near you`
  String get signUpTagLine {
    return Intl.message(
      'Sign up to discover amazing things near you',
      name: 'signUpTagLine',
      desc: '',
      args: [],
    );
  }

  /// `Signup with Facebook`
  String get signupWithFacebook {
    return Intl.message(
      'Signup with Facebook',
      name: 'signupWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Signup with Google`
  String get signupWithGoogle {
    return Intl.message(
      'Signup with Google',
      name: 'signupWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `By signing up you agree to our `
  String get tosPreText {
    return Intl.message(
      'By signing up you agree to our ',
      name: 'tosPreText',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?`
  String get signUpQues {
    return Intl.message(
      'Already have an account ?',
      name: 'signUpQues',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPasswordQuestion {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPasswordQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAnAccount {
    return Intl.message(
      'Create an account',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Need an account? Register`
  String get needAnAccount {
    return Intl.message(
      'Need an account? Register',
      name: 'needAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Have an account? Sign in`
  String get haveAnAccount {
    return Intl.message(
      'Have an account? Sign in',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in failed`
  String get signInFailed {
    return Intl.message(
      'Sign in failed',
      name: 'signInFailed',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registrationFailed {
    return Intl.message(
      'Registration failed',
      name: 'registrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Password reset failed`
  String get passwordResetFailed {
    return Intl.message(
      'Password reset failed',
      name: 'passwordResetFailed',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Back to sign in`
  String get backToSignIn {
    return Intl.message(
      'Back to sign in',
      name: 'backToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Reset link sent`
  String get resetLinkSentTitle {
    return Intl.message(
      'Reset link sent',
      name: 'resetLinkSentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check your email to reset your password`
  String get resetLinkSentMessage {
    return Intl.message(
      'Check your email to reset your password',
      name: 'resetLinkSentMessage',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `test@test.com`
  String get emailHint {
    return Intl.message(
      'test@test.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password (8+ characters)`
  String get password8CharactersLabel {
    return Intl.message(
      'Password (8+ characters)',
      name: 'password8CharactersLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid`
  String get invalidEmailErrorText {
    return Intl.message(
      'Email is invalid',
      name: 'invalidEmailErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Email can't be empty`
  String get invalidEmailEmpty {
    return Intl.message(
      'Email can\'t be empty',
      name: 'invalidEmailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get invalidPasswordTooShort {
    return Intl.message(
      'Password is too short',
      name: 'invalidPasswordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get invalidPasswordNoMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'invalidPasswordNoMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password can't be empty`
  String get invalidPasswordEmpty {
    return Intl.message(
      'Password can\'t be empty',
      name: 'invalidPasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get homePage {
    return Intl.message(
      'Home Page',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Developer menu`
  String get developerMenu {
    return Intl.message(
      'Developer menu',
      name: 'developerMenu',
      desc: '',
      args: [],
    );
  }

  /// `Authentication type`
  String get authenticationType {
    return Intl.message(
      'Authentication type',
      name: 'authenticationType',
      desc: '',
      args: [],
    );
  }

  /// `Firebase`
  String get firebase {
    return Intl.message(
      'Firebase',
      name: 'firebase',
      desc: '',
      args: [],
    );
  }

  /// `Mock`
  String get mock {
    return Intl.message(
      'Mock',
      name: 'mock',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Not Available`
  String get notAvailable {
    return Intl.message(
      'Not Available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `All Reviews`
  String get allReviews {
    return Intl.message(
      'All Reviews',
      name: 'allReviews',
      desc: '',
      args: [],
    );
  }

  /// `Select Size`
  String get selectSize {
    return Intl.message(
      'Select Size',
      name: 'selectSize',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Item added to cart`
  String get itemAddedToCart {
    return Intl.message(
      'Item added to cart',
      name: 'itemAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Item removed from cart`
  String get itemRemovedFromCart {
    return Intl.message(
      'Item removed from cart',
      name: 'itemRemovedFromCart',
      desc: '',
      args: [],
    );
  }

  /// `You have total`
  String get cartMessagePart1 {
    return Intl.message(
      'You have total',
      name: 'cartMessagePart1',
      desc: '',
      args: [],
    );
  }

  /// `items in the cart`
  String get cartMessagePart2 {
    return Intl.message(
      'items in the cart',
      name: 'cartMessagePart2',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get totalAmount {
    return Intl.message(
      'Total amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Choose your desired address for delivery`
  String get shippingAddressSubheading {
    return Intl.message(
      'Choose your desired address for delivery',
      name: 'shippingAddressSubheading',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Option`
  String get shippingOption {
    return Intl.message(
      'Shipping Option',
      name: 'shippingOption',
      desc: '',
      args: [],
    );
  }

  /// `Choose your shipping option`
  String get shippingOptionsSubheading {
    return Intl.message(
      'Choose your shipping option',
      name: 'shippingOptionsSubheading',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Flat Rate`
  String get flatRate {
    return Intl.message(
      'Flat Rate',
      name: 'flatRate',
      desc: '',
      args: [],
    );
  }

  /// `Local Pickup`
  String get localPickup {
    return Intl.message(
      'Local Pickup',
      name: 'localPickup',
      desc: '',
      args: [],
    );
  }

  /// `One Day`
  String get onDay {
    return Intl.message(
      'One Day',
      name: 'onDay',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Please review your order`
  String get reviewSubheading {
    return Intl.message(
      'Please review your order',
      name: 'reviewSubheading',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Total Items:`
  String get totalItems {
    return Intl.message(
      'Total Items:',
      name: 'totalItems',
      desc: '',
      args: [],
    );
  }

  /// `Items Cost`
  String get itemCost {
    return Intl.message(
      'Items Cost',
      name: 'itemCost',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get cartEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Choose your payment option and proceed to pay`
  String get paymentOptionsSubheading {
    return Intl.message(
      'Choose your payment option and proceed to pay',
      name: 'paymentOptionsSubheading',
      desc: '',
      args: [],
    );
  }

  /// `Credit/Debit Card`
  String get debitCreditCard {
    return Intl.message(
      'Credit/Debit Card',
      name: 'debitCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `PayPal`
  String get paypal {
    return Intl.message(
      'PayPal',
      name: 'paypal',
      desc: '',
      args: [],
    );
  }

  /// `Razor Pay`
  String get razorPay {
    return Intl.message(
      'Razor Pay',
      name: 'razorPay',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cod {
    return Intl.message(
      'Cash on delivery',
      name: 'cod',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message(
      'Pay Now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `My`
  String get my {
    return Intl.message(
      'My',
      name: 'my',
      desc: '',
      args: [],
    );
  }

  /// `Check out all your orders' status`
  String get myOrdersSubtitle {
    return Intl.message(
      'Check out all your orders\' status',
      name: 'myOrdersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Track`
  String get track {
    return Intl.message(
      'Track',
      name: 'track',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Track your orders here`
  String get trackOrdersSubtitle {
    return Intl.message(
      'Track your orders here',
      name: 'trackOrdersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Update and modify your profile`
  String get profileInformationSubtitle {
    return Intl.message(
      'Update and modify your profile',
      name: 'profileInformationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Change the app settings`
  String get settingsSubtitle {
    return Intl.message(
      'Change the app settings',
      name: 'settingsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Update shipping, billing address and much more`
  String get accountSettingsSubtitle {
    return Intl.message(
      'Update shipping, billing address and much more',
      name: 'accountSettingsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Manage notifications`
  String get manageNotifications {
    return Intl.message(
      'Manage notifications',
      name: 'manageNotifications',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Shipped`
  String get shipped {
    return Intl.message(
      'Shipped',
      name: 'shipped',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Txn Id`
  String get transactionId {
    return Intl.message(
      'Txn Id',
      name: 'transactionId',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Id`
  String get id {
    return Intl.message(
      'Id',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Placed`
  String get placed {
    return Intl.message(
      'Placed',
      name: 'placed',
      desc: '',
      args: [],
    );
  }

  /// `Out for delivery`
  String get outForDelivery {
    return Intl.message(
      'Out for delivery',
      name: 'outForDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Arriving`
  String get arriving {
    return Intl.message(
      'Arriving',
      name: 'arriving',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Updated`
  String get updated {
    return Intl.message(
      'Updated',
      name: 'updated',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Cards`
  String get cards {
    return Intl.message(
      'Cards',
      name: 'cards',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Your`
  String get your {
    return Intl.message(
      'Your',
      name: 'your',
      desc: '',
      args: [],
    );
  }

  /// `Primary`
  String get primary {
    return Intl.message(
      'Primary',
      name: 'primary',
      desc: '',
      args: [],
    );
  }

  /// `This is your primary address to which products will be delivered if no address is selected at the time of check out`
  String get primaryAddressMessage {
    return Intl.message(
      'This is your primary address to which products will be delivered if no address is selected at the time of check out',
      name: 'primaryAddressMessage',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code`
  String get zipCode {
    return Intl.message(
      'Zip Code',
      name: 'zipCode',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Add new address`
  String get addNewAddress {
    return Intl.message(
      'Add new address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this address ?`
  String get deleteAddressQuestion {
    return Intl.message(
      'Are you sure you want to delete this address ?',
      name: 'deleteAddressQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Contact us with any of your queries and we will get right onto it`
  String get contactUsMessage {
    return Intl.message(
      'Contact us with any of your queries and we will get right onto it',
      name: 'contactUsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Call Me`
  String get callMe {
    return Intl.message(
      'Call Me',
      name: 'callMe',
      desc: '',
      args: [],
    );
  }

  /// `This is your main card that you use to check out`
  String get mainCardCaption {
    return Intl.message(
      'This is your main card that you use to check out',
      name: 'mainCardCaption',
      desc: '',
      args: [],
    );
  }

  /// `Add New Card`
  String get addNewCard {
    return Intl.message(
      'Add New Card',
      name: 'addNewCard',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Month`
  String get cardExpMonth {
    return Intl.message(
      'Expiry Month',
      name: 'cardExpMonth',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Year`
  String get cardExpYear {
    return Intl.message(
      'Expiry Year',
      name: 'cardExpYear',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder Name`
  String get cardHolderName {
    return Intl.message(
      'Card Holder Name',
      name: 'cardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Card Type`
  String get cardType {
    return Intl.message(
      'Card Type',
      name: 'cardType',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get cardBankName {
    return Intl.message(
      'Bank Name',
      name: 'cardBankName',
      desc: '',
      args: [],
    );
  }

  /// `The month number must be between 1 - 12`
  String get creditCardExpMonthError {
    return Intl.message(
      'The month number must be between 1 - 12',
      name: 'creditCardExpMonthError',
      desc: '',
      args: [],
    );
  }

  /// `The year is invalid. It must be more than or equal to the present year`
  String get creditCardExpYearError {
    return Intl.message(
      'The year is invalid. It must be more than or equal to the present year',
      name: 'creditCardExpYearError',
      desc: '',
      args: [],
    );
  }

  /// `The year is invalid. It is too futuristic!`
  String get creditCardExpBigYearError {
    return Intl.message(
      'The year is invalid. It is too futuristic!',
      name: 'creditCardExpBigYearError',
      desc: '',
      args: [],
    );
  }

  /// `4711471147114711`
  String get cardNumberPlaceholder {
    return Intl.message(
      '4711471147114711',
      name: 'cardNumberPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Axis Bank`
  String get cardBankNamePlaceholder {
    return Intl.message(
      'Axis Bank',
      name: 'cardBankNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `02`
  String get cardExpMonthPlaceholder {
    return Intl.message(
      '02',
      name: 'cardExpMonthPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `2025`
  String get cardExpYearPlaceholder {
    return Intl.message(
      '2025',
      name: 'cardExpYearPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Aniket Malik`
  String get cardHolderNamePlaceholder {
    return Intl.message(
      'Aniket Malik',
      name: 'cardHolderNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Choose Product Category`
  String get chooseProductCategory {
    return Intl.message(
      'Choose Product Category',
      name: 'chooseProductCategory',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Price Range`
  String get priceRange {
    return Intl.message(
      'Price Range',
      name: 'priceRange',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get go {
    return Intl.message(
      'Go',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to search`
  String get nothingToSearch {
    return Intl.message(
      'Nothing to search',
      name: 'nothingToSearch',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get oops {
    return Intl.message(
      'Oops!',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Featured`
  String get featured {
    return Intl.message(
      'Featured',
      name: 'featured',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `Related`
  String get related {
    return Intl.message(
      'Related',
      name: 'related',
      desc: '',
      args: [],
    );
  }

  /// `Week Promotions`
  String get weekPromotionsLabel {
    return Intl.message(
      'Week Promotions',
      name: 'weekPromotionsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Flash Sale`
  String get flashSaleLabel {
    return Intl.message(
      'Flash Sale',
      name: 'flashSaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Seller`
  String get seller {
    return Intl.message(
      'Seller',
      name: 'seller',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful !!`
  String get paymentSuccessful {
    return Intl.message(
      'Payment Successful !!',
      name: 'paymentSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for shopping with us \n Have a great day`
  String get paymentSuccessfulMessage {
    return Intl.message(
      'Thank you for shopping with us \n Have a great day',
      name: 'paymentSuccessfulMessage',
      desc: '',
      args: [],
    );
  }

  /// `Processing the payment. Please wait`
  String get paymentProcessing {
    return Intl.message(
      'Processing the payment. Please wait',
      name: 'paymentProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed !!`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed !!',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while processing the payment \n Please try again`
  String get paymentFailedMessage {
    return Intl.message(
      'Something went wrong while processing the payment \n Please try again',
      name: 'paymentFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message(
      'Mode',
      name: 'mode',
      desc: '',
      args: [],
    );
  }

  /// `Availability`
  String get availability {
    return Intl.message(
      'Availability',
      name: 'availability',
      desc: '',
      args: [],
    );
  }

  /// `Could not complete the request. Please try again!`
  String get requestFailed {
    return Intl.message(
      'Could not complete the request. Please try again!',
      name: 'requestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get sale {
    return Intl.message(
      'Sale',
      name: 'sale',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get saleEnd {
    return Intl.message(
      'End',
      name: 'saleEnd',
      desc: '',
      args: [],
    );
  }

  /// `Sale Ended`
  String get saleEnded {
    return Intl.message(
      'Sale Ended',
      name: 'saleEnded',
      desc: '',
      args: [],
    );
  }

  /// `In Stock`
  String get inStock {
    return Intl.message(
      'In Stock',
      name: 'inStock',
      desc: '',
      args: [],
    );
  }

  /// `Out of stock`
  String get outOfStock {
    return Intl.message(
      'Out of stock',
      name: 'outOfStock',
      desc: '',
      args: [],
    );
  }

  /// `The item variation is currently out of stock, please try other variations`
  String get outOfStockMessage {
    return Intl.message(
      'The item variation is currently out of stock, please try other variations',
      name: 'outOfStockMessage',
      desc: '',
      args: [],
    );
  }

  /// `On Sale`
  String get onSale {
    return Intl.message(
      'On Sale',
      name: 'onSale',
      desc: '',
      args: [],
    );
  }

  /// `Original price`
  String get originalPrice {
    return Intl.message(
      'Original price',
      name: 'originalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Add a review`
  String get addReview {
    return Intl.message(
      'Add a review',
      name: 'addReview',
      desc: '',
      args: [],
    );
  }

  /// `Write a review`
  String get writeAReview {
    return Intl.message(
      'Write a review',
      name: 'writeAReview',
      desc: '',
      args: [],
    );
  }

  /// `Clear filters`
  String get clearFilters {
    return Intl.message(
      'Clear filters',
      name: 'clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `You can only buy single item in an order`
  String get singleQuantityMessage {
    return Intl.message(
      'You can only buy single item in an order',
      name: 'singleQuantityMessage',
      desc: '',
      args: [],
    );
  }

  /// `Product not found`
  String get productNotFound {
    return Intl.message(
      'Product not found',
      name: 'productNotFound',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Could not create an account`
  String get failedSignUp {
    return Intl.message(
      'Could not create an account',
      name: 'failedSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Cannot leave while processing`
  String get checkoutProcessingMessage {
    return Intl.message(
      'Cannot leave while processing',
      name: 'checkoutProcessingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Shipping total`
  String get shippingTotal {
    return Intl.message(
      'Shipping total',
      name: 'shippingTotal',
      desc: '',
      args: [],
    );
  }

  /// `Order Id`
  String get orderId {
    return Intl.message(
      'Order Id',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get show {
    return Intl.message(
      'Show',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `Undefined`
  String get undefined {
    return Intl.message(
      'Undefined',
      name: 'undefined',
      desc: '',
      args: [],
    );
  }

  /// `Post Code`
  String get postCode {
    return Intl.message(
      'Post Code',
      name: 'postCode',
      desc: '',
      args: [],
    );
  }

  /// `Billing`
  String get billing {
    return Intl.message(
      'Billing',
      name: 'billing',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Tracking`
  String get tracking {
    return Intl.message(
      'Tracking',
      name: 'tracking',
      desc: '',
      args: [],
    );
  }

  /// `Provider`
  String get provider {
    return Intl.message(
      'Provider',
      name: 'provider',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `Please`
  String get please {
    return Intl.message(
      'Please',
      name: 'please',
      desc: '',
      args: [],
    );
  }

  /// `Again`
  String get again {
    return Intl.message(
      'Again',
      name: 'again',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get apartment {
    return Intl.message(
      'Apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `Please write the correct full name or ISO code for the state`
  String get stateHelperMessage {
    return Intl.message(
      'Please write the correct full name or ISO code for the state',
      name: 'stateHelperMessage',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message(
      'Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `etc`
  String get etc {
    return Intl.message(
      'etc',
      name: 'etc',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been updated`
  String get passwordUpdateMessage {
    return Intl.message(
      'Your password has been updated',
      name: 'passwordUpdateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch`
  String get couldNotLaunch {
    return Intl.message(
      'Could not launch',
      name: 'couldNotLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: '',
      args: [],
    );
  }

  /// `End of list`
  String get endOfList {
    return Intl.message(
      'End of list',
      name: 'endOfList',
      desc: '',
      args: [],
    );
  }

  /// `No more data available`
  String get noMoreDataAvailable {
    return Intl.message(
      'No more data available',
      name: 'noMoreDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No items in your favorites list!`
  String get noFavoriteItems {
    return Intl.message(
      'No items in your favorites list!',
      name: 'noFavoriteItems',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `More Info`
  String get moreInfo {
    return Intl.message(
      'More Info',
      name: 'moreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `You may also like`
  String get youMayAlsoLike {
    return Intl.message(
      'You may also like',
      name: 'youMayAlsoLike',
      desc: '',
      args: [],
    );
  }

  /// `Frequently bought together`
  String get frequentlyBoughtTogether {
    return Intl.message(
      'Frequently bought together',
      name: 'frequentlyBoughtTogether',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit ?`
  String get exitMessage {
    return Intl.message(
      'Are you sure you want to exit ?',
      name: 'exitMessage',
      desc: '',
      args: [],
    );
  }

  /// `Ends in`
  String get endsIn {
    return Intl.message(
      'Ends in',
      name: 'endsIn',
      desc: '',
      args: [],
    );
  }

  /// `Please logout and login again`
  String get loginAgain {
    return Intl.message(
      'Please logout and login again',
      name: 'loginAgain',
      desc: '',
      args: [],
    );
  }

  /// `Search something`
  String get searchSomething {
    return Intl.message(
      'Search something',
      name: 'searchSomething',
      desc: '',
      args: [],
    );
  }

  /// `Variation Not Available`
  String get noVariationFound {
    return Intl.message(
      'Variation Not Available',
      name: 'noVariationFound',
      desc: '',
      args: [],
    );
  }

  /// `Could not find any variation with these attributes combination at this moment`
  String get noVariationFoundMessage {
    return Intl.message(
      'Could not find any variation with these attributes combination at this moment',
      name: 'noVariationFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to update`
  String get nothingToUpdate {
    return Intl.message(
      'Nothing to update',
      name: 'nothingToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `In case of an invalid token error while updating your information after a password reset, just logout and login again`
  String get passwordResetFailedNotice {
    return Intl.message(
      'In case of an invalid token error while updating your information after a password reset, just logout and login again',
      name: 'passwordResetFailedNotice',
      desc: '',
      args: [],
    );
  }

  /// `Your request is being processed`
  String get requestProcessingMessage {
    return Intl.message(
      'Your request is being processed',
      name: 'requestProcessingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get by {
    return Intl.message(
      'By',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Could not get auth token`
  String get authTokenUnavailable {
    return Intl.message(
      'Could not get auth token',
      name: 'authTokenUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Could not get the user data`
  String get socialLoginFailedMessage {
    return Intl.message(
      'Could not get the user data',
      name: 'socialLoginFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `No valid email provided. Cannot create account without a valid email address`
  String get appleLoginEmailErrorMessage {
    return Intl.message(
      'No valid email provided. Cannot create account without a valid email address',
      name: 'appleLoginEmailErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty`
  String get errorEmptyInput {
    return Intl.message(
      'This field cannot be empty',
      name: 'errorEmptyInput',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to`
  String get welcomeTo {
    return Intl.message(
      'Welcome to',
      name: 'welcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `Shop all that you want`
  String get onBoardingPage1Title {
    return Intl.message(
      'Shop all that you want',
      name: 'onBoardingPage1Title',
      desc: '',
      args: [],
    );
  }

  /// `You get a wide variety of products all just a few clicks away! Hurry get them all`
  String get onBoardingPage1Body {
    return Intl.message(
      'You get a wide variety of products all just a few clicks away! Hurry get them all',
      name: 'onBoardingPage1Body',
      desc: '',
      args: [],
    );
  }

  /// `Easy shopping experience`
  String get onBoardingPage2Title {
    return Intl.message(
      'Easy shopping experience',
      name: 'onBoardingPage2Title',
      desc: '',
      args: [],
    );
  }

  /// `No hassle, just a few clicks and the product is in your house in a few days`
  String get onBoardingPage2Body {
    return Intl.message(
      'No hassle, just a few clicks and the product is in your house in a few days',
      name: 'onBoardingPage2Body',
      desc: '',
      args: [],
    );
  }

  /// `Save Card Information Securely`
  String get onBoardingPage3Title {
    return Intl.message(
      'Save Card Information Securely',
      name: 'onBoardingPage3Title',
      desc: '',
      args: [],
    );
  }

  /// `Easy and secure checkouts with saved cards get you going at an instance`
  String get onBoardingPage3Body {
    return Intl.message(
      'Easy and secure checkouts with saved cards get you going at an instance',
      name: 'onBoardingPage3Body',
      desc: '',
      args: [],
    );
  }

  /// `Easy Checkouts`
  String get onBoardingPage4Title {
    return Intl.message(
      'Easy Checkouts',
      name: 'onBoardingPage4Title',
      desc: '',
      args: [],
    );
  }

  /// `Just choose the delivery option and we will take care of the rest`
  String get onBoardingPage4Body {
    return Intl.message(
      'Just choose the delivery option and we will take care of the rest',
      name: 'onBoardingPage4Body',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buyNow {
    return Intl.message(
      'Buy Now',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `Continue without login`
  String get continueWithoutLogin {
    return Intl.message(
      'Continue without login',
      name: 'continueWithoutLogin',
      desc: '',
      args: [],
    );
  }

  /// `We prefer that you login so that you can have a personalized experience. But you are always welcome to give it a head start before signing up, though you will like it`
  String get onBoardingCreateAccountMessage {
    return Intl.message(
      'We prefer that you login so that you can have a personalized experience. But you are always welcome to give it a head start before signing up, though you will like it',
      name: 'onBoardingCreateAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `No category found`
  String get noCategoryFound {
    return Intl.message(
      'No category found',
      name: 'noCategoryFound',
      desc: '',
      args: [],
    );
  }

  /// `Could not find any category`
  String get noCategoryFoundMessage {
    return Intl.message(
      'Could not find any category',
      name: 'noCategoryFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Empty List`
  String get emptyList {
    return Intl.message(
      'Empty List',
      name: 'emptyList',
      desc: '',
      args: [],
    );
  }

  /// `Nothing in history`
  String get nothingInHistory {
    return Intl.message(
      'Nothing in history',
      name: 'nothingInHistory',
      desc: '',
      args: [],
    );
  }

  /// `Cannot go back as there is nothing in history`
  String get nothingInHistoryMessage {
    return Intl.message(
      'Cannot go back as there is nothing in history',
      name: 'nothingInHistoryMessage',
      desc: '',
      args: [],
    );
  }

  /// `Nothing in forward history`
  String get nothingInForwardHistory {
    return Intl.message(
      'Nothing in forward history',
      name: 'nothingInForwardHistory',
      desc: '',
      args: [],
    );
  }

  /// `Cannot go forward as there is nothing in history`
  String get nothingInForwardHistoryMessage {
    return Intl.message(
      'Cannot go forward as there is nothing in history',
      name: 'nothingInForwardHistoryMessage',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message(
      'Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Downloads`
  String get downloads {
    return Intl.message(
      'Downloads',
      name: 'downloads',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Access Expires`
  String get accessExpires {
    return Intl.message(
      'Access Expires',
      name: 'accessExpires',
      desc: '',
      args: [],
    );
  }

  /// `Downloads Remaining`
  String get downloadsRemaining {
    return Intl.message(
      'Downloads Remaining',
      name: 'downloadsRemaining',
      desc: '',
      args: [],
    );
  }

  /// `Unable to launch the url`
  String get errorLaunchUrl {
    return Intl.message(
      'Unable to launch the url',
      name: 'errorLaunchUrl',
      desc: '',
      args: [],
    );
  }

  /// `Url`
  String get url {
    return Intl.message(
      'Url',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Found`
  String get found {
    return Intl.message(
      'Found',
      name: 'found',
      desc: '',
      args: [],
    );
  }

  /// `Could not find the related url`
  String get errorNoUrl {
    return Intl.message(
      'Could not find the related url',
      name: 'errorNoUrl',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Popularity`
  String get popularity {
    return Intl.message(
      'Popularity',
      name: 'popularity',
      desc: '',
      args: [],
    );
  }

  /// `Latest`
  String get latest {
    return Intl.message(
      'Latest',
      name: 'latest',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Default Sorting`
  String get defaultSorting {
    return Intl.message(
      'Default Sorting',
      name: 'defaultSorting',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get toLowerCase {
    return Intl.message(
      'to',
      name: 'toLowerCase',
      desc: '',
      args: [],
    );
  }

  /// `Share app`
  String get shareApp {
    return Intl.message(
      'Share app',
      name: 'shareApp',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `Invalid`
  String get invalid {
    return Intl.message(
      'Invalid',
      name: 'invalid',
      desc: '',
      args: [],
    );
  }

  /// `Same`
  String get same {
    return Intl.message(
      'Same',
      name: 'same',
      desc: '',
      args: [],
    );
  }

  /// `as`
  String get as {
    return Intl.message(
      'as',
      name: 'as',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get place {
    return Intl.message(
      'Place',
      name: 'place',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get coupon {
    return Intl.message(
      'Coupon',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Method`
  String get method {
    return Intl.message(
      'Method',
      name: 'method',
      desc: '',
      args: [],
    );
  }

  /// `Methods`
  String get methods {
    return Intl.message(
      'Methods',
      name: 'methods',
      desc: '',
      args: [],
    );
  }

  /// `The coupon code you entered is invalid or has expired`
  String get invalidCouponMessage {
    return Intl.message(
      'The coupon code you entered is invalid or has expired',
      name: 'invalidCouponMessage',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Expiration`
  String get expiration {
    return Intl.message(
      'Expiration',
      name: 'expiration',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get expired {
    return Intl.message(
      'Expired',
      name: 'expired',
      desc: '',
      args: [],
    );
  }

  /// `Applied`
  String get applied {
    return Intl.message(
      'Applied',
      name: 'applied',
      desc: '',
      args: [],
    );
  }

  /// `Sub`
  String get sub {
    return Intl.message(
      'Sub',
      name: 'sub',
      desc: '',
      args: [],
    );
  }

  /// `Fee`
  String get fee {
    return Intl.message(
      'Fee',
      name: 'fee',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otp {
    return Intl.message(
      'OTP',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Earn up to`
  String get pointsMessage1 {
    return Intl.message(
      'Earn up to',
      name: 'pointsMessage1',
      desc: '',
      args: [],
    );
  }

  /// `points on the purchase of this product`
  String get pointsMessage2 {
    return Intl.message(
      'points on the purchase of this product',
      name: 'pointsMessage2',
      desc: '',
      args: [],
    );
  }

  /// `Short`
  String get short {
    return Intl.message(
      'Short',
      name: 'short',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Blogs`
  String get blogs {
    return Intl.message(
      'Blogs',
      name: 'blogs',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message(
      'File',
      name: 'file',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get audio {
    return Intl.message(
      'Audio',
      name: 'audio',
      desc: '',
      args: [],
    );
  }

  /// `Uploading`
  String get uploading {
    return Intl.message(
      'Uploading',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Addons`
  String get addons {
    return Intl.message(
      'Addons',
      name: 'addons',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Phone number cannot be verified`
  String get cannotVerifyPhone {
    return Intl.message(
      'Phone number cannot be verified',
      name: 'cannotVerifyPhone',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
