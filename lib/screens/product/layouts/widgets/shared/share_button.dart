// // Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
// // All Rights Reserved.
// //
// // NOTICE: All information contained herein is, and remains the
// // property of Aniket Malik. The intellectual and technical concepts
// // contained herein are proprietary to Aniket Malik and are protected
// // by trade secret or copyright law.
// //
// // Dissemination of this information or reproduction of this material
// // is strictly forbidden unless prior written permission is obtained from
// // Aniket Malik.
//
// // @dart=2.9
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:quiver/strings.dart';
// import 'package:share_plus/share_plus.dart';
//
// import '../../../../../constants/config.dart';
// import '../../../../../controllers/uiController.dart';
// import '../../../../../developer/dev.log.dart';
// import '../../../../../generated/l10n.dart';
// import '../../../../../models/models.dart';
// import '../../../../../services/firebase_dynamic_links/firebase_dynamic_links.dart';
// import '../../../../../shared/animatedButton.dart';
// import '../../../../../themes/theme.dart';
// import '../../../../../utils/style.dart';
// import '../../../../../utils/utils.dart';
//
// class ProductShareButton extends StatelessWidget {
//   const ProductShareButton({Key key, @required this.product}) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     final url = product?.wooProduct?.permalink;
//     return AnimButton(
//       onTap: () async {
//         if (isNotBlank(url)) {
//           Share.share(await _buildShareLink(url));
//         } else {
//           UiController.showErrorNotification(
//             context: context,
//             title: '${lang.no} ${lang.url} ${lang.found}',
//             message: lang.notAvailable,
//           );
//         }
//       },
//       child: Container(
//         padding: ThemeGuide.padding10,
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.background,
//           borderRadius: ThemeGuide.borderRadius,
//           boxShadow: UIStyle.renderShadow(
//             context: context,
//             light: ThemeGuide.darkShadow,
//             dark: ThemeGuide.primaryShadowDark,
//           ),
//         ),
//         child: Platform.isAndroid
//             ? const Icon(Icons.share_outlined)
//             : const Icon(Icons.ios_share_rounded),
//       ),
//     );
//   }
//
//   Future<String> _buildShareLink(String value) async {
//     try {
//       if (FirebaseDynamicLinksConfig.isEnabledForSharingProducts) {
//         Uri uri = Uri.parse(value);
//         uri = Uri.https(
//           uri.authority,
//           uri.path,
//           {'product_id': product?.wooProduct?.id?.toString() ?? ''},
//         );
//         final newUrl = await FirebaseDynamicLinksService.createShortDynamicLink(
//           uri: uri,
//           title: FirebaseDynamicLinksConfig.shareProductTitle
//               ? product?.wooProduct?.name
//               : null,
//           description: FirebaseDynamicLinksConfig.shareProductDescription
//               ? isBlank(product.wooProduct.shortDescription)
//                   ? Utils.removeAllHtmlTags(product?.wooProduct?.description)
//                   : Utils.removeAllHtmlTags(product.wooProduct.shortDescription)
//               : null,
//           imageUrl: FirebaseDynamicLinksConfig.shareProductImage
//               ? product?.displayImage
//               : null,
//         );
//         return newUrl.toString();
//       } else {
//         return value;
//       }
//     } catch (e, s) {
//       Dev.error('_buildShareLink error', error: e, stackTrace: s);
//       return value;
//     }
//   }
// }
