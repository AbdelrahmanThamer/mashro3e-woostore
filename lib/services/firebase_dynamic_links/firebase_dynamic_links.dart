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

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../../app_builder/app_builder.dart';
import '../../developer/dev.log.dart';

abstract class FirebaseDynamicLinksService {
  static final instance = FirebaseDynamicLinks.instance;

  static Future<void> listen({
    required Future<void> Function(PendingDynamicLinkData) listenSuccess,
    required Future<void> Function(dynamic) listenFailure,
  }) async {
    instance.onLink.listen(listenSuccess).onError(listenFailure);
  }

  static Future<PendingDynamicLinkData?> onInitialLink() async {
    return await instance.getInitialLink();
  }

  /// Creates a short dynamic link for the application.
  static Future<Uri> createShortDynamicLink({
    required Uri uri,
    String? title,
    String? description,
    String? imageUrl,
    String? uriPrefix,
    String? androidPackageName,
    String? iOSBundleId,
    String? appStoreId,
  }) async {
    try {
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        socialMetaTagParameters: SocialMetaTagParameters(
          title: title,
          description: description,
          imageUrl: imageUrl != null ? Uri.tryParse(imageUrl) : null,
        ),
        uriPrefix:
            uriPrefix ?? ParseEngine.firebaseDynamicLinksConfig.uriPrefix,
        link: uri,
        androidParameters: AndroidParameters(
          packageName: androidPackageName ??
              ParseEngine.firebaseDynamicLinksConfig.androidPackageName,
          minimumVersion: 0,
        ),
        iosParameters: IOSParameters(
          bundleId:
              iOSBundleId ?? ParseEngine.firebaseDynamicLinksConfig.iOSBundleId,
          minimumVersion: '0',
          appStoreId:
              appStoreId ?? ParseEngine.firebaseDynamicLinksConfig.appStoreId,
        ),
      );
      final ShortDynamicLink shortLink =
          await FirebaseDynamicLinksService.instance.buildShortLink(parameters);
      return shortLink.shortUrl;
    } catch (e, s) {
      Dev.error('Create Short Dynamic Link error', error: e, stackTrace: s);
      return uri;
    }
  }
}
