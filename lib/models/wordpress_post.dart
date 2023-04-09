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
import 'package:quiver/strings.dart';

class WordpressPost {
  final int id;
  final String? date;
  final String title;
  final String slug;
  final String link;
  final String content;
  final String? displayImage;
  final String? author;
  final List<WordpressPostCategory> categories;
  final List<WordpressPostTag> tags;

  const WordpressPost({
    required this.id,
    this.date,
    required this.title,
    required this.slug,
    required this.link,
    required this.content,
    this.displayImage,
    this.author,
    this.categories = const [],
    this.tags = const [],
  });

  factory WordpressPost.fromMap(Map<String, dynamic> map) {
    return WordpressPost(
      id: ModelUtils.createIntProperty(map['id'], 0),
      date: ModelUtils.createStringProperty(map['date']),
      title: ModelUtils.createStringProperty(map['title']),
      slug: ModelUtils.createStringProperty(map['slug']),
      link: ModelUtils.createStringProperty(map['link']),
      content: ModelUtils.createStringProperty(map['content']),
      displayImage: _createImage(map['display_image']),
      author: ModelUtils.createStringProperty(map['author']),
      categories: ModelUtils.createListOfType(
        map['categories'],
        (elem) => WordpressPostCategory.fromMap(elem),
      ),
      tags: ModelUtils.createListOfType(
        map['tags'],
        (elem) => WordpressPostTag.fromMap(elem),
      ),
    );
  }

  static String _createImage(dynamic value) {
    final result = ModelUtils.createStringProperty(value);
    if (isNotBlank(result) &&
        (result.contains('http') || result.contains('https'))) {
      return result;
    }
    return '';
  }
}

class WordpressPostCategory {
  final int id;
  final String? name;
  final String? slug;
  final int count;
  final int parent;

  const WordpressPostCategory({
    required this.id,
    this.name,
    this.slug,
    this.count = 0,
    this.parent = 0,
  });

  factory WordpressPostCategory.fromMap(Map<String, dynamic> map) {
    return WordpressPostCategory(
      id: ModelUtils.createIntProperty(map['id'], 0),
      name: ModelUtils.createStringProperty(map['name']),
      slug: ModelUtils.createStringProperty(map['slug']),
      count: ModelUtils.createIntProperty(map['count'], 0),
      parent: ModelUtils.createIntProperty(map['parent'], 0),
    );
  }
}

class WordpressPostTag {
  final int id;
  final String? name;
  final String? slug;
  final int count;
  final int parent;

  const WordpressPostTag({
    required this.id,
    this.name,
    this.slug,
    this.count = 0,
    this.parent = 0,
  });

  factory WordpressPostTag.fromMap(Map<String, dynamic> map) {
    return WordpressPostTag(
      id: ModelUtils.createIntProperty(map['id'], 0),
      name: ModelUtils.createStringProperty(map['name']),
      slug: ModelUtils.createStringProperty(map['slug']),
      count: ModelUtils.createIntProperty(map['count'], 0),
      parent: ModelUtils.createIntProperty(map['parent'], 0),
    );
  }
}
