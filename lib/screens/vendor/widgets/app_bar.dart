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
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:quiver/strings.dart';
//
// import '../../../controllers/uiController.dart';
// import '../../../generated/l10n.dart';
// import '../../../shared/image/extendedCachedImage.dart';
// import '../../../themes/theme.dart';
// import '../viewModel/view_model.dart';
// import 'filter_modal/vendor_products_filter_modal.dart';
// import 'more_info_modal.dart';
// import 'sort_bottom_sheet.dart';
//
// class VendorAppBar extends StatelessWidget {
//   const VendorAppBar({
//     Key key,
//     @required this.vendor,
//   }) : super(key: key);
//
//   final Vendor vendor;
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     return SliverAppBar(
//       expandedHeight: 250,
//       snap: true,
//       pinned: false,
//       floating: true,
//       stretch: true,
//       flexibleSpace: FlexibleSpaceBar(
//         titlePadding: ThemeGuide.padding5,
//         title: _FlexibleBody(vendor: vendor),
//         background: Stack(
//           children: [
//             Positioned.fill(
//               child: ExtendedCachedImage(
//                 imageUrl: vendor.banner,
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.black,
//                     Colors.black26,
//                   ],
//                   stops: [0.1, 0.9],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       iconTheme: const IconThemeData(color: Colors.white),
//       actions: <Widget>[
//         IconButton(
//           tooltip: lang.sort,
//           onPressed: () {
//             final provider =
//                 Provider.of<VendorProductsViewModel>(context, listen: false);
//             UiController.modalBottomSheet(
//               context: context,
//               child: VendorProductsSortBottomSheet(provider: provider),
//             );
//           },
//           icon: const Icon(Icons.filter_list_rounded),
//         ),
//         IconButton(
//           tooltip: lang.filter,
//           onPressed: () {
//             final provider =
//                 Provider.of<VendorProductsViewModel>(context, listen: false);
//             UiController.showModal(
//               context: context,
//               child: VendorProductsFilterModal(provider: provider),
//             );
//           },
//           icon: const Icon(EvaIcons.optionsOutline),
//         ),
//         IconButton(
//           tooltip: lang.moreInfo,
//           onPressed: () {
//             showCupertinoModalPopup(
//               context: context,
//               barrierColor: Colors.black54,
//               builder: (context) {
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.5,
//                   child: VendorMoreInfoModal(vendor: vendor),
//                 );
//               },
//             );
//           },
//           icon: const Icon(EvaIcons.infoOutline),
//         ),
//       ],
//     );
//   }
// }
//
// class _FlexibleBody extends StatelessWidget {
//   const _FlexibleBody({
//     Key key,
//     this.vendor,
//   }) : super(key: key);
//   final Vendor vendor;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Column(
//       children: [
//         const Spacer(),
//         Padding(
//           padding: ThemeGuide.padding10,
//           child: _buildStoreInfo(vendor, theme),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStoreInfo(Vendor vendor, ThemeData theme) {
//     const headingStyle = TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.w600,
//       color: Colors.white,
//     );
//
//     const ratingStyle = TextStyle(
//       fontSize: 10,
//       fontWeight: FontWeight.w600,
//       color: Colors.blue,
//     );
//
//     const ratingCountStyle = TextStyle(
//       fontSize: 10,
//       fontWeight: FontWeight.w600,
//       color: Colors.white,
//     );
//     if (isNotBlank(vendor.gravatar)) {
//       return Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 vendor.storeName ?? '',
//                 style: headingStyle,
//                 // style: headingStyle,
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   SizedBox(
//                     height: 9,
//                     child: FittedBox(
//                       child: RatingBar.builder(
//                         ignoreGestures: true,
//                         glow: false,
//                         initialRating: double.tryParse(
//                                 (vendor.rating.rating)?.toString()) ??
//                             0,
//                         minRating: 0,
//                         direction: Axis.horizontal,
//                         allowHalfRating: true,
//                         itemCount: 5,
//                         unratedColor: Colors.grey.withAlpha(150),
//                         itemBuilder: (__, _) => const Icon(
//                           EvaIcons.star,
//                           color: Color(0xFFFFA000),
//                         ),
//                         onRatingUpdate: null,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     '${vendor.rating.avg}',
//                     style: ratingStyle,
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     '( ${vendor.rating.count} )',
//                     // style: ratingCountStyle,
//                     style: ratingCountStyle,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const Spacer(),
//           Container(
//             height: 60,
//             width: 60,
//             clipBehavior: Clip.hardEdge,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//             ),
//             child: ExtendedCachedImage(
//               imageUrl: vendor.gravatar,
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             vendor.storeName ?? '',
//             style: headingStyle,
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               SizedBox(
//                 height: 10,
//                 child: FittedBox(
//                   child: RatingBar.builder(
//                     ignoreGestures: true,
//                     glow: false,
//                     initialRating: double.tryParse(
//                             (vendor.rating.rating)?.toString() ?? '0') ??
//                         0,
//                     minRating: 0,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     unratedColor: Colors.grey.withAlpha(150),
//                     itemBuilder: (__, _) => const Icon(
//                       EvaIcons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: null,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 '${vendor.rating.avg}',
//                 style: ratingStyle,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 '( ${vendor.rating.count} )',
//                 style: ratingCountStyle,
//               ),
//             ],
//           ),
//         ],
//       );
//     }
//   }
// }
