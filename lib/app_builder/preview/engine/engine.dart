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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:quiver/strings.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:woocommerce/models/vendor.dart';

import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../screens/screens.dart';
import '../../../services/firebase_dynamic_links/firebase_dynamic_links.dart';
import '../../../services/pushNotification/pushNotification.dart';
import '../../../shared/widgets/bottomSheet/languageChange.bottomSheet.dart';
import '../../app_builder.dart';

export 'layouts/utils.dart';

final providerOfParseEngineActiveTemplate = Provider<AppTemplate>((ref) {
  final appTemplateState = ref.watch(providerOfAppTemplateState);
  ParseEngine.setTemplate = appTemplateState.template;
  return ParseEngine.appTemplate;
});

/// ## Description
///
/// Creates the application from the [AppTemplate] passed to it.
abstract class ParseEngine {
  static CupertinoTabController tabController = CupertinoTabController(
    initialIndex: 0,
  );

  /// Screen which should be visible to the user
  Widget displayScreen = const SizedBox();

  /// Perform the necessary actions when the app template changes
  static set setTemplate(AppTemplate t) {
    appTemplate = t;
    if (tabController.index > t.appTabs.length - 1) {
      tabController.index = 0;
    }

    // Push notification changes
    if (t.appConfigurationData.firebaseNotificationTopics.isNotEmpty) {
      PushNotificationService.subscribeToMultipleTopics(
        t.appConfigurationData.firebaseNotificationTopics,
      );
    }
  }

  static void changeTab({int index = 0}) {
    if (index < 0) {
      return;
    }
    if (appTemplate.appTabs.length - 1 <= index) {
      tabController.index = index;
    }
  }

  static AppTemplate appTemplate = const AppTemplate();

