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
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

import '../../../../app_builder.dart';
import '../../../utils.dart';

part 'advanced_sections_data.dart';
part 'attributes_data.dart';
part 'categories_data.dart';
part 'description_data.dart';
part 'image_section_data.dart';
part 'linked_products.dart';
part 'points_and_rewards.dart';
part 'price_data.dart';
part 'product_add_ons_data.dart';
part 'product_name_section_data.dart';
part 'quantity_data.dart';
part 'review_data.dart';
part 'stock_availability_data.dart';
part 'tags_data.dart';
part 'vendor_data.dart';

@immutable
class AppProductScreenData extends AppScreenData {
  final AppBarData appBarData;
  final PSLayout screenLayout;
  final PSBottomButtonsLayout bottomButtonsLayout;
  final List<PSSectionData> sections;

  final TextStyleData bottomButtonTextStyle;

  const AppProductScreenData({
    int id = AppPrebuiltScreensId.product,
    AppScreenType screenType = AppScreenType.preBuilt,
    String name = AppPrebuiltScreensNames.product,
    this.screenLayout = PSLayout.expandable,
    this.sections = defaultProductScreenSections,
    this.appBarData = const _DefaultAppbarData(),
    this.bottomButtonsLayout = PSBottomButtonsLayout.layout2,
    this.bottomButtonTextStyle = const TextStyleData(),
  }) : super(
          id: id,
          name: name,
          appScreenLayoutType: AppScreenLayoutType.product,
          screenType: screenType,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'screenLayout': screenLayout.name,
      'bottomButtonsLayout': bottomButtonsLayout.name,
      'sections': sections.map((e) => e.toMap()).toList(),
      'appBarData': appBarData.toMap(),
      'bottomButtonTextStyle': bottomButtonTextStyle.toMap(),
    };
  }

  factory AppProductScreenData.fromMap(Map<String, dynamic> map) {
    try {
      return AppProductScreenData(
        screenLayout: getLayoutType(map['screenLayout']),
        appBarData: AppBarData.fromMap(map['appBarData']),
        bottomButtonsLayout:
            getBottomButtonsLayoutType(map['bottomButtonsLayout']),
        sections: ModelUtils.createListOfType<PSSectionData>(
          map['sections'],
          (elem) => PSSectionData.fromMap(elem),
        ),
        id: ModelUtils.createIntProperty(map['id']),
        name: ModelUtils.createStringProperty(map['name']),
        screenType: AppScreenData.getScreenType(map['screenType']),
        bottomButtonTextStyle:
            TextStyleData.fromMap(map['bottomButtonTextStyle']),
      );
    } catch (e) {
      return AppProductScreenData(
        id: ModelUtils.createIntProperty(map['id']),
        name: ModelUtils.createStringProperty(map['name']),
        screenType: AppScreenData.getScreenType(map['screenType']),
        bottomButtonTextStyle:
            TextStyleData.fromMap(map['bottomButtonTextStyle']),
      );
    }
  }

  static PSLayout getLayoutType(String? layoutName) {
    switch (layoutName) {
      case 'original':
        return PSLayout.original;
      case 'expandable':
        return PSLayout.expandable;
      case 'draggableSheet':
        return PSLayout.draggableSheet;
      case 'custom':
        return PSLayout.custom;

      default:
        return PSLayout.expandable;
    }
  }

  static PSBottomButtonsLayout getBottomButtonsLayoutType(String? layoutName) {
    switch (layoutName) {
      case 'layout1':
        return PSBottomButtonsLayout.layout1;
      case 'layout2':
        return PSBottomButtonsLayout.layout2;
      case 'layout3':
        return PSBottomButtonsLayout.layout3;

      default:
        return PSBottomButtonsLayout.layout2;
    }
  }

  @override
  AppProductScreenData copyWith({
    AppBarData? appBarData,
    PSLayout? screenLayout,
    PSBottomButtonsLayout? bottomButtonsLayout,
    List<PSSectionData>? sections,
    String? name,
    TextStyleData? bottomButtonTextStyle,
  }) {
    return AppProductScreenData(
      id: id,
      name: name ?? this.name,
      screenType: screenType,
      appBarData: appBarData ?? this.appBarData,
      screenLayout: screenLayout ?? this.screenLayout,
      bottomButtonsLayout: bottomButtonsLayout ?? this.bottomButtonsLayout,
      sections: sections ?? this.sections,
      bottomButtonTextStyle:
          bottomButtonTextStyle ?? this.bottomButtonTextStyle,
    );
  }
}

enum PSLayout {
  original,
  expandable,
  draggableSheet,
  custom,
}

enum PSBottomButtonsLayout {
  layout1,
  layout2,
  layout3,
}

@immutable
class PSSectionData {
  final int id;
  final PSSectionType sectionType;
  final StyledData styledData;

  static const defaultStyledData = StyledData(
    marginData: defaultMarginData,
    paddingData: defaultPaddingData,
    borderRadius: 10,
  );

  static const defaultMarginData = MarginData(
    left: 10,
    right: 10,
    top: 0,
    bottom: 10,
  );

  static const defaultPaddingData = PaddingData(
    left: 15,
    right: 15,
    top: 15,
    bottom: 15,
  );

  const PSSectionData({
    required this.id,
    required this.sectionType,
    this.styledData = defaultStyledData,
  });

  const PSSectionData.empty({
    this.id = 0,
    this.sectionType = PSSectionType.undefined,
    this.styledData = defaultStyledData,
  });

