// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i40;
import 'package:flutter/material.dart' as _i41;
import 'package:woocommerce/models/vendor.dart' as _i47;

import '../app_builder/app_builder.dart' as _i44;
import '../navigation/tabbar.dart' as _i2;
import '../screens/accountSettings/delete_account.dart' as _i38;
import '../screens/addAddress/addAddress.dart' as _i17;
import '../screens/address/address.dart' as _i16;
import '../screens/all_products/all_products.dart' as _i31;
import '../screens/all_vendors/all_vendors.dart' as _i32;
import '../screens/blog/blog.dart' as _i33;
import '../screens/blog/view_model/view_model.dart' as _i48;
import '../screens/cards/addNewCard.dart' as _i18;
import '../screens/cards/cards.dart' as _i13;
import '../screens/cart/cart.dart' as _i10;
import '../screens/categories/categoriesScreen.dart' as _i27;
import '../screens/categories/categorisedProducts.dart' as _i19;
import '../screens/changePassword/changePassword.dart' as _i15;
import '../screens/contact/contact.dart' as _i14;
import '../screens/downloads/downloads.dart' as _i25;
import '../screens/dynamic/dynamic.dart' as _i34;
import '../screens/editProfile/editProfile.dart' as _i12;
import '../screens/favorites/favorites.dart' as _i9;
import '../screens/html/html.dart' as _i35;
import '../screens/login/login.dart' as _i5;
import '../screens/login/widgets/loginFromX.dart' as _i24;
import '../screens/myOrders/myOrders.dart' as _i7;
import '../screens/myOrders/order.model.dart' as _i45;
import '../screens/myOrders/trackOrder/trackOrder.dart' as _i8;
import '../screens/my_account/my_account.dart' as _i22;
import '../screens/notifications/notifications.dart' as _i26;
import '../screens/onBoarding/onBoarding.dart' as _i6;
import '../screens/points/points.dart' as _i23;
import '../screens/product/product.dart' as _i3;
import '../screens/profile/profile.dart' as _i11;
import '../screens/review/reviewScreen.dart' as _i28;
import '../screens/search/search.dart' as _i20;
import '../screens/settings/settings.dart' as _i21;
import '../screens/signup/signup.dart' as _i4;
import '../screens/single_post/single_post.dart' as _i37;
import '../screens/splash/splash.dart' as _i1;
import '../screens/tags/tags.dart' as _i29;
import '../screens/vendor/vendor_details.dart' as _i30;
import '../screens/webpage/webpage.dart' as _i36;
import '../services/woocommerce/woocommerce.service.dart' as _i46;
import '../shared/alerts/custom_alert.dart' as _i39;
import 'guards.dart' as _i42;
import 'router.dart' as _i43;

