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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/foundation.dart';

import 'app_screen_data/shared/filter_config_data/filter_config_data.dart';

@immutable
class AppConfigurationData {
  final String currency;
  final String currencySymbol;

  /// Must be a valid URL
  final String contactUsUrl;

  /// This should be a valid phone number
  final String contactUsPhone;

  /// Must be a valid email address
  final String contactUsEmail;

  /// Terms of service URL
  final String termsOfServiceUrl;

  /// Privacy policy url
  final String privacyPolicyUrl;

  /// Link to be shared
  final String shareAppLink;

  /// Image to be displayed with the link
  final String shareAppImageUrl;

  /// If you enable this then you need to make sure that you have
  /// completed the setup steps for Firebase Dynamic Links and have
  /// added the appropriate values in the `FirebaseDynamicLinksConfig`
  /// class below
  final bool enableShareAppThroughFirebaseDynamicLinks;

  final AppFirebaseDynamicLinksData appFirebaseDynamicLinksData;

  final List<String> firebaseNotificationTopics;

  /// Flag to set the visibility of the tags horizontal list in
  /// the search filter modal
  final bool showTagsInSearchFilterModal;

  /// Flag to set the visibility of the tags horizontal list in
  /// the All products filter modal
  final bool showTagsInAllProductsFilterModal;

  //**********************************************************
  // Virtual and Downloadable products settings
  //**********************************************************

  /// Flag to show / hide the customers downloadable or virtual
  /// products.
  final bool showCustomerDownloadsListTile;

  //**********************************************************
  // WooCommerce Points and Rewards plugin configuration
  //
  // Set the following FLAGS value according to your use case.
  // The default values for all is 'true'
  //
  // Valid values: true | false
  //**********************************************************

  /// Whether to enable the WooCommerce Points and Rewards plugin
  /// support in the application
  final bool enablePointsAndRewardsSupport;

  /// Flag for `My Points` list tile in the `Account Settings`
  /// If the value is set to true, then the list tile
  /// will be shown in the application otherwise not.
  final bool showPointsListTile;

  /// Flag to decide whether points will be displayed in the Product's
  /// screen
  final bool showPointsInProductScreen;

  //**********************************************************
  // Variation Swatches for WooCommerce Settings
  //**********************************************************

  /// Flag to check if variation swatches should be enabled
  final bool enabledVariationSwatchesForWooCommerce;

  /// Guest checkout setting
  final bool enableGuestCheckout;

  final FilterConfigData filterConfigData;

//<editor-fold desc="Data Methods">

  const AppConfigurationData({
    this.currency = 'USD',
    this.currencySymbol = '\$',
    this.contactUsUrl = 'https://example.com',
    this.contactUsPhone = '+000000000000',
    this.contactUsEmail = 'support@example.com',
    this.termsOfServiceUrl = 'https://example.com',
    this.privacyPolicyUrl = 'https://example.com',
    this.shareAppLink = 'https://example.com',
    this.shareAppImageUrl = 'https://via.placeholder.com/100',
    this.enableShareAppThroughFirebaseDynamicLinks = true,
    this.appFirebaseDynamicLinksData = const AppFirebaseDynamicLinksData(),
    this.firebaseNotificationTopics = const [
      'Version-Update-Available',
      'Promotions',
    ],
    this.showTagsInSearchFilterModal = true,
    this.showTagsInAllProductsFilterModal = true,
    this.showCustomerDownloadsListTile = true,
    this.enablePointsAndRewardsSupport = false,
    this.showPointsListTile = false,
    this.showPointsInProductScreen = false,
    this.enabledVariationSwatchesForWooCommerce = true,
    this.enableGuestCheckout = true,
    this.filterConfigData = const FilterConfigData(),
  });

