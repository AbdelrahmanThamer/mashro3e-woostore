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

import 'package:quiver/strings.dart';
import 'package:woocommerce/models/customer.dart';

/// Data class for shipping `Address` information of the user.
class Address {
  final String? city, state, postCode, country, company;

  /// Address 1 is the street address and address 2 is the optional
  /// apartment, unit address.
  final String? address1, address2;

  const Address({
    this.state,
    this.city,
    this.country,
    this.postCode,
    this.company,
    this.address1,
    this.address2,
  });

  /// Creates an Address instance form WooCustomer shipping or billing object.
  factory Address.fromWooAddress({Shipping? shipping}) {
    return Address(
      address1: shipping?.address1,
      address2: shipping?.address2,
      city: shipping?.city,
      state: shipping?.state,
      country: shipping?.country,
      postCode: shipping?.postcode,
      company: shipping?.company,
    );
  }

  const Address.empty({
    this.city = '',
    this.state = '',
    this.postCode = '',
    this.country = '',
    this.company = '',
    this.address1 = '',
    this.address2 = '',
  });

  Address copyWith({
    String? city,
    String? state,
    String? postCode,
    String? country,
    String? company,
    String? address1,
    String? address2,
  }) {
    if ((city == null || identical(city, this.city)) &&
        (state == null || identical(state, this.state)) &&
        (postCode == null || identical(postCode, this.postCode)) &&
        (country == null || identical(country, this.country)) &&
        (company == null || identical(company, this.company)) &&
        (address1 == null || identical(address1, this.address1)) &&
        (address2 == null || identical(address2, this.address2))) {
      return this;
    }

    return Address(
      city: city ?? this.city,
      state: state ?? this.state,
      postCode: postCode ?? this.postCode,
      country: country ?? this.country,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'city': city,
      'state': state,
      'postcode': postCode,
      'country': country,
      'company': company,
      'address_1': address1,
      'address_2': address2,
    } as Map<String, dynamic>;
  }

  /// Checks if the address passed is valid or not
  static bool isValid(Address? address) {
    if (address == null) {
      return false;
    }
    if (isBlank(address.address1) ||
        isBlank(address.country) ||
        isBlank(address.postCode)) {
      return false;
    }
    return true;
  }
}

/// Billing address for the user
class BillingAddress extends Address {
  final String? email, phone;

  const BillingAddress({
    String? state,
    String? city,
    String? country,
    String? postCode,
    String? company,
    String? address1,
    String? address2,
    this.email,
    this.phone,
  }) : super(
          state: state,
          city: city,
          country: country,
          postCode: postCode,
          company: company,
          address1: address1,
          address2: address2,
        );

  /// Creates an Address instance form WooCustomer shipping or billing object.
  factory BillingAddress.fromWooAddress({Billing? billing}) {
    return BillingAddress(
      address1: billing?.address1,
      address2: billing?.address2,
      city: billing?.city,
      state: billing?.state,
      country: billing?.country,
      postCode: billing?.postcode,
      email: billing?.email,
      phone: billing?.phone,
      company: billing?.company,
    );
  }

  const BillingAddress.empty({
    this.email = '',
    this.phone = '',
  }) : super.empty();

  @override
  BillingAddress copyWith({
    String? city,
    String? state,
    String? postCode,
    String? country,
    String? company,
    String? address1,
    String? address2,
    String? email,
    String? phone,
  }) {
    if ((city == null || identical(city, this.city)) &&
        (state == null || identical(state, this.state)) &&
        (postCode == null || identical(postCode, this.postCode)) &&
        (country == null || identical(country, this.country)) &&
        (company == null || identical(company, this.company)) &&
        (address1 == null || identical(address1, this.address1)) &&
        (address2 == null || identical(address2, this.address2)) &&
        (email == null || identical(email, this.email)) &&
        (phone == null || identical(phone, this.phone))) {
      return this;
    }

    return BillingAddress(
      city: city ?? this.city,
      state: state ?? this.state,
      postCode: postCode ?? this.postCode,
      country: country ?? this.country,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      ...super.toMap(),
      'email': email,
      'phone': phone,
    } as Map<String, dynamic>;
  }

  /// Checks if the address passed is valid or not
  static bool isValid(BillingAddress? address) {
    if (address == null) {
      return false;
    }
    if (isBlank(address.address1) ||
        isBlank(address.country) ||
        isBlank(address.postCode) ||
        isBlank(address.email)) {
      return false;
    }
    return true;
  }
}
