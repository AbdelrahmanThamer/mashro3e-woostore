// // Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../generated/l10n.dart';
// import '../../../models/productModel.dart';
// import '../viewModel/productViewModel.dart';
// import 'constants.dart';
// import 'widgets/buyNowContainer.dart';
// import 'widgets/imageContainer.dart';
// import 'widgets/linkedProducts.dart';
// import 'widgets/quantity.dart';
// import 'widgets/reviewContainer.dart';
// import 'widgets/rewardPoints.dart';
// import 'widgets/shared.dart';
// import 'widgets/shared/likeButton.dart';
// import 'widgets/shared/onSaleAnimatedContainer.dart';
// import 'widgets/shared/render_attributes.dart';
// import 'widgets/shared/sectionDecorator.dart';
// import 'widgets/shared/share_button.dart';
//
// class PSLayoutDraggableSheet extends StatelessWidget {
//   const PSLayoutDraggableSheet({
//     Key key,
//     @required this.product,
//   }) : super(key: key);
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     return ChangeNotifierProvider(
//       create: (context) => ProductViewModel(product, context: context),
//       lazy: false,
//       child: Scaffold(
//         body: SafeArea(
//           bottom: true,
//           child: Stack(
//             children: <Widget>[
//               PSRefresh(
//                 child: SingleChildScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(
//                     parent: BouncingScrollPhysics(),
//                   ),
//                   padding: const EdgeInsets.all(0),
//                   child: ImageContainerDraggableSheet(
//                     imagesNotifier: product.imageNotifier,
//                   ),
//                 ),
//               ),
//               DraggableScrollableSheet(
//                 maxChildSize: 0.86,
//                 initialChildSize:
//                     PSLayoutConstants.draggableSheetLayoutInitialSize,
//                 minChildSize: PSLayoutConstants.draggableSheetLayoutMinSize,
//                 builder: (context, scrollController) {
//                   return Container(
//                     padding: const EdgeInsets.only(top: 30),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.background,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: ListView(
//                       controller: scrollController,
//                       physics: const BouncingScrollPhysics(),
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 0,
//                             horizontal: 20,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               SectionDecorator(
//                                 child: PSName(text: product.wooProduct.name),
//                               ),
//                               SectionDecorator(
//                                 child: PSPrice(product: product),
//                               ),
//                               PSVendor(product: product),
//                               const ProductRewardPointsView(),
//                               const PSStockStatusDynamic(),
//                               PSShortDescription(
//                                 text: product?.wooProduct?.shortDescription,
//                               ),
//                               SectionDecorator(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                   horizontal: 20,
//                                 ),
//                                 child: PSDescription(
//                                     text: product.wooProduct.description),
//                               ),
//                               PSRenderAttributes(product: product),
//                               if (!(product.wooProduct.soldIndividually ??
//                                   false))
//                                 SectionDecorator(
//                                     child: Quantity(productId: product.id)),
//                               if (product.wooProduct.reviewsAllowed ?? false)
//                                 SectionDecorator(
//                                   child: ReviewContainer(product: product),
//                                 ),
//                               if (product?.wooProduct?.categories?.isNotEmpty ??
//                                   false)
//                                 PSRenderCategories(
//                                   categories: product.wooProduct.categories,
//                                 ),
//                               if (product?.wooProduct?.tags?.isNotEmpty ??
//                                   false)
//                                 PSRenderTags(tags: product.wooProduct.tags),
//                             ],
//                           ),
//                         ),
//                         if (product.wooProduct.crossSellIds != null &&
//                             product.wooProduct.crossSellIds.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: LinkedProducts(
//                               productIds: product.wooProduct.crossSellIds,
//                               title: lang.frequentlyBoughtTogether,
//                             ),
//                           ),
//                         if (product.wooProduct.upsellIds != null &&
//                             product.wooProduct.upsellIds.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: LinkedProducts(
//                               productIds: product.wooProduct.upsellIds,
//                               title: lang.youMayAlsoLike,
//                             ),
//                           ),
//                         if (product.wooProduct.relatedIds != null &&
//                             product.wooProduct.relatedIds.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: LinkedProducts(
//                               productIds: product.wooProduct.relatedIds,
//                               title: lang.related,
//                             ),
//                           ),
//                         const SizedBox(height: 200)
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: BuyNowContainer(product: product),
//               ),
//               Positioned(
//                 top: 20,
//                 right: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const OnSaleAnimatedContainer(),
//                     ProductLikeButton(productId: product.id),
//                     const SizedBox(height: 10),
//                     ProductShareButton(product: product),
//                   ],
//                 ),
//               ),
//               const Positioned(
//                 top: 20,
//                 left: 20,
//                 child: PSBackButton(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
