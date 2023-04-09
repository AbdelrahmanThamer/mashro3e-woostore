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

/// Model object for `advanced shipment tracking` plugin
/// in woo commerce
class AdvancedShipmentTracking {
  final Links links;
  final String dateShipped;
  final String trackingId;
  final String trackingLink;
  final String trackingNumber;
  final String trackingProvider;

  AdvancedShipmentTracking({
    this.links,
    this.dateShipped,
    this.trackingId,
    this.trackingLink,
    this.trackingNumber,
    this.trackingProvider,
  });

  factory AdvancedShipmentTracking.fromJson(Map<String, dynamic> json) {
    return AdvancedShipmentTracking(
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
      dateShipped: json['date_shipped'],
      trackingId: json['tracking_id'],
      trackingLink: json['tracking_link'],
      trackingNumber: json['tracking_number'],
      trackingProvider: json['tracking_provider'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date_shipped'] = dateShipped;
    data['tracking_id'] = trackingId;
    data['tracking_link'] = trackingLink;
    data['tracking_number'] = trackingNumber;
    data['tracking_provider'] = trackingProvider;
    if (links != null) {
      data['_links'] = links.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'AdvancedShipmentTracking{dateShipped: $dateShipped, trackingId: $trackingId, trackingLink: $trackingLink, trackingNumber: $trackingNumber, trackingProvider: $trackingProvider}';
  }
}

class Links {
  List<Collection> collection;
  List<Self> self;
  List<Up> up;

  Links({this.collection, this.self, this.up});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      collection: json['collection'] != null
          ? (json['collection'] as List)
              .map((i) => Collection.fromJson(i))
              .toList()
          : null,
      self: json['self'] != null
          ? (json['self'] as List).map((i) => Self.fromJson(i)).toList()
          : null,
      up: json['up'] != null
          ? (json['up'] as List).map((i) => Up.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (collection != null) {
      data['collection'] = collection.map((v) => v.toJson()).toList();
    }
    if (self != null) {
      data['self'] = self.map((v) => v.toJson()).toList();
    }
    if (up != null) {
      data['up'] = up.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  factory Self.fromJson(Map<String, dynamic> json) {
    return Self(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['href'] = href;
    return data;
  }
}

class Up {
  String href;

  Up({this.href});

  factory Up.fromJson(Map<String, dynamic> json) {
    return Up(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['href'] = href;
    return data;
  }
}

class Collection {
  String href;

  Collection({this.href});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['href'] = href;
    return data;
  }
}
