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

// @dart=2.9

import '../developer/dev.log.dart';

///
/// ## `Description`
///
/// Category model class which holds the information about the
/// type of products offered by the application.
///
class Category {
  String id;
  String sku;
  String name;
  String image;
  String parent;
  int totalProduct;

  Category.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson['slug'] == 'uncategorized') {
      return;
    }

    try {
      id = parsedJson['id'].toString();
      name = parsedJson['name'];
      parent = parsedJson['parent'].toString();
      totalProduct = parsedJson['count'];

      final image = parsedJson['image'];
      if (image != null) {
        this.image = image['src'].toString();
      }
    } catch (e, trace) {
      Dev.info(e.toString());
      Dev.info(trace.toString());
    }
  }

  Category.fromOpencartJson(Map<String, dynamic> parsedJson) {
    try {
      id = parsedJson['id'] ?? '0';
      name = parsedJson['name'];
      image = parsedJson['image'];
      totalProduct = parsedJson['count'] != null
          ? int.parse(parsedJson['count'].toString())
          : 0;
      parent =
          parsedJson['parent'] != null ? parsedJson['parent'].toString() : '0';
    } catch (e, trace) {
      Dev.info(e.toString());
      Dev.info(trace.toString());
    }
  }

  Category.fromMagentoJson(Map<String, dynamic> parsedJson) {
    try {
      id = '${parsedJson['id']}';
      name = parsedJson['name'];
      image = parsedJson['image'];
      parent = '${parsedJson['parent_id']}';
      totalProduct = parsedJson['product_count'];
    } catch (e, trace) {
      Dev.info(e.toString());
      Dev.info(trace.toString());
    }
  }

  Category.fromJsonShopify(Map<String, dynamic> parsedJson) {
    Dev.info('fromJsonShopify id $parsedJson');

    if (parsedJson['slug'] == 'uncategorized') {
      return;
    }

    try {
      id = parsedJson['id'];
      sku = parsedJson['id'];
      name = parsedJson['title'];
      parent = '0';

      final image = parsedJson['image'];
      if (image != null) {
        this.image = image['src'].toString();
      }
    } catch (e, trace) {
      Dev.info(e.toString());
      Dev.info(trace.toString());
    }
  }

  Category.fromJsonPresta(Map<String, dynamic> parsedJson, apiLink) {
    try {
      id = parsedJson['id'].toString();
      name = parsedJson['name'];
      parent = parsedJson['id_parent'];
      image = apiLink('images/categories/$id');
      totalProduct = parsedJson['nb_products_recursive'] != null
          ? int.parse(parsedJson['nb_products_recursive'].toString())
          : null;
    } catch (e, trace) {
      Dev.info(e.toString());
      Dev.info(trace.toString());
    }
  }

  @override
  String toString() => 'Category { id: $id  name: $name}';
}
