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

import 'dart:io';
import 'dart:math';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/woo_product_add_on.dart';

import '../services/woocommerce/woocommerce.service.dart';

class Product {
  Product({
    required this.id,
    required this.wooProduct,
    this.liked = false,
  }) {
    // Set the image list
    try {
      _displayImage = '';
      _imagesNotifier.value = _createImageNotifierList(wooProduct.images);

      if (_imagesNotifier.value.isNotEmpty) {
        _displayImage = _imagesNotifier.value[0];
      }
    } catch (_) {
      _imagesNotifier.value = [];
    }

    inStock = wooProduct.stockStatus == 'instock' || false;
    averageRating = wooProduct.averageRating;
    ratingCount.value = wooProduct.ratingCount ?? 0;

    // Call to create a selected data instance just after creating the product
    // model
    setSelectedProductData(this);
    setDefaultAttributes(wooProduct.defaultAttributes);
  }

  /// The unique ID of this product
  final String id;

  /// The associated wooProduct with this instance
  final WooProduct wooProduct;

  String? averageRating = '0.0';
  final ValueNotifier<int> ratingCount = ValueNotifier(0);

  /// Liked and inStock status for the product
  bool liked = false, inStock = true;

  /// Number of items that can be bought
  int quantity = 1;

  /// List of images in a notifier
  final ValueNotifier<List<String>> _imagesNotifier = ValueNotifier(const []);

  /// Getter for image notifier in case to listen to updates
  ValueNotifier<List<String>> get imageNotifier => _imagesNotifier;

  /// List of all the image url related to this product
  List<String> get imageList => _imagesNotifier.value;

  /// Image to display on the ItemCard of the product
  late String _displayImage;

  /// Getter for the display image
  String get displayImage => _displayImage;

  /// The variation which is selected
  WooProductVariation? _selectedVariation;

  /// Getter for selected product variation
  WooProductVariation? get selectedVariation => _selectedVariation;

  /// Holds information about the product variations
  Set<WooProductVariation> variations = {};

  /// Holds the information about the product add ons applied on the product.
  /// where the key is the name of the product add on
  List<ProductSelectedAddon> selectedProductAddons = [];

  // add the product add on value
  void addProductAddon(ProductSelectedAddon addon) {
    if (addon.fieldType == WooProductAddOnType.checkbox) {
      throw Exception('Use addCheckboxProductAddons for checkbox addons');
    }
    if (selectedProductAddons.isEmpty) {
      selectedProductAddons.add(addon);
    } else {
      bool found = false;
      for (int i = 0; i < selectedProductAddons.length; i++) {
        if (selectedProductAddons[i].name == addon.name) {
          // if the field is of type checkbox, then add the addon else
          // replace the value
          selectedProductAddons[i] = addon;
          found = true;
          break;
        }
      }
      // if did not find it then add it.
      if (!found) {
        selectedProductAddons.add(addon);
      }
    }

    for (final o in selectedProductAddons) {
      Dev.info(o.toMap());
    }
  }

  /// Remove the key and its associated values from the add on map
  void removeProductAddon(String addonName) {
    // Function Log
    Dev.debugFunction(
      functionName: 'removeProductAddon',
      className: 'Product',
      fileName: 'productModel.dart',
      start: true,
    );
    selectedProductAddons.removeWhere((element) => element.name == addonName);
    for (final o in selectedProductAddons) {
      Dev.info(o.toMap());
    }
  }

  void addCheckboxProductAddons(Set<ProductSelectedAddon> addons) {
    // firstly remove the checkbox addon values
    selectedProductAddons.removeWhere(
      (element) => element.fieldType == WooProductAddOnType.checkbox,
    );
    // now add the new ones
    selectedProductAddons.addAll(addons);
    for (final o in selectedProductAddons) {
      Dev.info(o.toMap());
    }
  }

  ProductFileUploadAddon? fileUploadAddonData;

