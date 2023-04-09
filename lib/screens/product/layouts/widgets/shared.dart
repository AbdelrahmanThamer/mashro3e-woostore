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
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:quiver/strings.dart';
//
// import '../../../../constants/config.dart';
// import '../../../../controllers/navigationController.dart';
// import '../../../../developer/dev.log.dart';
// import '../../../../generated/l10n.dart';
// import '../../../../models/models.dart';
// import '../../../../services/woocommerce/woocommerce.service.dart';
// import '../../../../shared/animatedButton.dart';
// import '../../../../shared/html_view.dart';
// import '../../../../shared/image/extendedCachedImage.dart';
// import '../../../../shared/widgets/stockStatus.widget.dart';
// import '../../../../themes/theme.dart';
// import '../../../../utils/style.dart';
// import '../../../../utils/utils.dart';
// import '../../viewModel/productViewModel.dart';
// import 'shared/sectionDecorator.dart';
// import 'shared/subHeading.dart';
//
// class PSBackButton extends StatelessWidget {
//   const PSBackButton({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimButton(
//       onTap: NavigationController.navigator.pop,
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
//         child: const Icon(Icons.chevron_left),
//       ),
//     );
//   }
// }
//
// class PSRefresh extends StatelessWidget {
//   const PSRefresh({Key key, @required this.child}) : super(key: key);
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       child: child,
//       onRefresh: () async {
//         await Provider.of<ProductViewModel>(context, listen: false).refresh();
//       },
//     );
//   }
// }
//
// class PSName extends StatelessWidget {
//   const PSName({
//     Key key,
//     @required this.text,
//   }) : super(key: key);
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text ?? '',
//       style: const TextStyle(
//         fontSize: 22,
//         fontWeight: FontWeight.w600,
//       ),
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//     );
//   }
// }
//
// class PSShortDescription extends StatelessWidget {
//   const PSShortDescription({
//     Key key,
//     @required this.text,
//   }) : super(key: key);
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     if (!Config.productScreenShowShortDescription) {
//       return const SizedBox();
//     }
//
//     if (isBlank(text)) {
//       return const SizedBox();
//     }
//
//     return SectionDecorator(
//       padding: const EdgeInsets.symmetric(
//         vertical: 5,
//         horizontal: 10,
//       ),
//       child: HtmlCustomView(htmlText: text),
//     );
//   }
// }
//
// class PSDescription extends StatelessWidget {
//   const PSDescription({
//     Key key,
//     this.text,
//   }) : super(key: key);
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final lang = S.of(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: ExpandablePanel(
//         theme: theme.brightness == Brightness.dark
//             ? const ExpandableThemeData(
//                 hasIcon: true,
//                 iconColor: Colors.white,
//                 headerAlignment: ExpandablePanelHeaderAlignment.center,
//               )
//             : const ExpandableThemeData(
//                 hasIcon: true,
//                 iconColor: Colors.black,
//                 headerAlignment: ExpandablePanelHeaderAlignment.center,
//               ),
//         collapsed: const SizedBox(),
//         header: SubHeading(title: lang.description),
//         expanded: isBlank(text)
//             ? Text(
//                 lang.notAvailable,
//                 style: theme.textTheme.caption,
//               )
//             : HtmlCustomView(htmlText: text),
//       ),
//     );
//   }
// }
//
// class PSStockStatusDynamic extends StatelessWidget {
//   const PSStockStatusDynamic({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     return Consumer<ProductViewModel>(
//       builder: (context, provider, _) {
//         final variation = provider.selectedVariation;
//         final currentProduct = provider.currentProduct;
//         if (variation == null) {
//           if (currentProduct.inStock ?? false) {
//             int stockQuantity = 0;
//
//             if (currentProduct.wooProduct.stockQuantity != null) {
//               stockQuantity = currentProduct.wooProduct.stockQuantity;
//             }
//
//             return SectionDecorator(
//               child: stockQuantity > 0
//                   ? Row(
//                       children: [
//                         const StockStatusBuilder(inStock: true),
//                         const SizedBox(width: 10),
//                         Text('( $stockQuantity )'),
//                       ],
//                     )
//                   : const StockStatusBuilder(inStock: true),
//             );
//           } else {
//             return const SectionDecorator(
//               child: StockStatusBuilder(inStock: false),
//             );
//           }
//         }
//
//         // Renders a widget whose variation is out of stock
//         final outOfStockWidget = SectionDecorator(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const StockStatusBuilder(inStock: false),
//               const SizedBox(height: 5),
//               Text(
//                 lang.outOfStockMessage,
//                 style: const TextStyle(
//                   color: Color(0xFFa1a1a1),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         );
//
//         if (variation.stockStatus == 'instock') {
//           return SectionDecorator(
//             child: Row(
//               children: [
//                 const StockStatusBuilder(inStock: true),
//                 const SizedBox(width: 10),
//                 if (variation.stockQuantity != null)
//                   Text('( ${variation.stockQuantity} )'),
//               ],
//             ),
//           );
//         } else {
//           return outOfStockWidget;
//         }
//       },
//     );
//   }
// }
//
// class PSPrice extends StatelessWidget {
//   const PSPrice({
//     Key key,
//     @required this.product,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData _theme = Theme.of(context);
//     final lang = S.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SubHeading(title: lang.price),
//         const SizedBox(height: 10),
//         Consumer<ProductViewModel>(
//           builder: (context, provider, _) {
//             if (provider.noVariationFoundError != null) {
//               return Text(lang.noVariationFound);
//             }
//
//             bool onSale = provider.currentProduct.wooProduct.onSale ?? false;
//             String price = provider.currentProduct.wooProduct.onSale
//                 ? provider.currentProduct.wooProduct.salePrice
//                 : provider.currentProduct.wooProduct.regularPrice;
//             String regularPrice =
//                 provider.currentProduct.wooProduct.regularPrice;
//
//             if (provider.selectedVariation != null) {
//               price = provider.selectedVariation.onSale
//                   ? provider.selectedVariation.salePrice
//                   : provider.selectedVariation.regularPrice;
//               onSale = provider.selectedVariation.onSale;
//               regularPrice = provider.selectedVariation.regularPrice;
//             }
//
//             String discount;
//             if (price != null && regularPrice.isNotEmpty) {
//               discount = Utils.calculateDiscount(
//                 salePrice: price,
//                 regularPrice: regularPrice,
//               );
//             }
//
//             const Widget loadingIndicator = LinearProgressIndicator(
//               minHeight: 2,
//             );
//
//             if (!onSale) {
//               if (price.isNotEmpty) {
//                 return Text(
//                   Utils.formatPrice(price),
//                   style: _theme.textTheme.headline6,
//                 );
//               } else {
//                 return loadingIndicator;
//               }
//             } else {
//               if (price.isNotEmpty) {
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.baseline,
//                   textBaseline: TextBaseline.alphabetic,
//                   children: [
//                     Text(
//                       Utils.formatPrice(price),
//                       style: _theme.textTheme.headline6,
//                     ),
//                     const SizedBox(width: 10),
//                     if (regularPrice != null && regularPrice.isNotEmpty)
//                       Text(
//                         Utils.formatPrice(regularPrice),
//                         style: _theme.textTheme.bodyText2.copyWith(
//                           fontSize: 14,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w500,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       ),
//                     if (discount != null) const SizedBox(width: 10),
//                     if (discount != null)
//                       Text(
//                         discount,
//                         style: _theme.textTheme.bodyText2.copyWith(
//                           fontSize: 14,
//                           color: Colors.green.shade600,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                   ],
//                 );
//               } else {
//                 return loadingIndicator;
//               }
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
//
// class PSRenderTags extends StatelessWidget {
//   const PSRenderTags({
//     Key key,
//     this.tags = const [],
//   }) : super(key: key);
//
//   final List<WooProductItemTag> tags;
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     return SectionDecorator(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SubHeading(title: lang.tags),
//           const SizedBox(height: 10),
//           Wrap(
//             direction: Axis.horizontal,
//             spacing: 3,
//             children: tags.map<Widget>(
//               (e) {
//                 if (isBlank(e.name)) {
//                   return const SizedBox.shrink();
//                 }
//                 return GestureDetector(
//                   onTap: () {
//                     NavigationController.navigator.push(
//                       TagProductsRoute(
//                         tag: WooProductTag(
//                           id: e.id,
//                           name: e.name,
//                           slug: e.slug,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     '#${e.name ?? lang.notAvailable} ',
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16,
//                     ),
//                   ),
//                 );
//               },
//             ).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PSRenderCategories extends StatelessWidget {
//   const PSRenderCategories({
//     Key key,
//     this.categories = const [],
//   }) : super(key: key);
//
//   final List<WooProductCategory> categories;
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     return SectionDecorator(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SubHeading(title: lang.categories),
//           const SizedBox(height: 10),
//           Wrap(
//             direction: Axis.horizontal,
//             spacing: 3,
//             children: categories.map<Widget>(
//               (e) {
//                 if (isBlank(e.name)) {
//                   return const SizedBox.shrink();
//                 }
//                 return GestureDetector(
//                   onTap: () {
//                     NavigationController.navigator.push(
//                       CategorisedProductsRoute(category: e),
//                     );
//                   },
//                   child: Text(
//                     '${e.name ?? lang.notAvailable} ',
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16,
//                     ),
//                   ),
//                 );
//               },
//             ).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PSVendor extends StatelessWidget {
//   const PSVendor({Key key, this.product}) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     if (product == null ||
//         product.wooProduct == null ||
//         product.wooProduct.vendor == null ||
//         !Config.productScreenShowVendorTile) {
//       return const SizedBox();
//     }
//     final Vendor vendor = product.wooProduct.vendor;
//     if (isBlank(vendor.storeName)) {
//       Dev.warn(
//           'Multi Vendor Feature is enabled but no store name was found, returning');
//       return const SizedBox();
//     }
//     return GestureDetector(
//       onTap: () {
//         // Navigator.of(context).push(CupertinoPageRoute(
//         //   builder: (context) => VendorDetailsScreenLayout(product: product),
//         // ));
//       },
//       child: _renderUi(context, vendor),
//     );
//   }
//
//   /// Renders the UI for the Vendor set in config.dart
//   Widget _renderUi(BuildContext context, Vendor vendor) {
//     if (isNotBlank(vendor.banner) &&
//         Config.productScreenVendorLayout == 'original') {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         child: ClipRRect(
//           borderRadius: ThemeGuide.borderRadius10,
//           child: Stack(
//             children: [
//               AspectRatio(
//                 aspectRatio:
//                     Config.productScreenVendorOriginalLayoutAspectRatio,
//                 child: ExtendedCachedImage(
//                   imageUrl: vendor.banner,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned.fill(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.black,
//                         Colors.transparent,
//                       ],
//                       stops: [0.1, 0.9],
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 10,
//                 right: 10,
//                 left: 10,
//                 child: Padding(
//                   padding: ThemeGuide.padding10,
//                   child: _buildStoreInfo(vendor),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else if (isNotBlank(vendor.banner) &&
//         Config.productScreenVendorLayout == 'card') {
//       return SectionDecorator(
//         padding: const EdgeInsets.all(0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             AspectRatio(
//               aspectRatio: Config.productScreenVendorOriginalLayoutAspectRatio,
//               child: ExtendedCachedImage(
//                 imageUrl: vendor.banner,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: ThemeGuide.padding10,
//               child: _buildStoreInfo(
//                 vendor,
//                 disableCustomTextStyle: true,
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return SectionDecorator(
//         child: _buildStoreInfo(vendor, disableCustomTextStyle: true),
//       );
//     }
//   }
//
//   Widget _buildStoreInfo(Vendor vendor, {bool disableCustomTextStyle = false}) {
//     final storeName = isBlank(vendor.storeName) ? 'NA' : vendor.storeName;
//     if (isNotBlank(vendor.gravatar)) {
//       return Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 storeName,
//                 style: disableCustomTextStyle
//                     ? const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       )
//                     : const TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   SizedBox(
//                     height: 14,
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
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     '( ${vendor.rating.count} )',
//                     style: disableCustomTextStyle
//                         ? const TextStyle()
//                         : const TextStyle(color: Colors.white),
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
//             storeName,
//             style: disableCustomTextStyle
//                 ? const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   )
//                 : const TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               SizedBox(
//                 height: 14,
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
//                 style: const TextStyle(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 '( ${vendor.rating.count} )',
//                 style: disableCustomTextStyle
//                     ? const TextStyle()
//                     : const TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ],
//       );
//     }
//   }
// }