  static Widget createTabbedBody() {
    if (appTemplate.appTabs.length < 2) {
      return const Center(
        child: Text('Please add at least 2 tabs'),
      );
    }
    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: createTabBar(),
      tabBuilder: (_, i) {
        return createTabScreen(appTemplate.appTabs[i].appScreenData);
      },
    );
  }

  static CupertinoTabBar createTabBar() {
    return CupertinoTabBar(
      border: const Border(
        top: BorderSide(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      items: appTemplate.appTabs.map<BottomNavigationBarItem>((e) {
        return BottomNavigationBarItem(
          icon: Icon(e.iconData),
          activeIcon: Icon(e.activeIconData),
        );
      }).toList(),
    );
  }

  static Widget createTabScreen(AppScreenData? screenData) {
    if (screenData?.appScreenLayoutType == AppScreenLayoutType.dynamic) {
      return DynamicScreenLayout(
        screenData: screenData as AppDynamicScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.category) {
      return CategoriesScreenLayout(
        screenData: screenData as AppCategoryScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.tags) {
      return TagsScreenLayout(
        screenData: screenData as AppTagsScreenData,
      );
    }
    if (screenData?.appScreenLayoutType == AppScreenLayoutType.search) {
      return const SearchScreenLayout();
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.cart) {
      return CartScreenLayout(
        screenData: screenData as AppCartScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.profile) {
      return ProfileScreenLayout(
        screenData: screenData as AppProfileScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.myAccount) {
      return MyAccountScreenLayout(
        screenData: screenData as AppMyAccountScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.setting) {
      return SettingsScreenLayout(
        screenData: screenData as AppSettingScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.html) {
      return HtmlScreenLayout(
        screenData: screenData as AppHtmlScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.blog) {
      return BlogScreenLayout(
        screenData: screenData as AppBlogScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.webpage) {
      return WebpageScreenLayout(
        screenData: screenData as AppWebpageScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.wishlist) {
      return WishlistScreenLayout(
        screenData: screenData as AppWishlistScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.singlePost) {
      return SinglePostScreenLayout(
        screenData: screenData as AppSinglePostScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.myOrders) {
      return MyOrdersScreenLayout(
        screenData: screenData as AppMyOrdersScreenData,
      );
    }

    if (screenData?.appScreenLayoutType == AppScreenLayoutType.allVendors) {
      return AllVendorsScreenLayout(
        screenData: screenData as AppAllVendorsScreenData,
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: screenData?.name == null || screenData?.name == 'undefined'
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Screen Not Implemented in Preview',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'But this will work on the actual application without any issues',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Center(child: Text(screenData!.name)),
    );
  }

  /// Load the screen from [appTemplate]
  static AppScreenData? loadScreen(int screenId) {
    return appTemplate.appScreens.firstWhere(
      (element) => element.id == screenId,
      orElse: () => const EmptyScreenData(),
    );
  }

  static AppScreenData? getScreenData({
    int screenId = -1,
    AppScreenType screenType = AppScreenType.preBuilt,
  }) {
    if (screenId <= 0) {
      return null;
    }

    return appTemplate.appScreens.firstWhereOrNull((element) =>
        element.id == screenId && element.screenType == screenType);
  }

  static void Function()? createAction({
    required BuildContext context,
    required AppAction action,
  }) {
    try {
      Dev.info(action.toMap());

      if (isNavigationAction(action)) {
        return () => performNavigationAction(action);
      }

      if (action.type == AppActionType.tabNavigation) {
        action as TabNavigationAction;
        return () {
          if (ModalRoute.of(context)?.settings.name !=
              TabbarNavigationRoute.name) {
            NavigationController.navigator
                .replaceAll([const TabbarNavigationRoute()]);
          }
          tabController.index = appTemplate.appTabs.lastIndexWhere((element) =>
              element.id == action.tabNavigationData.tabId ||
              element.name == action.tabNavigationData.tabName);
        };
      }

      if (action.type == AppActionType.launch) {
        action as LaunchAction;
        if (isNotBlank(action.url)) {
          return () async {
            if (await canLaunchUrlString(action.url!)) {
              await launchUrlString(action.url!);
            }
          };
        } else {
          Dev.warn('Cannot launch ${action.url}');
        }
      }

      if (action.type == AppActionType.chooseLanguageBottomSheet) {
        return () => {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => const LanguageChangeBottomSheet(),
              )
            };
      }

      if (action.type == AppActionType.launchTermsOfService) {
        return () async {
          if (await canLaunchUrlString(
              appTemplate.appConfigurationData.termsOfServiceUrl)) {
            await launchUrlString(
                appTemplate.appConfigurationData.termsOfServiceUrl);
          }
        };
      }

      if (action.type == AppActionType.launchPrivacyPolicy) {
        return () async {
          if (await canLaunchUrlString(
              appTemplate.appConfigurationData.privacyPolicyUrl)) {
            await launchUrlString(
                appTemplate.appConfigurationData.privacyPolicyUrl);
          }
        };
      }

      if (action.type == AppActionType.shareApp) {
        return () async {
          final lang = S.of(context);
          if (appTemplate
              .appConfigurationData.enableShareAppThroughFirebaseDynamicLinks) {
            final Uri shareUri =
                await FirebaseDynamicLinksService.createShortDynamicLink(
              uri:
                  Uri.tryParse(appTemplate.appConfigurationData.shareAppLink) ??
                      Uri.dataFromString('https://www.example.com'),
              title: '${lang.download} ${lang.now}',
              imageUrl: appTemplate.appConfigurationData.shareAppImageUrl,
              uriPrefix: appTemplate
                  .appConfigurationData.appFirebaseDynamicLinksData.uriPrefix,
              androidPackageName: appTemplate.appConfigurationData
                  .appFirebaseDynamicLinksData.androidPackageName,
              iOSBundleId: appTemplate
                  .appConfigurationData.appFirebaseDynamicLinksData.iOSBundleId,
              appStoreId: appTemplate
                  .appConfigurationData.appFirebaseDynamicLinksData.appStoreId,
            );

            Share.share(
              '${lang.download} ${lang.now}\n${shareUri.toString()}',
              subject: '${lang.download} ${lang.now}',
            );
          } else {
            Share.share(
              '${lang.download}  ${lang.now}\n${appTemplate.appConfigurationData.shareAppLink}',
              subject: '${lang.download} ${lang.now}',
            );
          }
        };
      }

      if (action.type == AppActionType.aboutUsDialog) {
        return () async {
          final PackageInfo packageInfo = await PackageInfo.fromPlatform();
          showAboutDialog(
            context: context,
            applicationIcon: ClipRRect(
              borderRadius: ThemeGuide.borderRadius10,
              child: Image.asset(
                'assets/images/app_icon.jpg',
                height: 100,
                width: 100,
              ),
            ),
            applicationName: packageInfo.appName,
            applicationVersion: 'Version ${packageInfo.version}',
            applicationLegalese: packageInfo.packageName,
          );
        };
      }
      return null;
    } catch (e, s) {
      Dev.error(
        'Error while creating action callback',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  static AppScreenData? findScreen({
    required List<AppScreenData?> screens,
    required String screenName,
    required int screenId,
  }) {
    return screens.firstWhere(
      (element) => element?.name == screenName || element?.id == screenId,
      orElse: () => null,
    );
  }

  static Widget createApp(AppTemplate template) {
    return createTabbedBody();
  }

  /// Changes the tabbar index to the specified index
  static void navigateToCart(BuildContext context) {
    final AppTabData? cartTabData = appTemplate.appTabs.firstWhereOrNull(
        (element) => element.appScreenData is AppCartScreenData);
    if (cartTabData != null) {
      createAction(
        context: context,
        action: TabNavigationAction(
          tabNavigationData: TabNavigationData(
            tabId: cartTabData.id,
            tabName: cartTabData.name,
          ),
        ),
      )?.call();
    } else {
      createAction(
        context: context,
        action: const NavigationAction(
          navigationData: NavigationData(
            screenId: AppPrebuiltScreensId.cart,
            screenName: AppPrebuiltScreensNames.cart,
          ),
        ),
      )?.call();
    }
  }

  static bool isNavigationAction(AppAction action) {
    return action.type == AppActionType.navigation ||
        action.type == AppActionType.navigateToAllProductsScreen ||
        action.type == AppActionType.navigateToSingleProductScreen ||
        action.type == AppActionType.navigateToSingleVendorScreen ||
        action.type == AppActionType.navigateToReviewScreen;
  }

  static void performNavigationAction(AppAction action) {
    if (action is NavigateToAllProductsScreenAction) {
      NavigationController.navigator.push(AllProductsScreenLayoutRoute(
        screenData: getScreenData(screenId: AppPrebuiltScreensId.allProducts)
            as AppAllProductsScreenData,
        action: action,
      ));
      return;
    }

    if (action is NavigateToSingleProductScreenAction) {
      NavigationController.navigator.push(ProductDetailsScreenLayoutRoute(
        id: action.productData.id,
      ));
      return;
    }

    if (action is NavigateToSingleVendorScreenAction) {
      NavigationController.navigator.push(VendorDetailsScreenLayoutRoute(
        vendorData: Vendor(
          id: action.vendorData.id,
          storeName: action.vendorData.name,
          banner: action.vendorData.banner,
          gravatar: action.vendorData.logo,
        ),
      ));
      return;
    }

    if (action is NavigateToReviewScreenAction) {
      NavigationController.navigator.push(ReviewScreenRoute(
        productId: action.productData.id,
      ));
      return;
    }

    action as NavigationAction;
    final AppScreenData? screenData = appTemplate.appScreens.firstWhereOrNull(
      (element) => element.id == action.navigationData.screenId,
    );

    if (action.navigationData.screenId == AppPrebuiltScreensId.vendor ||
        screenData is AppVendorScreenData) {
      final Vendor? vendor = action.arguments?['vendorData'];
      if (vendor == null) {
        Dev.warn('nav arguments -> vendorData is missing');
        return;
      }
      NavigationController.navigator.push(
        VendorDetailsScreenLayoutRoute(vendorData: vendor),
      );
      return;
    }

    if (action.navigationData.screenId == AppPrebuiltScreensId.category ||
        screenData is AppCategoryScreenData) {
      NavigationController.navigator.push(CategoriesScreenLayoutRoute(
        screenData: screenData as AppCategoryScreenData,
      ));
      return;
    }

    if (action.navigationData.screenId == AppPrebuiltScreensId.cart ||
        screenData is AppCartScreenData) {
      NavigationController.navigator.push(CartScreenLayoutRoute(
        screenData: screenData as AppCartScreenData,
      ));
      return;
    }

    if (action.navigationData.screenId == AppPrebuiltScreensId.profile ||
        screenData is AppProfileScreenData) {
      NavigationController.navigator.push(ProfileScreenLayoutRoute(
        screenData: screenData as AppProfileScreenData,
      ));
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.search ||
        screenData is AppSearchScreenData) {
      NavigationController.navigator.push(const SearchScreenLayoutRoute());
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.wishlist ||
        screenData is AppWishlistScreenData) {
      NavigationController.navigator.push(WishlistScreenLayoutRoute(
        screenData: screenData == null
            ? const AppWishlistScreenData(screenType: AppScreenType.preBuilt)
            : screenData as AppWishlistScreenData,
      ));
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.notification ||
        screenData is AppNotificationScreenData) {
      NavigationController.navigator.push(const NotificationScreenRoute());
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.myOrders ||
        screenData is AppMyOrdersScreenData) {
      NavigationController.navigator.push(
        MyOrdersScreenLayoutRoute(
          screenData: screenData as AppMyOrdersScreenData,
        ),
        onFailure: (_) {
          NavigationController.navigator.push(
            LoginFromXRoute(
              onSuccess: () {
                NavigationController.navigator.push(
                  MyOrdersScreenLayoutRoute(
                    screenData: screenData,
                  ),
                );
              },
            ),
          );
        },
      );
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.myAccount ||
        screenData is AppMyAccountScreenData) {
      NavigationController.navigator.push(MyAccountScreenLayoutRoute(
        screenData: screenData as AppMyAccountScreenData,
      ));
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.setting ||
        screenData is AppSettingScreenData) {
      NavigationController.navigator.push(SettingsScreenLayoutRoute(
        screenData: screenData as AppSettingScreenData,
      ));
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.onBoarding) {
      NavigationController.navigator.push(const OnBoardingScreenLayoutRoute());
      return;
    }

    if (action.navigationData.screenId == AppPrebuiltScreensId.addAddress) {
      NavigationController.navigator.push(
        const AddAddressRoute(),
        onFailure: (_) {
          NavigationController.navigator.push(
            LoginFromXRoute(
              onSuccess: () {
                NavigationController.navigator.push(
                  const AddAddressRoute(),
                );
              },
            ),
          );
        },
      );
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.address) {
      final bool isShipping = action.arguments?['isShipping'] ?? false;
      NavigationController.navigator.push(
        AddressScreenRoute(isShipping: isShipping),
        onFailure: (_) {
          NavigationController.navigator.push(
            LoginFromXRoute(
              onSuccess: () {
                NavigationController.navigator.push(
                  AddressScreenRoute(isShipping: isShipping),
                );
              },
            ),
          );
        },
      );
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.changePassword) {
      NavigationController.navigator.push(
        const ChangePasswordRoute(),
        onFailure: (_) {
          NavigationController.navigator.push(
            LoginFromXRoute(
              onSuccess: () {
                NavigationController.navigator.push(
                  const ChangePasswordRoute(),
                );
              },
            ),
          );
        },
      );
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.contactUs) {
      NavigationController.navigator.push(const ContactScreenRoute());
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.downloads) {
      NavigationController.navigator.push(
        const DownloadsScreenRoute(),
        onFailure: (_) {
          NavigationController.navigator.push(
            LoginFromXRoute(
              onSuccess: () {
                NavigationController.navigator.push(
                  const DownloadsScreenRoute(),
                );
              },
            ),
          );
        },
      );
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.editProfile) {
      NavigationController.navigator.push(
        const EditProfileRoute(),
        onFailure: (_) {
          NavigationController.navigator.push(
            LoginFromXRoute(
              onSuccess: () {
                NavigationController.navigator.push(
                  const EditProfileRoute(),
                );
              },
            ),
          );
        },
      );
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.login) {
      NavigationController.navigator.push(const LoginRoute());
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.points) {
      NavigationController.navigator.push(
        const PointsScreenRoute(),
        onFailure: (_) {
          NavigationController.navigator.push(
            LoginFromXRoute(
              onSuccess: () {
                NavigationController.navigator.push(
                  const PointsScreenRoute(),
                );
              },
            ),
          );
        },
      );
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.review) {
      NavigationController.navigator.push(ReviewScreenRoute(
        productId: action.arguments?['productId'] ?? '',
      ));
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.signup) {
      NavigationController.navigator.push(const SignupRoute());
      return;
    }
    if (action.navigationData.screenId == AppPrebuiltScreensId.tags ||
        screenData is AppTagsScreenData) {
      NavigationController.navigator.push(TagsScreenLayoutRoute(
        screenData: screenData as AppTagsScreenData,
      ));
      return;
    }

    if (action.navigationData.screenId == AppPrebuiltScreensId.allVendors) {
      NavigationController.navigator.push(AllVendorsScreenLayoutRoute(
        screenData: screenData as AppAllVendorsScreenData,
      ));
      return;
    }

    if (action.navigationData.screenId == AppPrebuiltScreensId.blogs ||
        screenData is AppBlogScreenData) {
      NavigationController.navigator.push(BlogScreenLayoutRoute(
        screenData: screenData as AppBlogScreenData,
      ));
      return;
    }

    if (screenData is AppDynamicScreenData) {
      NavigationController.navigator.push(DynamicScreenLayoutRoute(
        screenData: screenData,
      ));
      return;
    }

    if (screenData is AppHtmlScreenData) {
      NavigationController.navigator.push(HtmlScreenLayoutRoute(
        screenData: screenData,
      ));
      return;
    }
    if (screenData is AppWebpageScreenData) {
      NavigationController.navigator.push(WebpageScreenLayoutRoute(
        screenData: screenData,
      ));
      return;
    }

    if (screenData is AppSinglePostScreenData) {
      NavigationController.navigator.push(SinglePostScreenLayoutRoute(
        screenData: screenData,
      ));
      return;
    }
  }

  static bool get enabledGuestCheckout =>
      appTemplate.appConfigurationData.enableGuestCheckout;

  static bool get enabledPointsAndRewards =>
      appTemplate.appConfigurationData.enablePointsAndRewardsSupport;

  static bool get enabledVariationSwatches =>
      appTemplate.appConfigurationData.enabledVariationSwatchesForWooCommerce;

  static double get minPrice =>
      appTemplate.appConfigurationData.filterConfigData.minPrice;

  static double get maxPrice =>
      appTemplate.appConfigurationData.filterConfigData.maxPrice;

  static int get priceRangeDivisions =>
      appTemplate.appConfigurationData.filterConfigData.priceRangeDivisions;

  static int get itemsPerPage =>
      appTemplate.appConfigurationData.filterConfigData.itemsPerPage;

  static String get currencySymbol =>
      appTemplate.appConfigurationData.currencySymbol;

  static String get currency => appTemplate.appConfigurationData.currency;

  static String get contactUsEmail =>
      appTemplate.appConfigurationData.contactUsEmail;

  static String get contactUsPhone =>
      appTemplate.appConfigurationData.contactUsPhone;

  static String get contactUsUrl =>
      appTemplate.appConfigurationData.contactUsUrl;

  static List<String>? get notificationTopics =>
      appTemplate.appConfigurationData.firebaseNotificationTopics;

  static bool get enableOTPLogin => appTemplate.socialLoginData.enableSmsLogin;
  static bool get enabledAppleLogin =>
      appTemplate.socialLoginData.enableAppleLogin;
  static bool get enabledGoogleLogin =>
      appTemplate.socialLoginData.enableGoogleLogin;
  static bool get enabledFacebookLogin =>
      appTemplate.socialLoginData.enableFacebookLogin;
  static String get termsOfServiceUrl =>
      appTemplate.appConfigurationData.termsOfServiceUrl;
  static String get privacyPolicyUrl =>
      appTemplate.appConfigurationData.privacyPolicyUrl;
  static AppFirebaseDynamicLinksData get firebaseDynamicLinksConfig =>
      appTemplate.appConfigurationData.appFirebaseDynamicLinksData;
  static String get defaultCountryCode =>
      appTemplate.socialLoginData.defaultCountryCode;
}