  /// Save the product selected data in a class which takes in account
  /// the different variations
  ProductSelectedData? productSelectedData;

  Product.fromWooProduct(this.wooProduct) : id = wooProduct.id.toString() {
    _displayImage = '';
    _imagesNotifier.value = _createImageNotifierList(wooProduct.images);
    if (_imagesNotifier.value.isNotEmpty) {
      _displayImage = _imagesNotifier.value[0];
    }
    inStock = wooProduct.stockStatus == 'instock' || false;
    averageRating = wooProduct.averageRating;
    ratingCount.value = wooProduct.ratingCount ?? 0;

    // Call to create a selected data instance just after creating the product
    // model
    setSelectedProductData(this);
    setDefaultAttributes(wooProduct.defaultAttributes);
  }

  void updateRatingCount(int newValue) {
    ratingCount.value = newValue;
  }

  void toggleLikedStatus({bool? status}) {
    liked = status ?? !liked;
  }

  // sets the quantity
  set setQuantity(int value) {
    quantity = value;
  }

  /// Set the display image for the product instance
  void setDisplayImage(String value) {
    _displayImage = value;
  }

  /// Adds more images to the product image list
  /// Usually used to add product variation images.
  void addProductImages(List<String> values) {
    final Set<String> tempList = <String>{...values, ..._imagesNotifier.value};
    _imagesNotifier.value = tempList.toList();
  }

  /// Set the given product variation as the selected product variation
  /// in the product
  void setSelectedProductVariation(WooProductVariation? variation,
      {bool updateSelectedProductData = true}) {
    if (variation == null) {
      return;
    }
    _selectedVariation = variation;

    // Also add the images to the product images if the variation has any image
    if (variation.image != null && isNotBlank(variation.image!.src)) {
      addProductImages([variation.image!.src!]);
    }

    if (updateSelectedProductData) {
      setSelectedProductData(this);
    }
  }

  /// Set the data for the selected product in a class based on the
  /// variation chosen
  void setSelectedProductData(Product product) {
    productSelectedData = ProductSelectedData.fromProduct(product);
  }

  /// Copy the data with the new product data
  Product copyWith(Product product) {
    final p = Product(
      id: product.id,
      wooProduct: product.wooProduct,
      liked: product.liked,
    );

    if (product.selectedVariation != null) {
      p.setSelectedProductVariation(
        product.selectedVariation,
        updateSelectedProductData: false,
      );
    }

    p.productSelectedData = product.productSelectedData;

    p.quantity = product.quantity;

    p.selectedProductAddons = selectedProductAddons;

    return p;
  }

  /// Copy the data with the new product data
  Product copyWithWooProduct(WooProduct? wooProduct) {
    if (wooProduct == null) {
      return this;
    }
    final p = Product(
      id: wooProduct.id.toString(),
      wooProduct: wooProduct,
      liked: liked,
    );

    if (selectedVariation != null) {
      p.setSelectedProductVariation(
        selectedVariation,
        updateSelectedProductData: false,
      );
    }

    p.productSelectedData = productSelectedData;

    p.quantity = quantity;

    p.selectedProductAddons = selectedProductAddons;

    return p;
  }

  ValueNotifier<Map<String, dynamic>> selectedAttributesNotifier =
      ValueNotifier({});

  void updateSelectedAttributes(Map<String, dynamic> updatedMap) {
    selectedAttributesNotifier.value.addAll(updatedMap);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    selectedAttributesNotifier.notifyListeners();
  }

  void setDefaultAttributes(List<WooProductDefaultAttribute>? defAttr) {
    if (defAttr == null) {
      return;
    }
    for (final elem in defAttr) {
      if (isNotBlank(elem.name)) {
        selectedAttributesNotifier.value.addAll({elem.name!: elem.option});
      }
    }
  }

  /// Creates the key for the `selectedAttributes` of the product
  static String attributeKey(String value) {
    if (isBlank(value)) {
      return 'NA';
    }
    return value.toString().toLowerCase();
  }