class AppRouter extends _i40.RootStackRouter {
  AppRouter(
      {_i41.GlobalKey<_i41.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i42.AuthGuard authGuard;

  @override
  final Map<String, _i40.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    TabbarNavigationRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.TabbarNavigation());
    },
    ProductDetailsScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetailsScreenLayout(
              key: args.key, screenData: args.screenData, id: args.id));
    },
    SignupRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i4.Signup());
    },
    LoginRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.Login());
    },
    OnBoardingScreenLayoutRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.OnBoardingScreenLayout());
    },
    MyOrdersScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<MyOrdersScreenLayoutRouteArgs>(
          orElse: () => const MyOrdersScreenLayoutRouteArgs());
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i7.MyOrdersScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    TrackOrderRoute.name: (routeData) {
      final args = routeData.argsAs<TrackOrderRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i8.TrackOrder(key: args.key, order: args.order));
    },
    WishlistScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<WishlistScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i9.WishlistScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    CartScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<CartScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i10.CartScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    ProfileScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i11.ProfileScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    EditProfileRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i12.EditProfile());
    },
    CardsScreenRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i13.CardsScreen());
    },
    ContactScreenRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i14.ContactScreen());
    },
    ChangePasswordRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i15.ChangePassword());
    },
    AddressScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddressScreenRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child:
              _i16.AddressScreen(key: args.key, isShipping: args.isShipping));
    },
    AddAddressRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i17.AddAddress());
    },
    AddNewCardScreenRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i18.AddNewCardScreen());
    },
    CategorisedProductsRoute.name: (routeData) {
      final args = routeData.argsAs<CategorisedProductsRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i19.CategorisedProducts(
              key: args.key,
              category: args.category,
              searchCategory: args.searchCategory,
              childrenCategoryList: args.childrenCategoryList));
    },
    SearchScreenLayoutRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i20.SearchScreenLayout());
    },
    SettingsScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i21.SettingsScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    MyAccountScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<MyAccountScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i22.MyAccountScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    PointsScreenRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i23.PointsScreen());
    },
    LoginFromXRoute.name: (routeData) {
      final args = routeData.argsAs<LoginFromXRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i24.LoginFromX(key: args.key, onSuccess: args.onSuccess));
    },
    DownloadsScreenRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i25.DownloadsScreen());
    },
    NotificationScreenRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i26.NotificationScreen());
    },
    CategoriesScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<CategoriesScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i27.CategoriesScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    ReviewScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ReviewScreenRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i28.ReviewScreen(key: args.key, productId: args.productId));
    },
    TagsScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<TagsScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i29.TagsScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    VendorDetailsScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<VendorDetailsScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i30.VendorDetailsScreenLayout(
              key: args.key,
              screenData: args.screenData,
              vendorData: args.vendorData));
    },
    AllProductsScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<AllProductsScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i31.AllProductsScreenLayout(
              key: args.key, screenData: args.screenData, action: args.action));
    },
    AllVendorsScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<AllVendorsScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i32.AllVendorsScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    BlogScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<BlogScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i33.BlogScreenLayout(
              key: args.key, screenData: args.screenData, filter: args.filter));
    },
    DynamicScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<DynamicScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i34.DynamicScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    HtmlScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<HtmlScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i35.HtmlScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    WebpageScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<WebpageScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i36.WebpageScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    SinglePostScreenLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<SinglePostScreenLayoutRouteArgs>();
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i37.SinglePostScreenLayout(
              key: args.key, screenData: args.screenData));
    },
    DeleteAccountPageRoute.name: (routeData) {
      return _i40.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i38.DeleteAccountPage());
    },
    CustomAlertRoute.name: (routeData) {
      final args = routeData.argsAs<CustomAlertRouteArgs>();
      return _i40.CustomPage<dynamic>(
          routeData: routeData,
          child: _i39.CustomAlert(key: args.key, child: args.child),
          fullscreenDialog: true,
          transitionsBuilder: _i43.zoomInTransition,
          durationInMilliseconds: 500,
          reverseDurationInMilliseconds: 500,
          opaque: false,
          barrierDismissible: false);
    }
  };

  @override
  List<_i40.RouteConfig> get routes => [
        _i40.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i40.RouteConfig(TabbarNavigationRoute.name,
            path: '/tabbar-navigation'),
        _i40.RouteConfig(ProductDetailsScreenLayoutRoute.name,
            path: '/product-details-screen-layout'),
        _i40.RouteConfig(SignupRoute.name, path: '/Signup'),
        _i40.RouteConfig(LoginRoute.name, path: '/Login'),
        _i40.RouteConfig(OnBoardingScreenLayoutRoute.name,
            path: '/on-boarding-screen-layout'),
        _i40.RouteConfig(MyOrdersScreenLayoutRoute.name,
            path: '/my-orders-screen-layout', guards: [authGuard]),
        _i40.RouteConfig(TrackOrderRoute.name, path: '/track-order'),
        _i40.RouteConfig(WishlistScreenLayoutRoute.name,
            path: '/wishlist-screen-layout'),
        _i40.RouteConfig(CartScreenLayoutRoute.name,
            path: '/cart-screen-layout'),
        _i40.RouteConfig(ProfileScreenLayoutRoute.name,
            path: '/profile-screen-layout'),
        _i40.RouteConfig(EditProfileRoute.name,
            path: '/edit-profile', guards: [authGuard]),
        _i40.RouteConfig(CardsScreenRoute.name, path: '/cards-screen'),
        _i40.RouteConfig(ContactScreenRoute.name, path: '/contact-screen'),
        _i40.RouteConfig(ChangePasswordRoute.name,
            path: '/change-password', guards: [authGuard]),
        _i40.RouteConfig(AddressScreenRoute.name,
            path: '/address-screen', guards: [authGuard]),
        _i40.RouteConfig(AddAddressRoute.name,
            path: '/add-address', guards: [authGuard]),
        _i40.RouteConfig(AddNewCardScreenRoute.name,
            path: '/add-new-card-screen'),
        _i40.RouteConfig(CategorisedProductsRoute.name,
            path: '/categorised-products'),
        _i40.RouteConfig(SearchScreenLayoutRoute.name,
            path: '/search-screen-layout'),
        _i40.RouteConfig(SettingsScreenLayoutRoute.name,
            path: '/settings-screen-layout'),
        _i40.RouteConfig(MyAccountScreenLayoutRoute.name,
            path: '/my-account-screen-layout'),
        _i40.RouteConfig(PointsScreenRoute.name,
            path: '/points-screen', guards: [authGuard]),
        _i40.RouteConfig(LoginFromXRoute.name, path: '/login-from-x'),
        _i40.RouteConfig(DownloadsScreenRoute.name,
            path: '/downloads-screen', guards: [authGuard]),
        _i40.RouteConfig(NotificationScreenRoute.name,
            path: '/notification-screen'),
        _i40.RouteConfig(CategoriesScreenLayoutRoute.name,
            path: '/categories-screen-layout'),
        _i40.RouteConfig(ReviewScreenRoute.name, path: '/review-screen'),
        _i40.RouteConfig(TagsScreenLayoutRoute.name,
            path: '/tags-screen-layout'),
        _i40.RouteConfig(VendorDetailsScreenLayoutRoute.name,
            path: '/vendor-details-screen-layout'),
        _i40.RouteConfig(AllProductsScreenLayoutRoute.name,
            path: '/all-products-screen-layout'),
        _i40.RouteConfig(AllVendorsScreenLayoutRoute.name,
            path: '/all-vendors-screen-layout'),
        _i40.RouteConfig(BlogScreenLayoutRoute.name,
            path: '/blog-screen-layout'),
        _i40.RouteConfig(DynamicScreenLayoutRoute.name,
            path: '/dynamic-screen-layout'),
        _i40.RouteConfig(HtmlScreenLayoutRoute.name,
            path: '/html-screen-layout'),
        _i40.RouteConfig(WebpageScreenLayoutRoute.name,
            path: '/webpage-screen-layout'),
        _i40.RouteConfig(SinglePostScreenLayoutRoute.name,
            path: '/single-post-screen-layout'),
        _i40.RouteConfig(DeleteAccountPageRoute.name,
            path: '/delete-account-page'),
        _i40.RouteConfig(CustomAlertRoute.name, path: '/custom-alert')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i40.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.TabbarNavigation]