  factory PSSectionData.fromMap(Map<String, dynamic> map) {
    final PSSectionType _sectionType =
        PSSectionData.convertStringToProductScreenSectionType(
            map['sectionType']);
    switch (_sectionType) {
      case PSSectionType.image:
        return PSImageSectionData.fromMap(map);

      case PSSectionType.productName:
        return PSProductNameSectionData.fromMap(map);

      case PSSectionType.price:
        return PSPriceSectionData.fromMap(map);

      case PSSectionType.attributes:
        return PSAttributesSectionData.fromMap(map);

      case PSSectionType.stockAvailability:
        return PSStockAvailabilitySectionData.fromMap(map);

      case PSSectionType.description:
        return PSDescriptionSectionData.fromMap(map);

      case PSSectionType.shortDescription:
        return PSShortDescriptionSectionData.fromMap(map);

      case PSSectionType.quantity:
        return PSQuantitySectionData.fromMap(map);

      case PSSectionType.review:
        return PSReviewSectionData.fromMap(map);

      case PSSectionType.categories:
        return PSCategoriesSectionData.fromMap(map);

      case PSSectionType.tags:
        return PSTagsSectionData.fromMap(map);

      case PSSectionType.relatedProducts:
        return PSRelatedProductsSectionData.fromMap(map);

      case PSSectionType.crossSellProducts:
        return PSCrossSellProductsSectionData.fromMap(map);

      case PSSectionType.upSellProducts:
        return PSUpSellProductsSectionData.fromMap(map);

      case PSSectionType.vendor:
        return PSVendorSectionData.fromMap(map);

      case PSSectionType.pointsAndRewards:
        return PSPointsAndRewardsSectionData.fromMap(map);
      case PSSectionType.text:
        return PSTextSectionData.fromMap(map);
      case PSSectionType.banner:
        return PSBannerSectionData.fromMap(map);
      case PSSectionType.advancedBanner:
        return PSAdvancedBannerSectionData.fromMap(map);
      case PSSectionType.productAddOns:
        return PSProductAddOnSectionData.fromMap(map);
      default:
        return const PSSectionData.empty();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sectionType': sectionType.name,
      'styledData': styledData.toMap(),
    };
  }

  PSSectionData copyWith({
    StyledData? styledData,
  }) {
    return PSSectionData(
      id: id,
      sectionType: sectionType,
      styledData: styledData ?? this.styledData,
    );
  }

  static PSSectionType convertStringToProductScreenSectionType(String? value) {
    if (value == null || value == '') {
      return PSSectionType.undefined;
    }

    switch (value) {
      case 'image':
        return PSSectionType.image;

      case 'productName':
        return PSSectionType.productName;

      case 'price':
        return PSSectionType.price;

      case 'attributes':
        return PSSectionType.attributes;

      case 'stockAvailability':
        return PSSectionType.stockAvailability;

      case 'description':
        return PSSectionType.description;

      case 'shortDescription':
        return PSSectionType.shortDescription;

      case 'quantity':
        return PSSectionType.quantity;

      case 'review':
        return PSSectionType.review;

      case 'categories':
        return PSSectionType.categories;

      case 'tags':
        return PSSectionType.tags;

      case 'relatedProducts':
        return PSSectionType.relatedProducts;

      case 'crossSellProducts':
        return PSSectionType.crossSellProducts;

      case 'upSellProducts':
        return PSSectionType.upSellProducts;

      case 'vendor':
        return PSSectionType.vendor;

      case 'pointsAndRewards':
        return PSSectionType.pointsAndRewards;

      case 'text':
        return PSSectionType.text;

      case 'banner':
        return PSSectionType.banner;

      case 'advancedBanner':
        return PSSectionType.advancedBanner;

      case 'productAddOns':
        return PSSectionType.productAddOns;

      default:
        return PSSectionType.undefined;
    }
  }
}

enum PSSectionType {
  image,
  productName,
  price,
  attributes,

  /// Can contain the SKU for the product
  stockAvailability,
  description,
  shortDescription,
  quantity,
  review,
  categories,
  tags,
  relatedProducts,
  crossSellProducts,
  upSellProducts,
  vendor,
  pointsAndRewards,
  productAddOns,

  // Advanced sections
  text,
  banner,
  advancedBanner,
  undefined,
}

class _DefaultAppbarData extends AppBarData {
  const _DefaultAppbarData()
      : super(
          actionButtons: const [
            AppBarActionButtonData(
              id: 1,
              tooltip: 'Like',
              iconData: EvaIcons.heartOutline,
              action: AppAction(type: AppActionType.productLike),
              allowDelete: false,
              allowChangeAction: false,
            ),
            AppBarActionButtonData(
              id: 3,
              tooltip: 'Share',
              iconData: Icons.ios_share_rounded,
              action: AppAction(type: AppActionType.productShare),
              allowDelete: false,
              allowChangeAction: false,
            ),
            AppBarActionButtonData(
              id: 2,
              tooltip: 'Cart',
              iconData: EvaIcons.shoppingCartOutline,
              action: NavigationAction(
                navigationData: NavigationData(
                  screenName: 'Cart',
                  screenId: AppPrebuiltScreensId.cart,
                ),
              ),
            ),
          ],
        );
}

const List<PSSectionData> defaultProductScreenSections = [
  PSImageSectionData(id: 1),
  PSProductNameSectionData(id: 5),
  PSPriceSectionData(id: 6),
  PSStockAvailabilitySectionData(id: 9),
  PSShortDescriptionSectionData(id: 10),
  PSAttributesSectionData(id: 11),
  PSQuantitySectionData(id: 12),
  PSDescriptionSectionData(id: 13),
  PSReviewSectionData(id: 14),
  PSCategoriesSectionData(id: 15),
  PSTagsSectionData(id: 16),
  PSUpSellProductsSectionData(id: 17),
  PSCrossSellProductsSectionData(id: 18),
  PSRelatedProductsSectionData(id: 19),
];