  /// Creates the value for the `selectedAttributes` of the product
  static String attributeValue(String value) {
    if (isBlank(value)) {
      return 'NA';
    }
    return value.toString().toLowerCase();
  }

  RawWooStoreProCartItemData createAddItemRequestData() {
    return RawWooStoreProCartItemData(
      productId: wooProduct.id ?? 0,
      variationId: selectedVariation != null ? selectedVariation!.id : null,
      quantity: quantity,
      cartItemData: {
        if (selectedProductAddons.isNotEmpty)
          'addons': selectedProductAddons.map((e) => e.toMap()).toList(),
      },
      variationData: selectedAttributesNotifier.value.isNotEmpty
          ? selectedAttributesNotifier.value
          : {},
    );
  }

  //**********************************************************
  // Helper functions
  //**********************************************************

  List<String> _createImageNotifierList(List<WooProductImage>? images) {
    if (images == null || images.isEmpty) {
      return const [];
    }
    final tempList = <String>[];
    for (final WooProductImage imageObject in images) {
      if (isNotBlank(imageObject.src)) {
        tempList.add(imageObject.src!);
      }
    }
    return tempList;
  }

  /// check if the product is ready to be added to cart after performing
  /// all the validation required.
  ///
  /// Used especially to check if required product addons are selected or not
  List<Exception> isReadyForCartActions() {
    final List<Exception> exceptionList = [];
    if (wooProduct.productAddOns != null &&
        wooProduct.productAddOns!.isNotEmpty) {
      for (final addon in wooProduct.productAddOns!) {
        if (addon.required > 0) {
          if (addon.type == WooProductAddOnType.fileUpload) {
            // check if the file upload addon is added
            if (fileUploadAddonData == null) {
              exceptionList.add(Exception('${addon.name} is required'));
            }
          } else {
            // check if this addon is added to the product
            final ProductSelectedAddon? foundAddon =
                selectedProductAddons.firstWhereOrNull(
              (elem) {
                return elem.name == addon.name;
              },
            );
            if (foundAddon == null) {
              exceptionList.add(Exception('${addon.name} is required'));
            }
          }
        }
      }
    }

    return exceptionList;
  }
}

/// Holds the information about the selected choices of the product
/// variation
@immutable
class ProductSelectedData {
  final String? image;
  final String? price;
  final bool onSale;
  final Map<String, dynamic> selectedAttributes;

//<editor-fold desc="Data Methods" defaultState="collapsed">

  const ProductSelectedData({
    this.image,
    this.price,
    this.onSale = false,
    this.selectedAttributes = const {},
  });

  factory ProductSelectedData.fromMap(Map<String, dynamic> map) {
    return ProductSelectedData(
      image: ModelUtils.createStringProperty(map['image']),
      price: ModelUtils.createStringProperty(map['price']),
      onSale: ModelUtils.createBoolProperty(map['onSale']),
      selectedAttributes: ModelUtils.createMapOfType<String, dynamic>(
        map['selectedAttributes'],
      ),
    );
  }

  factory ProductSelectedData.fromProduct(Product product) {
    late String? image;
    late String? price;
    bool onSale = false;
    Map<String, dynamic> selectedAttributes = {};

    final variation = product.selectedVariation;

    if (variation != null) {
      // Set the image
      if (variation.image != null && isNotBlank(variation.image!.src)) {
        image = variation.image!.src!;
      }

      // Set the price
      price = (variation.onSale ?? false)
          ? variation.salePrice
          : variation.regularPrice;
      onSale = variation.onSale ?? false;
    } else {
      try {
        image = product.imageList.first;
      } catch (e) {
        image = null;
      }
      price = product.wooProduct.onSale == true
          ? product.wooProduct.salePrice
          : product.wooProduct.regularPrice;
      onSale = product.wooProduct.onSale ?? false;
      selectedAttributes = product.selectedAttributesNotifier.value;
    }

    return ProductSelectedData(
      image: image,
      price: price,
      onSale: onSale,
      selectedAttributes: selectedAttributes,
    );
  }