class TabbarNavigationRoute extends _i40.PageRouteInfo<void> {
  const TabbarNavigationRoute()
      : super(TabbarNavigationRoute.name, path: '/tabbar-navigation');

  static const String name = 'TabbarNavigationRoute';
}

/// generated route for
/// [_i3.ProductDetailsScreenLayout]
class ProductDetailsScreenLayoutRoute
    extends _i40.PageRouteInfo<ProductDetailsScreenLayoutRouteArgs> {
  ProductDetailsScreenLayoutRoute(
      {_i41.Key? key,
      _i44.AppProductScreenData? screenData,
      required String id})
      : super(ProductDetailsScreenLayoutRoute.name,
            path: '/product-details-screen-layout',
            args: ProductDetailsScreenLayoutRouteArgs(
                key: key, screenData: screenData, id: id));

  static const String name = 'ProductDetailsScreenLayoutRoute';
}

class ProductDetailsScreenLayoutRouteArgs {
  const ProductDetailsScreenLayoutRouteArgs(
      {this.key, this.screenData, required this.id});

  final _i41.Key? key;

  final _i44.AppProductScreenData? screenData;

  final String id;

  @override
  String toString() {
    return 'ProductDetailsScreenLayoutRouteArgs{key: $key, screenData: $screenData, id: $id}';
  }
}

