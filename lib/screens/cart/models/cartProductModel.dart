// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:collection/collection.dart';
import 'package:quiver/strings.dart';

import '../../../models/productModel.dart';
import '../../../services/woocommerce/woocommerce.service.dart';

class CartProduct {
  CartProduct({
    required this.id,
    required this.product,
    required this.productId,
    this.cartItemKey,
    this.variationId,
    this.price,
    this.name,
    this.quantity = 1,
    this.isVariable = false,
    this.displayImage,
    this.attributes,
    this.productAddons,
  });

  /// If variation id is greater than 0, it means that this is a
  /// variable product and the variation must be the main product
  /// hence the unique [id] should be the variation id. If variation id
  /// is less than or equal to 0 then the product is simple and
  /// only the product id must be the unique [id] of this data class
  String id;

  /// Used to update the cart in the backend
  String? cartItemKey;

  /// The associated product
  String productId;

  /// The associated product variation
  String? variationId;

  String? name, price, displayImage;
  int quantity = 1;
  Product product;

  /// The selected attributes of the product
  Map<String, dynamic>? attributes;

  /// Map for all the selected product addons
  /// where the key is the name of the product add on
  List<ProductSelectedAddon>? productAddons;

  bool isVariable;

  // sets the quantity
  set setQuantity(int value) {
    if (value <= 0) {
      quantity = 1;
      return;
    }
    quantity = value;
  }

  // sets the color
  // set setColor(Color value) {
  //   color = value;
  // }

  /// Increase the quantity of the product by 1
  bool increaseQuantity() {
    if (product.wooProduct.soldIndividually ?? false) {
      return false;
    }
    quantity++;
    return true;
  }

  /// Decrease the quantity of the product by 1
  bool decreaseQuantity() {
    if (quantity == 1) {
      return false;
    }
    quantity--;
    return true;
  }

  factory CartProduct.fromProduct(Product p) {
    String id = p.id.toString();

    // Here check if the product is simple or variable product
    final bool isVariableProduct = p.selectedVariation != null;

    // if the product is variable then change the cartProduct id to
    // the variation id
    if (isVariableProduct) {
      if (p.selectedVariation!.id != null &&
          p.selectedVariation!.id.toString().isNotEmpty) {
        id = p.selectedVariation!.id.toString();
      }
    }

    String? _price = p.wooProduct.price;

    if (isNotBlank(p.productSelectedData?.price)) {
      _price = p.productSelectedData!.price!;
    }
    final _attr =
        Map.from(p.selectedAttributesNotifier.value).cast<String, dynamic>();
    final product = CartProduct(
      id: id,
      productId: p.id.toString(),
      variationId: p.selectedVariation != null
          ? p.selectedVariation!.id.toString()
          : null,
      isVariable: isVariableProduct,
      product: p,
      name: p.wooProduct.name,
      price: _price,
      displayImage: p.productSelectedData?.image,
      quantity: p.quantity,
      attributes: _attr,
      productAddons: List.from(p.selectedProductAddons),
    );

    return product;
  }

  /// Used only to update product image in the cart item.
  void updateDisplayImage(
      {WooProductVariation? newVariation, Product? newProduct}) {
    String? _displayImage;

    // Updates the product and display image with the newProduct
    if (newProduct != null) {
      product = newProduct;
      _displayImage = newProduct.displayImage;
    }

    // Updates the variation in product and display image with variation
    // if not already present
    if (newVariation != null) {
      // Update the variation in the product if not already present
      final WooProductVariation? _isVariationPresent =
          product.variations.firstWhereOrNull((v) => v.id == newVariation.id);
      if (_isVariationPresent == null) {
        product.variations.add(newVariation);
      }
      if (newVariation.image != null && isNotBlank(newVariation.image!.src)) {
        _displayImage = newVariation.image!.src;
      }
    }

    displayImage = _displayImage;
  }