  ProductSelectedData copyWith({
    String? image,
    String? price,
    bool? onSale,
    Map<String, dynamic>? selectedAttributes,
  }) {
    if ((image == null || identical(image, this.image)) &&
        (price == null || identical(price, this.price)) &&
        (onSale == null || identical(onSale, this.onSale)) &&
        (selectedAttributes == null ||
            identical(selectedAttributes, this.selectedAttributes))) {
      return this;
    }

    return ProductSelectedData(
      image: image ?? this.image,
      price: price ?? this.price,
      onSale: onSale ?? this.onSale,
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
    );
  }

  @override
  String toString() {
    return 'ProductSelectedData{image: $image, price: $price, selectedAttributes: $selectedAttributes, onSale: $onSale}';
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'image': image,
      'price': price,
      'onSale': onSale,
      'selectedAttributes': selectedAttributes,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

/// Class specifically for the image upload add on as the image
/// needs to be uploaded only when the user adds the product to cart
class ProductFileUploadAddon extends ProductSelectedAddon {
  final File file;

  const ProductFileUploadAddon({
    required this.file,
    required super.name,
    super.value = '',
    required super.price,
    required super.priceType,
    super.fieldType = WooProductAddOnType.fileUpload,
  });

  String getFileSizeDisplay({required File file, int decimals = 1}) {
    final int bytes = file.lengthSync();
    if (bytes <= 0) {
      return '0 B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  ProductFileUploadAddon copyWithValue({
    String? value,
  }) {
    return ProductFileUploadAddon(
      file: file,
      name: name,
      price: price,
      priceType: priceType,
      fieldType: fieldType,
      value: value ?? this.value,
    );
  }
}

class ProductSelectedAddon {
  final String name, value, price;
  final WooProductAddOnPriceType priceType;
  final WooProductAddOnType fieldType;

  const ProductSelectedAddon({
    required this.name,
    required this.value,
    required this.price,
    required this.fieldType,
    required this.priceType,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
      if (Uri.parse(value).host.isNotEmpty) 'display': value.split('/').last,
      'price': price,
      'field_type': WooProductAddOn.getFieldTypeString(fieldType),
      'price_type': WooProductAddOn.getPriceTypeString(priceType),
    };
  }

  factory ProductSelectedAddon.fromMap(Map<String, dynamic> map) {
    return ProductSelectedAddon(
      name: ModelUtils.createStringProperty(map['name']),
      value: ModelUtils.createStringProperty(map['value']),
      price: ModelUtils.createStringProperty(map['price']),
      fieldType: WooProductAddOn.createType(map['field_type']),
      priceType: WooProductAddOn.createPriceType(map['price_type']),
    );
  }

  String renderNameWithPrice({required String currency}) {
    String result = name;

    if (priceType == WooProductAddOnPriceType.flatFee ||
        priceType == WooProductAddOnPriceType.quantityBased) {
      result = name + ' ( +$currency$price )';
    }

    if (priceType == WooProductAddOnPriceType.percentageBased) {
      result = name + ' ( +$price% )';
    }

    return result;
  }
}

// /// Product Attribute which holds information about the sizes for the products
// @immutable
// class SizeProductAttribute {
//   final List<String> sizeList;
//   final String defaultSize;
//   final String selectedSize;
//
//   const SizeProductAttribute({
//     required this.sizeList,
//     required this.defaultSize,
//     required this.selectedSize,
//   });
//
//   const SizeProductAttribute.empty({
//     this.sizeList = const [],
//     this.defaultSize = '',
//     this.selectedSize = '',
//   });
//
//   factory SizeProductAttribute.fromMap(Map<String, dynamic> map) {
//     return SizeProductAttribute(
//       sizeList: map['sizeList'] as List<String> ?? [],
//       defaultSize: map['defaultSize'] as String ?? '',
//       selectedSize: map['selectedSize'] as String ?? '',
//     );
//   }
//
//   factory SizeProductAttribute.fromWooProductItemAttributes(
//     List<WooProductItemAttribute> attributes,
//     List<WooProductDefaultAttribute> defaultAttributes,
//   ) {
//     try {
//       // create size attribute
//       final sizeAttr = attributes.firstWhere(
//         (element) => element != null && element.name.toLowerCase() == 'size',
//         orElse: () => null,
//       );
//
//       // Find the default size attribute
//       final defaultSizeAttr = defaultAttributes.firstWhere(
//         (element) => element != null && element.name.toLowerCase() == 'size',
//         orElse: () => null,
//       );
//
//       if (sizeAttr == null) {
//         return const SizeProductAttribute.empty();
//       }
//
//       if (sizeAttr.options == null || sizeAttr.options.isEmpty) {
//         return const SizeProductAttribute.empty();
//       }
//
//       return SizeProductAttribute(
//         sizeList: sizeAttr.options,
//         defaultSize: defaultSizeAttr != null
//             ? defaultSizeAttr.option
//             : sizeAttr.options[0],
//         selectedSize: defaultSizeAttr != null
//             ? defaultSizeAttr.option
//             : sizeAttr.options[0],
//       );
//     } catch (e) {
//       Dev.error('', error: e);
//       return const SizeProductAttribute.empty();
//     }
//   }
//
//   factory SizeProductAttribute.fromWooProductVariationAttribute(
//     List<WooProductVariationAttribute> attributes,
//   ) {
//     try {
//       // create size attribute
//       final sizeAttr = attributes.firstWhere(
//         (element) => element != null && element.name.toLowerCase() == 'size',
//         orElse: () => null,
//       );
//
//       if (sizeAttr == null) {
//         return const SizeProductAttribute.empty();
//       }
//
//       if (sizeAttr.option == null || sizeAttr.option.isEmpty) {
//         return const SizeProductAttribute.empty();
//       }
//
//       return SizeProductAttribute(
//         sizeList: const [],
//         defaultSize: sizeAttr.option,
//         selectedSize: sizeAttr.option,
//       );
//     } catch (e) {
//       Dev.error('', error: e);
//       return const SizeProductAttribute.empty();
//     }
//   }
//
//   SizeProductAttribute copyWith({
//     List<String> sizeList,
//     String defaultSize,
//     String selectedSize,
//   }) {
//     if ((sizeList == null || identical(sizeList, this.sizeList)) &&
//         (defaultSize == null || identical(defaultSize, this.defaultSize)) &&
//         (selectedSize == null || identical(selectedSize, this.selectedSize))) {
//       return this;
//     }
//
//     return SizeProductAttribute(
//       sizeList: sizeList ?? this.sizeList,
//       defaultSize: defaultSize ?? this.defaultSize,
//       selectedSize: selectedSize ?? this.selectedSize,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_cast
//     return {
//       'sizeList': sizeList,
//       'defaultSize': defaultSize,
//       'selectedSize': selectedSize,
//     } as Map<String, dynamic>;
//   }
// }
//
// /// Product Attribute which holds information about the color for the products
// @immutable
// class ColorProductAttribute {
//   final List<Color> colorList;
//   final Color defaultColor;
//   final Color selectedColor;
//
//   const ColorProductAttribute({
//     required this.colorList,
//     required this.defaultColor,
//     required this.selectedColor,
//   });
//
//   const ColorProductAttribute.empty({
//     this.colorList = const [],
//     this.defaultColor,
//     this.selectedColor,
//   });
//
//   factory ColorProductAttribute.fromMap(Map<String, dynamic> map) {
//     return ColorProductAttribute(
//       colorList: map['colorList'] as List<Color> ?? [],
//       defaultColor: map['defaultColor'] as Color,
//       selectedColor: map['selectedColor'] as Color,
//     );
//   }
//
//   factory ColorProductAttribute.fromWooProductItemAttributes(
//     List<WooProductItemAttribute> attributes,
//     List<WooProductDefaultAttribute> defaultAttributes,
//   ) {
//     try {
//       final colorAttr = attributes.firstWhere(
//         (element) =>
//             element != null && element.name.toLowerCase() == 'color' ||
//             element.name.toLowerCase() == 'colour',
//         orElse: () => null,
//       );
//
//       // Find the default size attribute
//       final defaultColorAttr = defaultAttributes.firstWhere(
//         (element) =>
//             element != null && element.name.toLowerCase() == 'color' ||
//             element.name.toLowerCase() == 'colour',
//         orElse: () => null,
//       );
//
//       if (colorAttr == null) {
//         return const ColorProductAttribute.empty();
//       }
//
//       if (colorAttr.options == null || colorAttr.options.isEmpty) {
//         return const ColorProductAttribute.empty();
//       }
//
//       final _colorList = _getColorList(colorAttr.options);
//       Color _defaultColor;
//
//       if (defaultColorAttr != null) {
//         _defaultColor = HexColor(colorNameToHex[
//             defaultColorAttr.option.toLowerCase().replaceAll(' ', '')]);
//       } else {
//         _defaultColor = _colorList[0];
//       }
//
//       return ColorProductAttribute(
//         colorList: _colorList,
//         defaultColor: _defaultColor,
//         selectedColor: _defaultColor,
//       );
//     } catch (e) {
//       Dev.error('', error: e);
//       return const ColorProductAttribute.empty();
//     }
//   }
//
//   factory ColorProductAttribute.fromWooProductVariationAttribute(
//     List<WooProductVariationAttribute> attributes,
//   ) {
//     try {
//       final colorAttr = attributes.firstWhere(
//         (element) =>
//             element != null && element.name.toLowerCase() == 'color' ||
//             element.name.toLowerCase() == 'colour',
//         orElse: () => null,
//       );
//
//       if (colorAttr == null) {
//         return const ColorProductAttribute.empty();
//       }
//
//       if (colorAttr.option == null || colorAttr.option.isEmpty) {
//         return const ColorProductAttribute.empty();
//       }
//
//       final Color _defaultColor = HexColor(
//           colorNameToHex[colorAttr.option.toLowerCase().replaceAll(' ', '')]);
//
//       return ColorProductAttribute(
//         colorList: const [],
//         defaultColor: _defaultColor,
//         selectedColor: _defaultColor,
//       );
//     } catch (e) {
//       Dev.error('', error: e);
//       return const ColorProductAttribute.empty();
//     }
//   }
//
//   ColorProductAttribute copyWith({
//     List<Color> colorList,
//     Color defaultColor,
//     Color selectedColor,
//   }) {
//     if ((colorList == null || identical(colorList, this.colorList)) &&
//         (defaultColor == null || identical(defaultColor, this.defaultColor)) &&
//         (selectedColor == null ||
//             identical(selectedColor, this.selectedColor))) {
//       return this;
//     }
//
//     return ColorProductAttribute(
//       colorList: colorList ?? this.colorList,
//       defaultColor: defaultColor ?? this.defaultColor,
//       selectedColor: selectedColor ?? this.selectedColor,
//     );
//   }
//
//   static List<Color> _getColorList(List<String> iterable) {
//     final List<Color> tempList = [];
//     for (final item in iterable) {
//       final String hexString =
//           colorNameToHex[item.toLowerCase().replaceAll(' ', '')];
//
//       if (hexString == null) {
//         continue;
//       }
//
//       final Color c = HexColor(hexString);
//       tempList.add(c);
//     }
//     return tempList;
//   }
//
//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_cast
//     return {
//       'colorList': colorList.cast<String>(),
//       'defaultColor': defaultColor.toString(),
//       'selectedColor': selectedColor.toString(),
//     } as Map<String, dynamic>;
//   }
// }