/// generated route for
/// [_i4.Signup]
class SignupRoute extends _i40.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: '/Signup');

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i5.Login]
class LoginRoute extends _i40.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/Login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i6.OnBoardingScreenLayout]
class OnBoardingScreenLayoutRoute extends _i40.PageRouteInfo<void> {
  const OnBoardingScreenLayoutRoute()
      : super(OnBoardingScreenLayoutRoute.name,
            path: '/on-boarding-screen-layout');

  static const String name = 'OnBoardingScreenLayoutRoute';
}

/// generated route for
/// [_i7.MyOrdersScreenLayout]
class MyOrdersScreenLayoutRoute
    extends _i40.PageRouteInfo<MyOrdersScreenLayoutRouteArgs> {
  MyOrdersScreenLayoutRoute(
      {_i41.Key? key, _i44.AppMyOrdersScreenData? screenData})
      : super(MyOrdersScreenLayoutRoute.name,
            path: '/my-orders-screen-layout',
            args: MyOrdersScreenLayoutRouteArgs(
                key: key, screenData: screenData));

  static const String name = 'MyOrdersScreenLayoutRoute';
}

class MyOrdersScreenLayoutRouteArgs {
  const MyOrdersScreenLayoutRouteArgs({this.key, this.screenData});

  final _i41.Key? key;

  final _i44.AppMyOrdersScreenData? screenData;

