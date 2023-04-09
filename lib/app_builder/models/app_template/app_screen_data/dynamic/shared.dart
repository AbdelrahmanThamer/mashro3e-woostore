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
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Object to hold the data which is used with the sections
@immutable
class DataObject extends Equatable {
  final TagData? tag;
  final CategoryData? category;
  final ProductData? product;
  final String? externalLink;

  const DataObject({
    this.tag,
    this.category,
    this.product,
    this.externalLink,
  });

  @override
  List<Object?> get props => [tag, category, product, externalLink];

  DataObject copyWith({
    TagData? tag,
    CategoryData? category,
    ProductData? product,
    String? externalLink,
  }) {
    return DataObject(
      tag: tag ?? this.tag,
      category: category ?? this.category,
      product: product ?? this.product,
      externalLink: externalLink ?? this.externalLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tag': tag?.toMap(),
      'category': category?.toMap(),
      'product': product?.toMap(),
      'externalLink': externalLink,
    };
  }

  factory DataObject.fromMap(Map<String, dynamic> map) {
    return DataObject(
      tag: TagData.fromMap(map['tag']),
      category: CategoryData.fromMap(map['category']),
      product: ProductData.fromMap(map['product']),
      externalLink: ModelUtils.createStringProperty(map['externalLink']),
    );
  }
}

@immutable
class TagData extends Equatable {
  final int id;
  final String title;
  final String tagId;

  const TagData({
    this.id = 0,
    this.title = '',
    this.tagId = '',
  });

  const TagData.empty({
    this.id = 0,
    this.title = '',
    this.tagId = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tagId': tagId,
    };
  }

  factory TagData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const TagData.empty();
    }
    return TagData(
      id: ModelUtils.createIntProperty(map['id']),
      title: ModelUtils.createStringProperty(map['title']),
      tagId: ModelUtils.createStringProperty(map['tagId']),
    );
  }

  TagData copyWith({
    int? id,
    String? title,
    String? tagId,
  }) {
    return TagData(
      id: id ?? this.id,
      title: title ?? this.title,
      tagId: tagId ?? this.tagId,
    );
  }

  @override
  String toString() {
    return 'TagData{id: $id, title: $title, tagId: $tagId}';
  }

  @override
  List<Object?> get props => [id, title, tagId];
}

@immutable
class CategoryData extends Equatable {
  final int id;
  final String title;
  final String categoryId;
  final String imageUrl;

  const CategoryData({
    this.id = 0,
    this.title = '',
    this.categoryId = '',
    this.imageUrl = '',
  });

  const CategoryData.empty({
    this.id = 0,
    this.title = '',
    this.categoryId = '',
    this.imageUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const CategoryData.empty();
    }
    return CategoryData(
      id: ModelUtils.createIntProperty(map['id']),
      title: StringUtils.htmlUnescape(
        ModelUtils.createStringProperty(map['title']),
      ),
      categoryId: ModelUtils.createStringProperty(map['categoryId']),
      imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
    );
  }

  CategoryData copyWith({
    int? id,
    String? title,
    String? categoryId,
    String? imageUrl,
  }) {
    return CategoryData(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'CategoryData{id: $id, title: $title, categoryId: $categoryId, imageUrl: $imageUrl}';
  }

  @override
  List<Object?> get props => [id, title, categoryId, imageUrl];
}

@immutable
class ProductData extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const ProductData({
    this.id = '',
    this.name = '',
    this.imageUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory ProductData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const ProductData();
    }
    return ProductData(
      id: ModelUtils.createStringProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      imageUrl: ModelUtils.createStringProperty(map['imageUrl']),
    );
  }

  @override
  String toString() {
    return 'ProductData{id: $id, name: $name, imageUrl: $imageUrl}';
  }

  @override
  List<Object?> get props => [id, name, imageUrl];
}

@immutable
class VendorData extends Equatable {
  final int id;
  final String name;
  final String banner;
  final String logo;

  const VendorData({
    this.id = 0,
    this.name = '',
    this.banner = '',
    this.logo = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': banner,
      'logo': logo,
    };
  }

  factory VendorData.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const VendorData();
    }
    return VendorData(
      id: ModelUtils.createIntProperty(map['id']),
      name: ModelUtils.createStringProperty(map['name']),
      banner: ModelUtils.createStringProperty(map['banner']),
      logo: ModelUtils.createStringProperty(map['logo']),
    );
  }

  @override
  String toString() {
    return 'VendorData{id: $id, name: $name, banner: $banner, logo: $logo}';
  }

  @override
  List<Object?> get props => [id, name, banner, logo];
}

/// Load products based on the following configuration
@immutable
class LoadProductsConfigData {
  final TagData tag;
  final CategoryData category;
  final bool featured;
  final bool onSale;
  final String minPrice;
  final String maxPrice;
  final LoadProductType type;
  final List<ProductData> include;

  const LoadProductsConfigData({
    this.tag = const TagData(),
    this.category = const CategoryData(),
    this.featured = false,
    this.onSale = false,
    this.minPrice = '',
    this.maxPrice = '',
    this.type = LoadProductType.any,
    this.include = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'tag': tag.toMap(),
      'category': category.toMap(),
      'featured': featured,
      'onSale': onSale,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'type': type.name,
      'include': include.isNotEmpty
          ? include.map((e) => e.toMap()).toList()
          : const [],
    };
  }

  factory LoadProductsConfigData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const LoadProductsConfigData();
    }

    return LoadProductsConfigData(
      tag: TagData.fromMap(map['tag']),
      category: CategoryData.fromMap(map['category']),
      featured: ModelUtils.createBoolProperty(map['featured']),
      onSale: ModelUtils.createBoolProperty(map['onSale']),
      minPrice: ModelUtils.createStringProperty(map['minPrice']),
      maxPrice: ModelUtils.createStringProperty(map['maxPrice']),
      type: _getType(map['type']),
      include: ModelUtils.createListOfType(
        map['include'],
        (elem) => ProductData.fromMap(elem),
      ),
    );
  }

  LoadProductsConfigData copyWith({
    TagData? tag,
    CategoryData? category,
    bool? featured,
    bool? onSale,
    String? minPrice,
    String? maxPrice,
    LoadProductType? type,
    List<ProductData>? include,
  }) {
    return LoadProductsConfigData(
      tag: tag ?? this.tag,
      category: category ?? this.category,
      featured: featured ?? this.featured,
      onSale: onSale ?? this.onSale,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      type: type ?? this.type,
      include: include ?? this.include,
    );
  }

  //**********************************************************
  // Helper Method
  //**********************************************************

  static LoadProductType _getType(String? name) {
    switch (name) {
      case 'simple':
        return LoadProductType.simple;
      case 'variable':
        return LoadProductType.variable;
      case 'external':
        return LoadProductType.external;
      case 'grouped':
        return LoadProductType.grouped;
      default:
        return LoadProductType.any;
    }
  }
}

enum LoadProductType {
  simple,
  grouped,
  external,
  variable,
  any,
}
