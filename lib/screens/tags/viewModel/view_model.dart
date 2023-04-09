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

import 'package:collection/collection.dart';

import '../../../developer/dev.log.dart';
import '../../../locator.dart';
import '../../../providers/utils/baseProvider.dart';
import '../../../services/woocommerce/woocommerce.service.dart';

///
/// ## `Description`
///
/// Contains all the categories for the products that the application has to
/// offer
class TagsViewModel extends BaseProvider {
  /// Tags list of the application
  List<WooProductTag> _tags = const [];

  List<WooProductTag> get tags => _tags;

  //**********************************************************
  //  Main Functions
  //**********************************************************

  /// Get the tags from the service for the products
  Future<List<WooProductTag>> getTags({bool forced = false}) async {
    // Function Log
    Dev.debugFunction(
      functionName: 'getTags',
      className: 'TagsProvider',
      fileName: 'view_model.dart',
      start: true,
    );
    if (_tags.isNotEmpty && !forced) {
      return const [];
    }
    notifyLoading();
    try {
      final List<WooProductTag> _result =
          await LocatorService.wooService().getTags();
      _tags = _result;
      notifyState(ViewState.DATA_AVAILABLE);
      // Function Log
      Dev.debugFunction(
        functionName: 'getTags',
        className: 'TagsProvider',
        fileName: 'view_model.dart',
        start: false,
      );

      return _result;
    } catch (e, s) {
      Dev.error('', error: e, stackTrace: s);
      notifyError(message: e.toString());
      return const [];
    }
  }

  WooProductTag? findTagById(int tagId) {
    return _tags.firstWhereOrNull((elem) => elem.id == tagId);
  }
}
