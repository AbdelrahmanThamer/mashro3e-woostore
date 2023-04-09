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
// import 'package:flutter/material.dart';
//
// import '../../../locator.dart';
// import '../../../themes/theme.dart';
// import '../../../utils/style.dart';
// import 'shared/sectionDecorator.dart';
// import 'shared/subHeading.dart';
//
// class SizeOptions extends StatelessWidget {
//   const SizeOptions({
//     Key key,
//     @required this.productId,
//   }) : super(key: key);
//
//   final String productId;
//
//   @override
//   Widget build(BuildContext context) {
//     final product = LocatorService.productsProvider().productsMap[productId];
//     if (product.sizeProductAttribute.sizeList.isEmpty ||
//         (product.wooProduct?.variations?.isEmpty ?? true) ||
//         product.wooProduct.type == 'simple') {
//       // Check if the a single size option is available
//       if (product.sizeProductAttribute.selectedSize.isNotEmpty) {
//         return _SingleSizeOptionContainer(
//           sizeOption: product.sizeProductAttribute.selectedSize,
//         );
//       }
//       return const SizedBox();
//     }
//     final theme = Theme.of(context);
//     final lang = S.of(context);
//     return SectionDecorator(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SubHeading(title: lang.selectSize),
//           ValueListenableBuilder<String>(
//             valueListenable: product.sizeNotifier,
//             builder: (context, val, w) {
//               return Wrap(
//                 children: List<Widget>.generate(
//                   product.sizeProductAttribute.sizeList.length,
//                   (int index) {
//                     return Padding(
//                       padding: ThemeGuide.padding,
//                       child: ChoiceChip(
//                         backgroundColor: theme.colorScheme.background,
//                         selectedColor: theme.primaryColorLight.withAlpha(50),
//                         labelStyle: theme.textTheme.bodyText2,
//                         padding: const EdgeInsets.all(8),
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: ThemeGuide.borderRadius,
//                         ),
//                         label: Text(
//                           product.sizeProductAttribute.sizeList[index],
//                           style: TextStyle(
//                             color: val ==
//                                     product.sizeProductAttribute.sizeList[index]
//                                 ? theme.primaryColorLight
//                                 : Style.isDarkMode(context)
//                                     ? Colors.white54
//                                     : Colors.black26,
//                           ),
//                         ),
//                         selected:
//                             val == product.sizeProductAttribute.sizeList[index],
//                         onSelected: (bool selected) {
//                           LocatorService.productsProvider().setProductSize(
//                             productId,
//                             product.sizeProductAttribute.sizeList[index],
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ).toList(),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SingleSizeOptionContainer extends StatelessWidget {
//   const _SingleSizeOptionContainer({
//     Key key,
//     @required this.sizeOption,
//   }) : super(key: key);
//   final String sizeOption;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final lang = S.of(context);
//     return SectionDecorator(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SubHeading(title: lang.size),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               color: theme.primaryColorLight.withAlpha(50),
//               borderRadius: ThemeGuide.borderRadius,
//             ),
//             child: Text(
//               sizeOption ?? '',
//               style: TextStyle(
//                 color: theme.primaryColorLight,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// @dart=2.9
