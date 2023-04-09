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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../navigation/tabbar.dart';
import '../screens/accountSettings/delete_account.dart';
import '../screens/addAddress/addAddress.dart';
import '../screens/address/address.dart';
import '../screens/all_products/all_products.dart';
import '../screens/all_vendors/all_vendors.dart';
import '../screens/blog/blog.dart';
import '../screens/cards/addNewCard.dart';
import '../screens/cards/cards.dart';
import '../screens/cart/cart.dart';
import '../screens/categories/categoriesScreen.dart';
import '../screens/categories/categorisedProducts.dart';
import '../screens/changePassword/changePassword.dart';
import '../screens/contact/contact.dart';
import '../screens/downloads/downloads.dart';
import '../screens/dynamic/dynamic.dart';
import '../screens/editProfile/editProfile.dart';
import '../screens/favorites/favorites.dart';
import '../screens/html/html.dart';
import '../screens/login/login.dart';
import '../screens/login/widgets/loginFromX.dart';
import '../screens/myOrders/myOrders.dart';
import '../screens/myOrders/trackOrder/trackOrder.dart';
import '../screens/my_account/my_account.dart';
import '../screens/notifications/notifications.dart';
import '../screens/onBoarding/onBoarding.dart';
import '../screens/points/points.dart';
import '../screens/product/product.dart';
import '../screens/profile/profile.dart';
import '../screens/review/reviewScreen.dart';
import '../screens/search/search.dart';
import '../screens/settings/settings.dart';
import '../screens/signup/signup.dart';
import '../screens/single_post/single_post.dart';
import '../screens/splash/splash.dart';
import '../screens/tags/tags.dart';
import '../screens/vendor/vendor_details.dart';
import '../screens/webpage/webpage.dart';
import '../shared/alerts/custom_alert.dart';
import 'guards.dart';

@CupertinoAutoRouter(
  routes: <AutoRoute>[
    CupertinoRoute(page: SplashScreen, initial: true),
    CupertinoRoute(page: TabbarNavigation),
    CupertinoRoute(page: ProductDetailsScreenLayout),
    CupertinoRoute(page: Signup),
    CupertinoRoute(page: Login),
    CupertinoRoute(page: OnBoardingScreenLayout),
    CupertinoRoute(page: MyOrdersScreenLayout, guards: [AuthGuard]),
    CupertinoRoute(page: TrackOrder),
    CupertinoRoute(page: WishlistScreenLayout),
    CupertinoRoute(page: CartScreenLayout),
    CupertinoRoute(page: ProfileScreenLayout),
    CupertinoRoute(page: EditProfile, guards: [AuthGuard]),
    CupertinoRoute(page: CardsScreen),
    CupertinoRoute(page: ContactScreen),
    CupertinoRoute(page: ChangePassword, guards: [AuthGuard]),
    CupertinoRoute(page: AddressScreen, guards: [AuthGuard]),
    CupertinoRoute(page: AddAddress, guards: [AuthGuard]),
    CupertinoRoute(page: AddNewCardScreen),
    CupertinoRoute(page: CategorisedProducts),
    CupertinoRoute(page: SearchScreenLayout),
    CupertinoRoute(page: SettingsScreenLayout),
    CupertinoRoute(page: MyAccountScreenLayout),
    CupertinoRoute(page: PointsScreen, guards: [AuthGuard]),
    CupertinoRoute(page: LoginFromX),
    CupertinoRoute(page: DownloadsScreen, guards: [AuthGuard]),
    CupertinoRoute(page: NotificationScreen),
    CupertinoRoute(page: CategoriesScreenLayout),
    CupertinoRoute(page: ReviewScreen),
    CupertinoRoute(page: TagsScreenLayout),
    CupertinoRoute(page: VendorDetailsScreenLayout),
    CupertinoRoute(page: AllProductsScreenLayout),
    CupertinoRoute(page: AllVendorsScreenLayout),
    CupertinoRoute(page: BlogScreenLayout),
    CupertinoRoute(page: DynamicScreenLayout),
    CupertinoRoute(page: HtmlScreenLayout),
    CupertinoRoute(page: WebpageScreenLayout),
    CupertinoRoute(page: SinglePostScreenLayout),
    CupertinoRoute(page: DeleteAccountPage),
    CustomRoute(
      page: CustomAlert,
      transitionsBuilder: zoomInTransition,
      fullscreenDialog: true,
      barrierDismissible: false,
      durationInMilliseconds: 500,
      reverseDurationInMilliseconds: 500,
      opaque: false,
    )
  ],
)
class $AppRouter {}

Widget zoomInTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  // you get an animation object and a widget
  // make your own transition
  animation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  return FadeTransition(opacity: animation, child: child);
}
