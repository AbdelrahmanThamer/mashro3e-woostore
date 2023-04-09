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

import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/customer_download.dart';

import '../../../developer/dev.log.dart';
import '../../../locator.dart';

class DownloadsViewModel with ChangeNotifier {
  bool isLoading = true;
  bool isError = false;

  bool isSuccess = false;
  bool hasData = false;

  List<WooCustomerDownload> downloads;

  DownloadsViewModel() {
    if (LocatorService.userProvider().user.downloads == null) {
      // Call the fetch function
      fetchDownloads();
    } else {
      if (LocatorService.userProvider().user.downloads.isNotEmpty) {
        hasData = true;
      } else {
        hasData = false;
      }

      isLoading = false;
      isSuccess = true;
      downloads = LocatorService.userProvider().user.downloads;
    }
  }

  Future<void> fetchDownloads() async {
    try {
      if (LocatorService.userProvider().user == null ||
          LocatorService.userProvider().user.wooCustomer == null ||
          LocatorService.userProvider().user.wooCustomer.id == null) {
        return;
      }

      if (!isLoading) {
        isLoading = true;
        notifyListeners();
      }

      // Get the points here
      downloads = await LocatorService.wooService().wc.getCustomerDownloads(
            customerId: LocatorService.userProvider().user.wooCustomer.id,
          );

      // Set the user points for caching
      LocatorService.userProvider().user.downloads = downloads;

      if (downloads == null || downloads.isEmpty) {
        isLoading = false;
        isError = false;
        hasData = false;
        isSuccess = true;
        notifyListeners();
      } else {
        isLoading = false;
        isError = false;
        hasData = true;
        isSuccess = true;
        notifyListeners();
      }
    } catch (e, s) {
      Dev.error('FetchDownloads error', error: e, stackTrace: s);
      isLoading = false;
      isError = true;
      hasData = false;
      isSuccess = false;
      notifyListeners();
    }
  }
}