  AppConfigurationData copyWith({
    String? currency,
    String? currencySymbol,
    String? contactUsUrl,
    String? contactUsPhone,
    String? contactUsEmail,
    String? termsOfServiceUrl,
    String? privacyPolicyUrl,
    String? shareAppLink,
    String? shareAppImageUrl,
    bool? enableShareAppThroughFirebaseDynamicLinks,
    bool? enableShareAppFirebaseDynamicLinksTitle,
    AppFirebaseDynamicLinksData? appFirebaseDynamicLinksData,
    List<String>? firebaseNotificationTopics,
    bool? showTagsInSearchFilterModal,
    bool? showTagsInAllProductsFilterModal,
    bool? showCustomerDownloadsListTile,
    bool? enablePointsAndRewardsSupport,
    bool? showPointsListTile,
    bool? showPointsInProductScreen,
    bool? enabledVariationSwatchesForWooCommerce,
    bool? enableGuestCheckout,
    FilterConfigData? filterConfigData,
  }) {
    return AppConfigurationData(
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      contactUsUrl: contactUsUrl ?? this.contactUsUrl,
      contactUsPhone: contactUsPhone ?? this.contactUsPhone,
      contactUsEmail: contactUsEmail ?? this.contactUsEmail,
      termsOfServiceUrl: termsOfServiceUrl ?? this.termsOfServiceUrl,
      privacyPolicyUrl: privacyPolicyUrl ?? this.privacyPolicyUrl,
      shareAppLink: shareAppLink ?? this.shareAppLink,
      shareAppImageUrl: shareAppImageUrl ?? this.shareAppImageUrl,
      enableShareAppThroughFirebaseDynamicLinks:
          enableShareAppThroughFirebaseDynamicLinks ??
              this.enableShareAppThroughFirebaseDynamicLinks,
      appFirebaseDynamicLinksData:
          appFirebaseDynamicLinksData ?? this.appFirebaseDynamicLinksData,
      firebaseNotificationTopics:
          firebaseNotificationTopics ?? this.firebaseNotificationTopics,
      showTagsInSearchFilterModal:
          showTagsInSearchFilterModal ?? this.showTagsInSearchFilterModal,
      showTagsInAllProductsFilterModal: showTagsInAllProductsFilterModal ??
          this.showTagsInAllProductsFilterModal,
      showCustomerDownloadsListTile:
          showCustomerDownloadsListTile ?? this.showCustomerDownloadsListTile,
      enablePointsAndRewardsSupport:
          enablePointsAndRewardsSupport ?? this.enablePointsAndRewardsSupport,
      showPointsListTile: showPointsListTile ?? this.showPointsListTile,
      showPointsInProductScreen:
          showPointsInProductScreen ?? this.showPointsInProductScreen,
      enabledVariationSwatchesForWooCommerce:
          enabledVariationSwatchesForWooCommerce ??
              this.enabledVariationSwatchesForWooCommerce,
      enableGuestCheckout: enableGuestCheckout ?? this.enableGuestCheckout,
      filterConfigData: filterConfigData ?? this.filterConfigData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currency': currency,
      'currencySymbol': currencySymbol,
      'contactUsUrl': contactUsUrl,
      'contactUsPhone': contactUsPhone,
      'contactUsEmail': contactUsEmail,
      'termsOfServiceUrl': termsOfServiceUrl,
      'privacyPolicyUrl': privacyPolicyUrl,
      'shareAppLink': shareAppLink,
      'shareAppImageUrl': shareAppImageUrl,
      'enableShareAppThroughFirebaseDynamicLinks':
          enableShareAppThroughFirebaseDynamicLinks,
      'appFirebaseConfigurationData': appFirebaseDynamicLinksData.toMap(),
      'firebaseNotificationTopics': firebaseNotificationTopics,
      'showTagsInSearchFilterModal': showTagsInSearchFilterModal,
      'showTagsInAllProductsFilterModal': showTagsInAllProductsFilterModal,
      'showCustomerDownloadsListTile': showCustomerDownloadsListTile,
      'enablePointsAndRewardsSupport': enablePointsAndRewardsSupport,
      'showPointsListTile': showPointsListTile,
      'showPointsInProductScreen': showPointsInProductScreen,
      'enabledVariationSwatchesForWooCommerce':
          enabledVariationSwatchesForWooCommerce,
      'enableGuestCheckout': enableGuestCheckout,
      'filterConfigData': filterConfigData.toMap(),
    };
  }

