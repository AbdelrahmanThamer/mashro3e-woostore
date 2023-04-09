// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'data/data.dart';
import 'providers/checkoutProvider.dart';
import 'providers/notificationsProvider.dart';
import 'providers/ordersProvider.dart';
import 'providers/products/products.provider.dart';
import 'providers/themeProvider.dart';
import 'providers/userProvider.dart';
import 'screens/cart/viewModel/viewModel.dart';
import 'screens/categories/viewModel/categories.provider.dart';
import 'screens/categories/viewModel/categoryProductsProvider.dart';
import 'screens/home/viewModel/homeViewModel.dart';
import 'screens/myOrders/viewModel/viewModel.dart';
import 'screens/search/viewModel/searchViewModel.dart';
import 'screens/tags/viewModel/view_model.dart';
import 'services/woocommerce/woocommerce.service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<UserProvider>(() => UserProvider());
  locator.registerLazySingleton<ProductsProvider>(() => ProductsProvider());
  locator.registerLazySingleton<OrdersProvider>(() => OrdersProvider());
  locator.registerLazySingleton<NotificationsProvider>(
      () => NotificationsProvider());
  locator.registerLazySingleton<CheckoutProvider>(() => CheckoutProvider());
  locator.registerLazySingleton<CategoryProductsProvider>(
      () => CategoryProductsProvider());
  locator.registerLazySingleton<CategoriesProvider>(() => CategoriesProvider());
  locator.registerLazySingleton<TagsViewModel>(() => TagsViewModel());
  locator.registerLazySingleton<ThemeProvider>(() => ThemeProvider());

  // Data layer
  locator.registerLazySingleton<ProductsRepository>(() => ProductsRepository());

  // View Models for screens
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<MyOrdersViewModel>(() => MyOrdersViewModel());
  locator.registerLazySingleton<SearchViewModel>(() => SearchViewModel());
  locator.registerLazySingleton<CartViewModel>(() => CartViewModel());

  // Services
  locator.registerLazySingleton<WooService>(() => WooService());
}

abstract class LocatorService {
  static UserProvider userProvider() => locator<UserProvider>();

  static ProductsProvider productsProvider() => locator<ProductsProvider>();

  static CategoryProductsProvider categoryProductsProvider() =>
      locator<CategoryProductsProvider>();

  static ThemeProvider themeProvider() => locator<ThemeProvider>();

  static CategoriesProvider categoriesProvider() =>
      locator<CategoriesProvider>();

  static TagsViewModel tagsViewModel() => locator<TagsViewModel>();

  // Data layer
  static ProductsRepository productsRepository() =>
      locator<ProductsRepository>();

  // View Models for screens
  static HomeViewModel homeViewModel() => locator<HomeViewModel>();

  static MyOrdersViewModel myOrdersViewModel() => locator<MyOrdersViewModel>();

  static SearchViewModel searchViewModel() => locator<SearchViewModel>();

  static CartViewModel legacyCartViewModel() => locator<CartViewModel>();
  static CartViewModel cartViewModel() => locator<CartViewModel>();

  // Services
  static WooService wooService() => locator<WooService>();
}

///
/// `Description`
///
/// Holds the context from the tree to show the in-app
/// notifications, alerts, status bars, toast, etc.
///
/// This is a hack to access the context of the widget in conjunction with
/// static methods to show contextual alerts, notification, etc.
/// Always reset the context on this class before use.
///
abstract class Application {
  static late BuildContext _context;

  static BuildContext get context => _context;

  static void setContext(BuildContext context) {
    _context = context;
  }
}