  factory CartProduct.fromWooStoreProCartItemData({
    required WooStoreProCartItemData cartItem,
    Product? ref,
  }) {
    final Product newProduct = ref ?? Product.fromWooProduct(cartItem.product);

    // if the ref product was empty, then add cart product was created using
    // the cartItemData. So add the product add ons to the cart product and
    // normal product
    List<ProductSelectedAddon> _productAddons = [];
    if (cartItem.addOns != null && cartItem.addOns!.isNotEmpty) {
      // ref is null so new product was created, therefore add the
      // product add ons from cartItem to the new product
      if (cartItem.addOns != null && cartItem.addOns!.isNotEmpty) {
        for (final addOn in cartItem.addOns!) {
          _productAddons.add(ProductSelectedAddon.fromMap(addOn.toMap()));
        }
      }
    } else {
      if (ref != null && ref.selectedProductAddons.isNotEmpty) {
        _productAddons = ref.selectedProductAddons;
      }
    }

    String _id = cartItem.product.id.toString();
    // if the product is variable then change the cartProduct id to
    // the variation id
    if (cartItem.variation != null) {
      _id = cartItem.variation!.id.toString();
    }
    final String _productId = cartItem.product.id.toString();
    final String? _variationId = cartItem.variation?.id.toString();
    final bool _isVariable = cartItem.variation != null;
    final Product _product = newProduct;
    final String? _name = cartItem.product.name;
    final String? _price = cartItem.variation != null
        ? cartItem.variation!.price
        : cartItem.product.price;
    String? _displayImage = newProduct.displayImage;
    if (cartItem.variation != null &&
        isNotBlank(cartItem.variation!.image?.src)) {
      _displayImage = cartItem.variation!.image!.src;
    }

    final int _quantity = cartItem.quantity;

    final _tempAttr = ref?.selectedAttributesNotifier.value ?? {};
    if (cartItem.variation != null &&
        (cartItem.variation!.attributes?.isNotEmpty ?? false)) {
      for (final element in cartItem.variation!.attributes!) {
        _tempAttr.addAll({element.name: element.option});
      }
    }

    String? _cartItemKey = cartItem.cartItemKey;
    if (isBlank(cartItem.cartItemKey)) {
      _cartItemKey = _generateCartItemKey(
        id: _id,
        attributes: _tempAttr,
        productAddons: _productAddons,
      );
    }

    return CartProduct(
      id: _id,
      cartItemKey: _cartItemKey,
      product: _product,
      productId: _productId,
      variationId: _variationId,
      isVariable: _isVariable,
      name: _name,
      price: _price,
      displayImage: _displayImage,
      quantity: _quantity,
      attributes: _tempAttr,
      productAddons: _productAddons,
    );
  }

  @override
  String toString() {
    return 'CartProduct{cartItemKey: $cartItemKey, id: $id, productId: $productId, variationId: $variationId, price: $price, attributes: $attributes}';
  }

  RawWooStoreProCartItemData createRawWooStoreProCartItemData() {
    return RawWooStoreProCartItemData(
      cartItemKey: cartItemKey,
      productId: int.parse(productId),
      quantity: quantity,
      variationId: int.tryParse(variationId ?? '0'),
      variationData: attributes,
      cartItemData: {
        'addons': productAddons?.map((e) => e.toMap()).toList(),
      },
    );
  }

  String generateCartItemKey() {
    return _generateCartItemKey(
      id: id,
      attributes: attributes,
      productAddons: productAddons,
    );
  }

  static String _generateCartItemKey({
    required String id,
    Map<String, dynamic>? attributes,
    List<ProductSelectedAddon>? productAddons,
  }) {
    String result = id;
    if (attributes?.isNotEmpty ?? false) {
      // add the attributes to the item key
      attributes?.forEach((key, value) => result += '-$value');
    }
    if (productAddons != null && productAddons.isNotEmpty) {
      // add the addons to id as well
      for (final addon in productAddons) {
        result += '-${addon.value}';
      }
    }
    return result;
  }

  void updateCartItemKey(String key) {
    cartItemKey = key;
  }
}
