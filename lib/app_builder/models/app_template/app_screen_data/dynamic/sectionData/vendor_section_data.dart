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

part of '../customSectionData.dart';

@immutable
class VendorSectionData extends CustomSectionData {
  final bool showTopRated;
  final bool showBestSelling;
  final bool enableShowAllButton;

  /// List of defined vendors to be shown in this section
  final List<VendorData> vendors;
  final SectionLayout layout;
  final String? title;
  final VendorCardLayoutData vendorCardLayoutData;
  final int columns;

  const VendorSectionData({
    required int id,
    required String name,
    required bool show,
    required StyledData styledData,
    this.vendors = const [],
    this.layout = SectionLayout.horizontalList,
    this.title,
    this.showTopRated = false,
    this.showBestSelling = false,
    this.enableShowAllButton = true,
    this.vendorCardLayoutData = const VendorCardLayoutData(),
    this.columns = 2,
  }) : super(
          id: id,
          name: name,
          show: show,
          sectionType: SectionType.vendor,
          styledData: styledData,
        );

  VendorSectionData.empty({
    this.layout = SectionLayout.horizontalList,
    this.title,
    this.vendors = const [],
    this.showTopRated = false,
    this.showBestSelling = false,
    this.vendorCardLayoutData = const VendorCardLayoutData(),
    this.enableShowAllButton = true,
    this.columns = 2,
  }) : super.empty(
          id: CustomSectionUtils.generateUUID(),
          name: 'Vendor Section',
          show: false,
          sectionType: SectionType.vendor,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'layout': layout.name,
      'title': title,
      'vendors': vendors.map((e) => e.toMap()).toList(),
      'showTopRated': showTopRated,
      'showBestSelling': showBestSelling,
      'vendorCardLayoutData': vendorCardLayoutData.toMap(),
      'enableShowAllButton': enableShowAllButton,
      'columns': columns,
    };
  }

  factory VendorSectionData.fromMap(Map<String, dynamic> map) {
    return VendorSectionData(
      id: ModelUtils.createIntProperty(map['id']),
      layout: CustomSectionUtils.convertStringToSectionLayout(map['layout']),
      show: ModelUtils.createBoolProperty(map['show']),
      title: ModelUtils.createStringProperty(map['title']),
      name: ModelUtils.createStringProperty(map['name']),
      styledData: StyledData.fromMap(map['styledData']),
      vendors: ModelUtils.createListOfType(
        map['vendors'],
        (elem) => VendorData.fromMap(elem),
      ),
      showTopRated: ModelUtils.createBoolProperty(map['showTopRated']),
      showBestSelling: ModelUtils.createBoolProperty(map['showBestSelling']),
      vendorCardLayoutData:
          VendorCardLayoutData.fromMap(map['vendorCardLayoutData']),
      enableShowAllButton:
          ModelUtils.createBoolProperty(map['enableShowAllButton']),
      columns: ModelUtils.createIntProperty(map['columns'], 2),
    );
  }

  @override
  VendorSectionData copyWith({
    int? id,
    SectionLayout? layout,
    String? title,
    bool? show,
    String? name,
    StyledData? styledData,
    List<VendorData>? vendors,
    bool? showTopRated,
    bool? showBestSelling,
    bool? enableShowAllButton,
    VendorCardLayoutData? vendorCardLayoutData,
    int? columns,
  }) {
    return VendorSectionData(
      id: id ?? this.id,
      layout: layout ?? this.layout,
      title: title ?? this.title,
      show: show ?? this.show,
      name: name ?? this.name,
      styledData: styledData ?? this.styledData,
      vendors: vendors ?? this.vendors,
      showTopRated: showTopRated ?? this.showTopRated,
      showBestSelling: showBestSelling ?? this.showBestSelling,
      enableShowAllButton: enableShowAllButton ?? this.enableShowAllButton,
      vendorCardLayoutData: vendorCardLayoutData ?? this.vendorCardLayoutData,
      columns: columns ?? this.columns,
    );
  }
}
