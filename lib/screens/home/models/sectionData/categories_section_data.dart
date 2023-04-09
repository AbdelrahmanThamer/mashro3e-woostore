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

// @dart=2.9

part of '../customSectionData.dart';

class CategoriesSectionData extends CustomSectionData {
  final SectionLayout layout;
  final double borderRadius;
  final int columns;
  final double height;
  final List<WooProductCategory> categories;
  final List<WooProductCategory> fullResponseCategories;

  const CategoriesSectionData({
    @required this.layout,
    @required bool show,
    @required SectionType sectionType,
    this.borderRadius,
    this.columns = 3,
    this.height = 100,
    this.categories,
    this.fullResponseCategories,
  }) : super(
          show: show,
          sectionType: sectionType,
        );

  const CategoriesSectionData.empty({
    this.layout,
    this.borderRadius,
    this.columns,
    this.height,
    this.categories = const [],
    this.fullResponseCategories = const [],
  }) : super(
          show: false,
          sectionType: SectionType.categoriesSection,
        );

  factory CategoriesSectionData.fromMap(Map<String, dynamic> map) {
    try {
      // Flag to show this section
      final bool _show = map['show'] ?? true;

      // The actual data from of the section type
      final Map<String, dynamic> categoriesSectionData =
          map['categories_section_data'];

      if (categoriesSectionData == null) {
        Dev.info('categoriesSectionData is null, returning empty object');
        return const CategoriesSectionData.empty();
      }

      // The layout of the section
      final SectionLayout _layout = HomeUtils.convertStringToSectionLayout(
          categoriesSectionData['layout']);

      final double _borderRadius =
          double.parse(categoriesSectionData['border_radius'].toString()) ??
              0.0;

      final List<WooProductCategory> _categories = [];
      if (categoriesSectionData['categories'] != null &&
          categoriesSectionData['categories'] is List &&
          (categoriesSectionData['categories'] as List).isNotEmpty) {
        for (final elem in categoriesSectionData['categories']) {
          try {
            final WooProductCategory obj = SectionDataUtils.extractCategory(
              Map<String, dynamic>.from(elem),
            );
            _categories.add(obj);
          } catch (e, s) {
            Dev.error(
              'Cannot Create WooProductCategory',
              error: e,
              stackTrace: s,
            );
          }
        }
      }

      if (_layout == SectionLayout.list) {
        final double _height =
            double.parse(categoriesSectionData['height'].toString()) ?? 100.0;
        return CategoriesSectionData(
          show: _show,
          layout: _layout,
          sectionType: SectionType.categoriesSection,
          borderRadius: _borderRadius,
          height: _height,
          categories: _categories,
          // ignore: prefer_const_literals_to_create_immutables
          fullResponseCategories: [],
        );
      }

      final int _columns =
          int.parse(categoriesSectionData['columns'].toString()) ?? 5;

      return CategoriesSectionData(
        show: _show,
        layout: _layout,
        sectionType: SectionType.categoriesSection,
        borderRadius: _borderRadius,
        columns: _columns,
        categories: _categories,
        // ignore: prefer_const_literals_to_create_immutables
        fullResponseCategories: [],
      );
    } catch (e, s) {
      Dev.error(e, stackTrace: s);
      return const CategoriesSectionData.empty();
    }
  }

  void update(List<WooProductCategory> newCategories) {
    fullResponseCategories?.clear();
    fullResponseCategories?.addAll(newCategories);
  }
}
