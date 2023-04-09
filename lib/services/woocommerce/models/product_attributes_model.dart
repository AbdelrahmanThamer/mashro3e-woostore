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

part of 'models.dart';

enum WooStoreProductAttributeType {
  color,
  image,
  select,
}

/// Holds information about the product attributes from WooStore Pro Api
/// wordpress plugin v2.1.0
class WooStoreProductAttribute {
  final WooStoreProductAttributeTermLinks? links;
  final int? id;
  final String? name;
  final String? slug;
  final WooStoreProductAttributeType type;
  final List<WooStoreProductAttributeTerm>? terms;

  const WooStoreProductAttribute({
    this.links,
    this.id = 0,
    this.name,
    this.slug,
    this.type = WooStoreProductAttributeType.select,
    this.terms,
  });

  factory WooStoreProductAttribute.fromJson(Map<String, dynamic> json) {
    return WooStoreProductAttribute(
      links: json['_links'] != null
          ? WooStoreProductAttributeTermLinks.fromJson(json['_links'])
          : null,
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'],
      slug: json['slug'],
      type: _getAttributeType(json['type']),
      terms: json['woostore_terms'] != null
          ? (json['woostore_terms'] as List)
              .map((i) => WooStoreProductAttributeTerm.fromJson(i))
              .toList()
          : null,
    );
  }

  static WooStoreProductAttributeType _getAttributeType(String value) {
    switch (value) {
      case 'color':
        return WooStoreProductAttributeType.color;
      case 'image':
        return WooStoreProductAttributeType.image;
      default:
        return WooStoreProductAttributeType.select;
    }
  }
}

class WooStoreProductAttributeTerm {
  final String? count;
  final String? description;
  final String? name;
  final String? parent;
  final String? slug;
  final String? taxonomy;
  final String? termGroup;
  final int? termId;
  final String? termTaxonomyId;
  final String? value;

  const WooStoreProductAttributeTerm({
    this.count,
    this.description,
    this.name,
    this.parent,
    this.slug,
    this.taxonomy,
    this.termGroup,
    this.termId,
    this.termTaxonomyId,
    this.value,
  });

  factory WooStoreProductAttributeTerm.fromJson(Map<String, dynamic> json) {
    return WooStoreProductAttributeTerm(
      count: json['count']?.toString() ?? '0',
      description: json['description'],
      name: json['name'],
      parent: json['parent']?.toString() ?? '0',
      slug: json['slug'],
      taxonomy: json['taxonomy'],
      termGroup: json['term_group']?.toString() ?? '0',
      termId: int.parse(json['term_id']?.toString() ?? '0'),
      termTaxonomyId: json['term_taxonomy_id']?.toString() ?? '0',
      value: json['value'],
    );
  }
}

class WooStoreProductAttributeTermLinks {
  List<WooStoreProductAttributeTermCollection>? collection;
  List<WooStoreProductAttributeTermSelf>? self;

  WooStoreProductAttributeTermLinks({this.collection, this.self});

  factory WooStoreProductAttributeTermLinks.fromJson(
      Map<String, dynamic> json) {
    return WooStoreProductAttributeTermLinks(
      collection: json['collection'] != null
          ? (json['collection'] as List)
              .map((i) => WooStoreProductAttributeTermCollection.fromJson(i))
              .toList()
          : null,
      self: json['self'] != null
          ? (json['self'] as List)
              .map((i) => WooStoreProductAttributeTermSelf.fromJson(i))
              .toList()
          : null,
    );
  }
}

class WooStoreProductAttributeTermSelf {
  final String? href;

  const WooStoreProductAttributeTermSelf({this.href});

  factory WooStoreProductAttributeTermSelf.fromJson(Map<String, dynamic> json) {
    return WooStoreProductAttributeTermSelf(
      href: json['href'],
    );
  }
}

class WooStoreProductAttributeTermCollection {
  final String? href;

  const WooStoreProductAttributeTermCollection({this.href});

  factory WooStoreProductAttributeTermCollection.fromJson(
      Map<String, dynamic> json) {
    return WooStoreProductAttributeTermCollection(
      href: json['href'],
    );
  }
}
