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
import 'package:dio/dio.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/vendor.dart';

import '../../../constants/wooConfig.dart';
import '../../../developer/dev.log.dart';

mixin VendorsMixin {
  UnmodifiableListView<Vendor> allVendors = UnmodifiableListView(
    const <Vendor>[],
  );

  Future<List<Vendor>> fetchVendors({
    int page = 1,
    int perPage = 10,
    String? search,
    List<int>? includes,
    List<int>? excludes,
    bool? featured,
    String? orderBy,
  }) async {
    try {
      final Response response = await Dio().get(
        '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api/vendors',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          'search': search,
          'includes': includes,
          'excludes': excludes,
          'featured': featured == true ? 'yes' : null,
          'orderby': orderBy,
        },
      );

      final tempList = <Vendor>[];
      if (response.statusCode == 200) {
        if (response.data is List) {
          for (final object in response.data) {
            tempList.add(Vendor.fromJson(object));
          }
          allVendors = UnmodifiableListView(tempList);

          return tempList;
        }
      }
      throw Exception(response);
    } catch (e, s) {
      Dev.error('Fetch Vendors error', error: e, stackTrace: s);
      if (e is DioError) {
        if (e.response != null &&
            e.response?.data != null &&
            e.response!.data is Map) {
          final Map data = Map.from(e.response!.data);
          if (data.containsKey('message') && isNotBlank(data['message'])) {
            throw Exception(data['message']);
          }
        } else {
          throw Exception(e.message);
        }
      }
      return const <Vendor>[];
    }
  }
}
