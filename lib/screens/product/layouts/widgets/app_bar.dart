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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy;
import 'package:quiver/strings.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../controllers/uiController.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../models/models.dart';
import '../../../../providers/products/products.provider.dart';
import '../../../../services/firebase_dynamic_links/firebase_dynamic_links.dart';
import '../../../../shared/animatedButton.dart';
import '../../../../shared/widgets/likedIcon/likedIcon.dart';
import '../../../../utils/utils.dart';
import '../../../shared/app_bar/app_bar.dart';
import '../../viewModel/productViewModel.dart';

class PSAppbar extends ConsumerWidget {
  const PSAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(providerOfProductViewModel);
    final data = provider.screenData.appBarData;
    final product = provider.currentProduct;
    return SliverAppBarLayout(
      data: data,
      overrideActions: {
        AppActionType.productShare: () async {
          final lang = S.of(context);
          final url = product.wooProduct.permalink;
          if (isNotBlank(url)) {
            Share.share(await _buildShareLink(url!, ref, product));
          } else {
            UiController.showErrorNotification(
              context: context,
              title: '${lang.no} ${lang.url} ${lang.found}',
              message: lang.notAvailable,
            );
          }
        }
      },
      overrideActionButtons: {
        AppActionType.productLike: (appBarActionButtonData) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: AnimButton(
              onTap: () =>
                  LocatorService.productsProvider().toggleStatus(product.id),
              child: legacy.Selector<ProductsProvider, bool>(
                selector: (context, d) => d.productsMap[product.id]!.liked,
                builder: (context, liked, _) {
                  return liked
                      ? const LikedIcon()
                      : SliverAppBarLayout.createIcon(
                          appBarActionButtonData.iconData,
                        );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> _buildShareLink(
    String value,
    WidgetRef ref,
    Product product,
  ) async {
    try {
      final AppFirebaseDynamicLinksData data = ref
          .read(providerOfAppTemplateState)
          .template
          .appConfigurationData
          .appFirebaseDynamicLinksData;
      if (data.isEnabledForSharingProducts) {
        Uri uri = Uri.parse(value);
        uri = Uri.https(
          uri.authority,
          uri.path,
          {'product_id': product.wooProduct.id?.toString() ?? ''},
        );
        final newUrl = await FirebaseDynamicLinksService.createShortDynamicLink(
          uri: uri,
          title: data.shareProductTitle ? product.wooProduct.name : null,
          description: data.shareProductDescription
              ? isBlank(product.wooProduct.shortDescription)
                  ? Utils.removeAllHtmlTags(product.wooProduct.description)
                  : Utils.removeAllHtmlTags(product.wooProduct.shortDescription)
              : null,
          imageUrl: data.shareProductImage ? product.displayImage : null,
          uriPrefix: data.uriPrefix,
          androidPackageName: data.androidPackageName,
          iOSBundleId: data.iOSBundleId,
          appStoreId: data.appStoreId,
        );
        return newUrl.toString();
      } else {
        return value;
      }
    } catch (e, s) {
      Dev.error('_buildShareLink error', error: e, stackTrace: s);
      return value;
    }
  }
}