  factory AppConfigurationData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const AppConfigurationData();
    }

    return AppConfigurationData(
      currency: ModelUtils.createStringProperty(map['currency']),
      currencySymbol: ModelUtils.createStringProperty(map['currencySymbol']),
      contactUsUrl: ModelUtils.createStringProperty(map['contactUsUrl']),
      contactUsPhone: ModelUtils.createStringProperty(map['contactUsPhone']),
      contactUsEmail: ModelUtils.createStringProperty(map['contactUsEmail']),
      termsOfServiceUrl:
          ModelUtils.createStringProperty(map['termsOfServiceUrl']),
      privacyPolicyUrl:
          ModelUtils.createStringProperty(map['privacyPolicyUrl']),
      shareAppLink: ModelUtils.createStringProperty(map['shareAppLink']),
      shareAppImageUrl:
          ModelUtils.createStringProperty(map['shareAppImageUrl']),
      enableShareAppThroughFirebaseDynamicLinks: ModelUtils.createBoolProperty(
          map['enableShareAppThroughFirebaseDynamicLinks']),
      appFirebaseDynamicLinksData: AppFirebaseDynamicLinksData.fromMap(
          map['appFirebaseConfigurationData']),
      firebaseNotificationTopics:
          ModelUtils.createListStrings(map['firebaseNotificationTopics']),
      showTagsInSearchFilterModal:
          ModelUtils.createBoolProperty(map['showTagsInSearchFilterModal']),
      showTagsInAllProductsFilterModal: ModelUtils.createBoolProperty(
          map['showTagsInAllProductsFilterModal']),
      showCustomerDownloadsListTile:
          ModelUtils.createBoolProperty(map['showCustomerDownloadsListTile']),
      enablePointsAndRewardsSupport:
          ModelUtils.createBoolProperty(map['enablePointsAndRewardsSupport']),
      showPointsListTile:
          ModelUtils.createBoolProperty(map['showPointsListTile']),
      showPointsInProductScreen:
          ModelUtils.createBoolProperty(map['showPointsInProductScreen']),
      enabledVariationSwatchesForWooCommerce: ModelUtils.createBoolProperty(
          map['enabledVariationSwatchesForWooCommerce']),
      enableGuestCheckout:
          ModelUtils.createBoolProperty(map['enableGuestCheckout']),
      filterConfigData: FilterConfigData.fromMap(map['filterConfigData']),
    );
  }

//</editor-fold>
}

class AppFirebaseDynamicLinksData {
  /// The URI Prefix from your Firebase Dynamic Link console.
  /// This will also be added in the `AndroidManifest.xml` file
  /// to allow your application to be opened from the link.
  /// Please make sure that this is correct.
  final String uriPrefix;

  /// The following package name and bundle id are the same as you
  /// used while setting up your ios and android apps on firebase.
  final String androidPackageName;
  final String iOSBundleId;

  /// Your app store id
  final String appStoreId;

  /// Flag to enable / disable firebase dynamic links share features
  /// for products
  final bool isEnabledForSharingProducts;

  /// Flags to show extra social data in the shareable links
  final bool shareProductTitle;
  final bool shareProductDescription;
  final bool shareProductImage;

  const AppFirebaseDynamicLinksData({
    this.uriPrefix = 'https://example.page.link',
    this.androidPackageName = 'com.example.android.app',
    this.iOSBundleId = 'com.example.ios.app',
    this.appStoreId = '0',
    this.isEnabledForSharingProducts = true,
    this.shareProductTitle = true,
    this.shareProductDescription = true,
    this.shareProductImage = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'uriPrefix': uriPrefix,
      'androidPackageName': androidPackageName,
      'iOSBundleId': iOSBundleId,
      'appStoreId': appStoreId,
      'isEnabledForSharingProducts': isEnabledForSharingProducts,
      'shareProductTitle': shareProductTitle,
      'shareProductDescription': shareProductDescription,
      'shareProductImage': shareProductImage,
    };
  }

  factory AppFirebaseDynamicLinksData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const AppFirebaseDynamicLinksData();
    }
    return AppFirebaseDynamicLinksData(
      uriPrefix: ModelUtils.createStringProperty(map['uriPrefix']),
      androidPackageName:
          ModelUtils.createStringProperty(map['androidPackageName']),
      iOSBundleId: ModelUtils.createStringProperty(map['iOSBundleId']),
      appStoreId: ModelUtils.createStringProperty(map['appStoreId']),
      isEnabledForSharingProducts:
          ModelUtils.createBoolProperty(map['isEnabledForSharingProducts']),
      shareProductTitle:
          ModelUtils.createBoolProperty(map['shareProductTitle']),
      shareProductDescription:
          ModelUtils.createBoolProperty(map['shareProductDescription']),
      shareProductImage:
          ModelUtils.createBoolProperty(map['shareProductImage']),
    );
  }

  AppFirebaseDynamicLinksData copyWith({
    String? uriPrefix,
    String? androidPackageName,
    String? iOSBundleId,
    String? appStoreId,
    bool? isEnabledForSharingProducts,
    bool? shareProductTitle,
    bool? shareProductDescription,
    bool? shareProductImage,
  }) {
    return AppFirebaseDynamicLinksData(
      uriPrefix: uriPrefix ?? this.uriPrefix,
      androidPackageName: androidPackageName ?? this.androidPackageName,
      iOSBundleId: iOSBundleId ?? this.iOSBundleId,
      appStoreId: appStoreId ?? this.appStoreId,
      isEnabledForSharingProducts:
          isEnabledForSharingProducts ?? this.isEnabledForSharingProducts,
      shareProductTitle: shareProductTitle ?? this.shareProductTitle,
      shareProductDescription:
          shareProductDescription ?? this.shareProductDescription,
      shareProductImage: shareProductImage ?? this.shareProductImage,
    );
  }
}