  @override
  String toString() {
    return 'MyOrdersScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i8.TrackOrder]
class TrackOrderRoute extends _i40.PageRouteInfo<TrackOrderRouteArgs> {
  TrackOrderRoute({_i41.Key? key, required _i45.Order order})
      : super(TrackOrderRoute.name,
            path: '/track-order',
            args: TrackOrderRouteArgs(key: key, order: order));

  static const String name = 'TrackOrderRoute';
}

class TrackOrderRouteArgs {
  const TrackOrderRouteArgs({this.key, required this.order});

  final _i41.Key? key;

  final _i45.Order order;

  @override
  String toString() {
    return 'TrackOrderRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [_i9.WishlistScreenLayout]
class WishlistScreenLayoutRoute
    extends _i40.PageRouteInfo<WishlistScreenLayoutRouteArgs> {
  WishlistScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppWishlistScreenData screenData})
      : super(WishlistScreenLayoutRoute.name,
            path: '/wishlist-screen-layout',
            args: WishlistScreenLayoutRouteArgs(
                key: key, screenData: screenData));

  static const String name = 'WishlistScreenLayoutRoute';
}

class WishlistScreenLayoutRouteArgs {
  const WishlistScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppWishlistScreenData screenData;

  @override
  String toString() {
    return 'WishlistScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i10.CartScreenLayout]
class CartScreenLayoutRoute
    extends _i40.PageRouteInfo<CartScreenLayoutRouteArgs> {
  CartScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppCartScreenData screenData})
      : super(CartScreenLayoutRoute.name,
            path: '/cart-screen-layout',
            args: CartScreenLayoutRouteArgs(key: key, screenData: screenData));

  static const String name = 'CartScreenLayoutRoute';
}

class CartScreenLayoutRouteArgs {
  const CartScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppCartScreenData screenData;

  @override
  String toString() {
    return 'CartScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i11.ProfileScreenLayout]
class ProfileScreenLayoutRoute
    extends _i40.PageRouteInfo<ProfileScreenLayoutRouteArgs> {
  ProfileScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppProfileScreenData screenData})
      : super(ProfileScreenLayoutRoute.name,
            path: '/profile-screen-layout',
            args:
                ProfileScreenLayoutRouteArgs(key: key, screenData: screenData));

  static const String name = 'ProfileScreenLayoutRoute';
}

class ProfileScreenLayoutRouteArgs {
  const ProfileScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppProfileScreenData screenData;

  @override
  String toString() {
    return 'ProfileScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i12.EditProfile]
class EditProfileRoute extends _i40.PageRouteInfo<void> {
  const EditProfileRoute()
      : super(EditProfileRoute.name, path: '/edit-profile');

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [_i13.CardsScreen]
class CardsScreenRoute extends _i40.PageRouteInfo<void> {
  const CardsScreenRoute()
      : super(CardsScreenRoute.name, path: '/cards-screen');

  static const String name = 'CardsScreenRoute';
}

/// generated route for
/// [_i14.ContactScreen]
class ContactScreenRoute extends _i40.PageRouteInfo<void> {
  const ContactScreenRoute()
      : super(ContactScreenRoute.name, path: '/contact-screen');

  static const String name = 'ContactScreenRoute';
}

/// generated route for
/// [_i15.ChangePassword]
class ChangePasswordRoute extends _i40.PageRouteInfo<void> {
  const ChangePasswordRoute()
      : super(ChangePasswordRoute.name, path: '/change-password');

  static const String name = 'ChangePasswordRoute';
}

/// generated route for
/// [_i16.AddressScreen]
class AddressScreenRoute extends _i40.PageRouteInfo<AddressScreenRouteArgs> {
  AddressScreenRoute({_i41.Key? key, required bool isShipping})
      : super(AddressScreenRoute.name,
            path: '/address-screen',
            args: AddressScreenRouteArgs(key: key, isShipping: isShipping));

  static const String name = 'AddressScreenRoute';
}

class AddressScreenRouteArgs {
  const AddressScreenRouteArgs({this.key, required this.isShipping});

  final _i41.Key? key;

  final bool isShipping;

  @override
  String toString() {
    return 'AddressScreenRouteArgs{key: $key, isShipping: $isShipping}';
  }
}

/// generated route for
/// [_i17.AddAddress]
class AddAddressRoute extends _i40.PageRouteInfo<void> {
  const AddAddressRoute() : super(AddAddressRoute.name, path: '/add-address');

  static const String name = 'AddAddressRoute';
}

/// generated route for
/// [_i18.AddNewCardScreen]
class AddNewCardScreenRoute extends _i40.PageRouteInfo<void> {
  const AddNewCardScreenRoute()
      : super(AddNewCardScreenRoute.name, path: '/add-new-card-screen');

  static const String name = 'AddNewCardScreenRoute';
}

/// generated route for
/// [_i19.CategorisedProducts]
class CategorisedProductsRoute
    extends _i40.PageRouteInfo<CategorisedProductsRouteArgs> {
  CategorisedProductsRoute(
      {_i41.Key? key,
      required _i46.WooProductCategory category,
      _i46.WooProductCategory? searchCategory,
      List<_i46.WooProductCategory> childrenCategoryList = const []})
      : super(CategorisedProductsRoute.name,
            path: '/categorised-products',
            args: CategorisedProductsRouteArgs(
                key: key,
                category: category,
                searchCategory: searchCategory,
                childrenCategoryList: childrenCategoryList));

  static const String name = 'CategorisedProductsRoute';
}

class CategorisedProductsRouteArgs {
  const CategorisedProductsRouteArgs(
      {this.key,
      required this.category,
      this.searchCategory,
      this.childrenCategoryList = const []});

  final _i41.Key? key;

  final _i46.WooProductCategory category;

  final _i46.WooProductCategory? searchCategory;

  final List<_i46.WooProductCategory> childrenCategoryList;

  @override
  String toString() {
    return 'CategorisedProductsRouteArgs{key: $key, category: $category, searchCategory: $searchCategory, childrenCategoryList: $childrenCategoryList}';
  }
}

/// generated route for
/// [_i20.SearchScreenLayout]
class SearchScreenLayoutRoute extends _i40.PageRouteInfo<void> {
  const SearchScreenLayoutRoute()
      : super(SearchScreenLayoutRoute.name, path: '/search-screen-layout');

  static const String name = 'SearchScreenLayoutRoute';
}

/// generated route for
/// [_i21.SettingsScreenLayout]
class SettingsScreenLayoutRoute
    extends _i40.PageRouteInfo<SettingsScreenLayoutRouteArgs> {
  SettingsScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppSettingScreenData screenData})
      : super(SettingsScreenLayoutRoute.name,
            path: '/settings-screen-layout',
            args: SettingsScreenLayoutRouteArgs(
                key: key, screenData: screenData));

  static const String name = 'SettingsScreenLayoutRoute';
}

class SettingsScreenLayoutRouteArgs {
  const SettingsScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppSettingScreenData screenData;

  @override
  String toString() {
    return 'SettingsScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i22.MyAccountScreenLayout]
class MyAccountScreenLayoutRoute
    extends _i40.PageRouteInfo<MyAccountScreenLayoutRouteArgs> {
  MyAccountScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppMyAccountScreenData screenData})
      : super(MyAccountScreenLayoutRoute.name,
            path: '/my-account-screen-layout',
            args: MyAccountScreenLayoutRouteArgs(
                key: key, screenData: screenData));

  static const String name = 'MyAccountScreenLayoutRoute';
}

class MyAccountScreenLayoutRouteArgs {
  const MyAccountScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppMyAccountScreenData screenData;

  @override
  String toString() {
    return 'MyAccountScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i23.PointsScreen]
class PointsScreenRoute extends _i40.PageRouteInfo<void> {
  const PointsScreenRoute()
      : super(PointsScreenRoute.name, path: '/points-screen');

  static const String name = 'PointsScreenRoute';
}

/// generated route for
/// [_i24.LoginFromX]
class LoginFromXRoute extends _i40.PageRouteInfo<LoginFromXRouteArgs> {
  LoginFromXRoute({_i41.Key? key, required void Function() onSuccess})
      : super(LoginFromXRoute.name,
            path: '/login-from-x',
            args: LoginFromXRouteArgs(key: key, onSuccess: onSuccess));

  static const String name = 'LoginFromXRoute';
}

class LoginFromXRouteArgs {
  const LoginFromXRouteArgs({this.key, required this.onSuccess});

  final _i41.Key? key;

  final void Function() onSuccess;

  @override
  String toString() {
    return 'LoginFromXRouteArgs{key: $key, onSuccess: $onSuccess}';
  }
}

/// generated route for
/// [_i25.DownloadsScreen]
class DownloadsScreenRoute extends _i40.PageRouteInfo<void> {
  const DownloadsScreenRoute()
      : super(DownloadsScreenRoute.name, path: '/downloads-screen');

  static const String name = 'DownloadsScreenRoute';
}

/// generated route for
/// [_i26.NotificationScreen]
class NotificationScreenRoute extends _i40.PageRouteInfo<void> {
  const NotificationScreenRoute()
      : super(NotificationScreenRoute.name, path: '/notification-screen');

  static const String name = 'NotificationScreenRoute';
}

/// generated route for
/// [_i27.CategoriesScreenLayout]
class CategoriesScreenLayoutRoute
    extends _i40.PageRouteInfo<CategoriesScreenLayoutRouteArgs> {
  CategoriesScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppCategoryScreenData screenData})
      : super(CategoriesScreenLayoutRoute.name,
            path: '/categories-screen-layout',
            args: CategoriesScreenLayoutRouteArgs(
                key: key, screenData: screenData));

  static const String name = 'CategoriesScreenLayoutRoute';
}

class CategoriesScreenLayoutRouteArgs {
  const CategoriesScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppCategoryScreenData screenData;

  @override
  String toString() {
    return 'CategoriesScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i28.ReviewScreen]
class ReviewScreenRoute extends _i40.PageRouteInfo<ReviewScreenRouteArgs> {
  ReviewScreenRoute({_i41.Key? key, required String productId})
      : super(ReviewScreenRoute.name,
            path: '/review-screen',
            args: ReviewScreenRouteArgs(key: key, productId: productId));

  static const String name = 'ReviewScreenRoute';
}

class ReviewScreenRouteArgs {
  const ReviewScreenRouteArgs({this.key, required this.productId});

  final _i41.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ReviewScreenRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i29.TagsScreenLayout]
class TagsScreenLayoutRoute
    extends _i40.PageRouteInfo<TagsScreenLayoutRouteArgs> {
  TagsScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppTagsScreenData screenData})
      : super(TagsScreenLayoutRoute.name,
            path: '/tags-screen-layout',
            args: TagsScreenLayoutRouteArgs(key: key, screenData: screenData));

  static const String name = 'TagsScreenLayoutRoute';
}

class TagsScreenLayoutRouteArgs {
  const TagsScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppTagsScreenData screenData;

  @override
  String toString() {
    return 'TagsScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i30.VendorDetailsScreenLayout]
class VendorDetailsScreenLayoutRoute
    extends _i40.PageRouteInfo<VendorDetailsScreenLayoutRouteArgs> {
  VendorDetailsScreenLayoutRoute(
      {_i41.Key? key,
      _i44.AppVendorScreenData? screenData,
      required _i47.Vendor vendorData})
      : super(VendorDetailsScreenLayoutRoute.name,
            path: '/vendor-details-screen-layout',
            args: VendorDetailsScreenLayoutRouteArgs(
                key: key, screenData: screenData, vendorData: vendorData));

  static const String name = 'VendorDetailsScreenLayoutRoute';
}

class VendorDetailsScreenLayoutRouteArgs {
  const VendorDetailsScreenLayoutRouteArgs(
      {this.key, this.screenData, required this.vendorData});

  final _i41.Key? key;

  final _i44.AppVendorScreenData? screenData;

  final _i47.Vendor vendorData;

  @override
  String toString() {
    return 'VendorDetailsScreenLayoutRouteArgs{key: $key, screenData: $screenData, vendorData: $vendorData}';
  }
}

/// generated route for
/// [_i31.AllProductsScreenLayout]
class AllProductsScreenLayoutRoute
    extends _i40.PageRouteInfo<AllProductsScreenLayoutRouteArgs> {
  AllProductsScreenLayoutRoute(
      {_i41.Key? key,
      required _i44.AppAllProductsScreenData screenData,
      required _i44.NavigateToAllProductsScreenAction action})
      : super(AllProductsScreenLayoutRoute.name,
            path: '/all-products-screen-layout',
            args: AllProductsScreenLayoutRouteArgs(
                key: key, screenData: screenData, action: action));

  static const String name = 'AllProductsScreenLayoutRoute';
}

class AllProductsScreenLayoutRouteArgs {
  const AllProductsScreenLayoutRouteArgs(
      {this.key, required this.screenData, required this.action});

  final _i41.Key? key;

  final _i44.AppAllProductsScreenData screenData;

  final _i44.NavigateToAllProductsScreenAction action;

  @override
  String toString() {
    return 'AllProductsScreenLayoutRouteArgs{key: $key, screenData: $screenData, action: $action}';
  }
}

/// generated route for
/// [_i32.AllVendorsScreenLayout]
class AllVendorsScreenLayoutRoute
    extends _i40.PageRouteInfo<AllVendorsScreenLayoutRouteArgs> {
  AllVendorsScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppAllVendorsScreenData screenData})
      : super(AllVendorsScreenLayoutRoute.name,
            path: '/all-vendors-screen-layout',
            args: AllVendorsScreenLayoutRouteArgs(
                key: key, screenData: screenData));

  static const String name = 'AllVendorsScreenLayoutRoute';
}

class AllVendorsScreenLayoutRouteArgs {
  const AllVendorsScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppAllVendorsScreenData screenData;

  @override
  String toString() {
    return 'AllVendorsScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i33.BlogScreenLayout]
class BlogScreenLayoutRoute
    extends _i40.PageRouteInfo<BlogScreenLayoutRouteArgs> {
  BlogScreenLayoutRoute(
      {_i41.Key? key,
      required _i44.AppBlogScreenData screenData,
      _i48.BlogFilter? filter})
      : super(BlogScreenLayoutRoute.name,
            path: '/blog-screen-layout',
            args: BlogScreenLayoutRouteArgs(
                key: key, screenData: screenData, filter: filter));

  static const String name = 'BlogScreenLayoutRoute';
}

class BlogScreenLayoutRouteArgs {
  const BlogScreenLayoutRouteArgs(
      {this.key, required this.screenData, this.filter});

  final _i41.Key? key;

  final _i44.AppBlogScreenData screenData;

  final _i48.BlogFilter? filter;

  @override
  String toString() {
    return 'BlogScreenLayoutRouteArgs{key: $key, screenData: $screenData, filter: $filter}';
  }
}

/// generated route for
/// [_i34.DynamicScreenLayout]
class DynamicScreenLayoutRoute
    extends _i40.PageRouteInfo<DynamicScreenLayoutRouteArgs> {
  DynamicScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppDynamicScreenData screenData})
      : super(DynamicScreenLayoutRoute.name,
            path: '/dynamic-screen-layout',
            args:
                DynamicScreenLayoutRouteArgs(key: key, screenData: screenData));

  static const String name = 'DynamicScreenLayoutRoute';
}

class DynamicScreenLayoutRouteArgs {
  const DynamicScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppDynamicScreenData screenData;

  @override
  String toString() {
    return 'DynamicScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i35.HtmlScreenLayout]
class HtmlScreenLayoutRoute
    extends _i40.PageRouteInfo<HtmlScreenLayoutRouteArgs> {
  HtmlScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppHtmlScreenData screenData})
      : super(HtmlScreenLayoutRoute.name,
            path: '/html-screen-layout',
            args: HtmlScreenLayoutRouteArgs(key: key, screenData: screenData));

  static const String name = 'HtmlScreenLayoutRoute';
}

class HtmlScreenLayoutRouteArgs {
  const HtmlScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppHtmlScreenData screenData;

  @override
  String toString() {
    return 'HtmlScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i36.WebpageScreenLayout]
class WebpageScreenLayoutRoute
    extends _i40.PageRouteInfo<WebpageScreenLayoutRouteArgs> {
  WebpageScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppWebpageScreenData screenData})
      : super(WebpageScreenLayoutRoute.name,
            path: '/webpage-screen-layout',
            args:
                WebpageScreenLayoutRouteArgs(key: key, screenData: screenData));

  static const String name = 'WebpageScreenLayoutRoute';
}

class WebpageScreenLayoutRouteArgs {
  const WebpageScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppWebpageScreenData screenData;

  @override
  String toString() {
    return 'WebpageScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i37.SinglePostScreenLayout]
class SinglePostScreenLayoutRoute
    extends _i40.PageRouteInfo<SinglePostScreenLayoutRouteArgs> {
  SinglePostScreenLayoutRoute(
      {_i41.Key? key, required _i44.AppSinglePostScreenData screenData})
      : super(SinglePostScreenLayoutRoute.name,
            path: '/single-post-screen-layout',
            args: SinglePostScreenLayoutRouteArgs(
                key: key, screenData: screenData));

  static const String name = 'SinglePostScreenLayoutRoute';
}

class SinglePostScreenLayoutRouteArgs {
  const SinglePostScreenLayoutRouteArgs({this.key, required this.screenData});

  final _i41.Key? key;

  final _i44.AppSinglePostScreenData screenData;

  @override
  String toString() {
    return 'SinglePostScreenLayoutRouteArgs{key: $key, screenData: $screenData}';
  }
}

/// generated route for
/// [_i38.DeleteAccountPage]
class DeleteAccountPageRoute extends _i40.PageRouteInfo<void> {
  const DeleteAccountPageRoute()
      : super(DeleteAccountPageRoute.name, path: '/delete-account-page');

  static const String name = 'DeleteAccountPageRoute';
}

/// generated route for
/// [_i39.CustomAlert]
class CustomAlertRoute extends _i40.PageRouteInfo<CustomAlertRouteArgs> {
  CustomAlertRoute({_i41.Key? key, required _i41.Widget child})
      : super(CustomAlertRoute.name,
            path: '/custom-alert',
            args: CustomAlertRouteArgs(key: key, child: child));

  static const String name = 'CustomAlertRoute';
}

class CustomAlertRouteArgs {
  const CustomAlertRouteArgs({this.key, required this.child});

  final _i41.Key? key;

  final _i41.Widget child;

  @override
  String toString() {
    return 'CustomAlertRouteArgs{key: $key, child: $child}';
  }
}
