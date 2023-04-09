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

import '../../models/models.dart';
import '../actions.dart';

@immutable
class NavigationAction extends AppAction {
  final NavigationData navigationData;
  final Map? arguments;

  const NavigationAction({
    this.navigationData = const NavigationData(),
    this.arguments,
  }) : super(type: AppActionType.navigation);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'navigationData': navigationData.toMap(),
      'args': arguments,
    };
  }

  factory NavigationAction.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const NavigationAction();
      }

      return NavigationAction(
        navigationData: NavigationData.fromMap(map['navigationData']),
        arguments: map['args'],
      );
    } catch (_) {
      return const NavigationAction();
    }
  }

  @override
  NavigationAction copyWith({
    NavigationData? navigationData,
    Map? arguments,
  }) {
    return NavigationAction(
      navigationData: navigationData ?? this.navigationData,
      arguments: arguments ?? this.arguments,
    );
  }
}

class NavigationData {
  final int screenId;
  final String screenName;

  const NavigationData({
    this.screenId = -1,
    this.screenName = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'screenId': screenId,
      'screenName': screenName,
    };
  }

  factory NavigationData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const NavigationData();
    }

    return NavigationData(
      screenId: ModelUtils.createIntProperty(map['screenId']),
      screenName: ModelUtils.createStringProperty(map['screenName']),
    );
  }

  NavigationData copyWith({
    int? screenId,
    String? screenName,
  }) {
    return NavigationData(
      screenId: screenId ?? this.screenId,
      screenName: screenName ?? this.screenName,
    );
  }
}

@immutable
class NavigateToAllProductsScreenAction extends AppAction {
  final String title;
  final TagData tagData;
  final CategoryData categoryData;

  const NavigateToAllProductsScreenAction({
    this.title = '',
    this.tagData = const TagData(),
    this.categoryData = const CategoryData(),
  }) : super(type: AppActionType.navigateToAllProductsScreen);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'title': title,
      'tagData': tagData.toMap(),
      'categoryData': categoryData.toMap(),
    };
  }

  factory NavigateToAllProductsScreenAction.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const NavigateToAllProductsScreenAction();
      }

      return NavigateToAllProductsScreenAction(
        title: ModelUtils.createStringProperty(map['title']),
        tagData: TagData.fromMap(map['tagData']),
        categoryData: CategoryData.fromMap(map['categoryData']),
      );
    } catch (_) {
      return const NavigateToAllProductsScreenAction();
    }
  }

  @override
  NavigateToAllProductsScreenAction copyWith({
    String? title,
    TagData? tagData,
    CategoryData? categoryData,
  }) {
    return NavigateToAllProductsScreenAction(
      title: title ?? this.title,
      tagData: tagData ?? this.tagData,
      categoryData: categoryData ?? this.categoryData,
    );
  }
}

@immutable
class NavigateToSingleProductScreenAction extends AppAction {
  final ProductData productData;

  const NavigateToSingleProductScreenAction({
    this.productData = const ProductData(),
  }) : super(type: AppActionType.navigateToSingleProductScreen);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'productData': productData.toMap(),
    };
  }

  factory NavigateToSingleProductScreenAction.fromMap(
      Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const NavigateToSingleProductScreenAction();
      }

      return NavigateToSingleProductScreenAction(
        productData: ProductData.fromMap(map['productData']),
      );
    } catch (_) {
      return const NavigateToSingleProductScreenAction();
    }
  }

  @override
  NavigateToSingleProductScreenAction copyWith({
    ProductData? productData,
  }) {
    return NavigateToSingleProductScreenAction(
      productData: productData ?? this.productData,
    );
  }
}

@immutable
class NavigateToReviewScreenAction extends AppAction {
  final ProductData productData;

  const NavigateToReviewScreenAction({
    this.productData = const ProductData(),
  }) : super(type: AppActionType.navigateToReviewScreen);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'productData': productData.toMap(),
    };
  }

  factory NavigateToReviewScreenAction.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const NavigateToReviewScreenAction();
      }

      return NavigateToReviewScreenAction(
        productData: ProductData.fromMap(map['productData']),
      );
    } catch (_) {
      return const NavigateToReviewScreenAction();
    }
  }

  @override
  NavigateToReviewScreenAction copyWith({
    ProductData? productData,
  }) {
    return NavigateToReviewScreenAction(
      productData: productData ?? this.productData,
    );
  }
}

@immutable
class NavigateToSingleVendorScreenAction extends AppAction {
  final VendorData vendorData;

  const NavigateToSingleVendorScreenAction({
    this.vendorData = const VendorData(),
  }) : super(type: AppActionType.navigateToSingleVendorScreen);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'vendorData': vendorData.toMap(),
    };
  }

  factory NavigateToSingleVendorScreenAction.fromMap(
      Map<String, dynamic>? map) {
    try {
      if (map == null) {
        return const NavigateToSingleVendorScreenAction();
      }

      return NavigateToSingleVendorScreenAction(
        vendorData: VendorData.fromMap(map['vendorData']),
      );
    } catch (_) {
      return const NavigateToSingleVendorScreenAction();
    }
  }

  @override
  NavigateToSingleVendorScreenAction copyWith({
    VendorData? vendorData,
  }) {
    return NavigateToSingleVendorScreenAction(
      vendorData: vendorData ?? this.vendorData,
    );
  }
}
