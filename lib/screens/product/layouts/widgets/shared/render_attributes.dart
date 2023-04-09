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
// import 'package:flutter/material.dart';
//
// import '../../../../../constants/config.dart';
// import '../../../../../developer/dev.log.dart';
// import '../../../../../locator.dart';
// import '../../../../../models/models.dart';
// import '../../../../../shared/customLoader.dart';
// import '../attributeOptions.dart';
// import '../attribute_options_variation_swatches.dart';
//
// class PSRenderAttributes extends StatelessWidget {
//   const PSRenderAttributes({Key key, this.product}) : super(key: key);
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     if (Config.enabledVariationSwatchesForWooCommerce) {
//       if (LocatorService.wooService().productAttributes.isEmpty) {
//         return _BodyWithVariationSwatchesStateful(product: product);
//       } else {
//         return _BodyWithVariationSwatches(product: product);
//       }
//     }
//
//     return _Body(product: product);
//   }
// }
//
// class _BodyWithVariationSwatches extends StatelessWidget {
//   const _BodyWithVariationSwatches({Key key, this.product}) : super(key: key);
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     final list = product?.wooProduct?.attributes ?? [];
//     return Column(
//       children: list.map((elem) {
//         return AttributeOptionsVariationSwatches(
//           product: product,
//           options: elem.options,
//           name: elem.name,
//           attributeKey: elem.name,
//         );
//       }).toList(),
//     );
//   }
// }
//
// class _BodyWithVariationSwatchesStateful extends StatefulWidget {
//   const _BodyWithVariationSwatchesStateful({Key key, this.product})
//       : super(key: key);
//   final Product product;
//
//   @override
//   _BodyWithVariationSwatchesStatefulState createState() =>
//       _BodyWithVariationSwatchesStatefulState();
// }
//
// class _BodyWithVariationSwatchesStatefulState
//     extends State<_BodyWithVariationSwatchesStateful> {
//   bool isLoading = true;
//   bool isError = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetch();
//   }
//
//   /// Fetch the wooProduct tags from backend and store them for
//   /// future reference
//   Future<void> _fetch() async {
//     try {
//       final result = await LocatorService.wooService().fetchProductAttributes();
//       if (result.isEmpty) {
//         // show error
//         if (mounted) {
//           setState(() {
//             isError = true;
//             isLoading = false;
//           });
//         }
//         return;
//       }
//
//       if (mounted) {
//         setState(() {
//           isError = false;
//           isLoading = false;
//         });
//       }
//     } catch (e, s) {
//       Dev.error('Fetch product attributes error', error: e, stackTrace: s);
//       if (mounted) {
//         setState(() {
//           isError = true;
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const SizedBox(
//         height: 200,
//         child: CustomLoader(),
//       );
//     }
//
//     if (isError) {
//       return _Body(product: widget.product);
//     }
//
//     final list = widget.product?.wooProduct?.attributes ?? [];
//     if (list.isEmpty) {
//       Dev.warn('No attributes found');
//       return const SizedBox();
//     }
//     return Column(
//       children: list.map((elem) {
//         return AttributeOptionsVariationSwatches(
//           product: widget.product,
//           options: elem.options,
//           name: elem.name,
//           attributeKey: elem.name,
//         );
//       }).toList(),
//     );
//   }
// }
//
// class _Body extends StatelessWidget {
//   const _Body({Key key, this.product}) : super(key: key);
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     final list = product?.wooProduct?.attributes ?? [];
//     if (list.isEmpty) {
//       return const SizedBox();
//     }
//     return Column(
//       children: list.map((elem) {
//         return AttributeOptions(
//           product: product,
//           options: elem.options,
//           name: elem.name,
//           attributeKey: elem.name,
//         );
//       }).toList(),
//     );
//   }
// }
