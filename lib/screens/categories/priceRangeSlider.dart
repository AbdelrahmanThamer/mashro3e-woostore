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
// import '../../app_builder/app_builder.dart';
// import '../../constants/config.dart';
// import '../../generated/l10n.dart';
// import '../../locator.dart';
// import '../../themes/themeGuide.dart';
// import 'viewModel/categoryProductsProvider.dart';
//
// class PriceRangeSlider extends StatelessWidget {
//   const PriceRangeSlider({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CategoryProductsProvider>.value(
//       value: LocatorService.categoryProductsProvider(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Selector<CategoryProductsProvider, double>(
//                   selector: (context, d) => d.priceStart,
//                   builder: (context, startValue, widget) {
//                     return Text(
//                         Config.currency + ' ' + startValue.toInt().toString());
//                   },
//                 ),
//                 const Spacer(),
//                 Selector<CategoryProductsProvider, double>(
//                   selector: (context, d) => d.priceEnd,
//                   builder: (context, endValue, widget) {
//                     return Text(
//                         Config.currency + ' ' + endValue.toInt().toString());
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Consumer<CategoryProductsProvider>(
//             builder: (context, provider, _) {
//               return RangeSlider(
//                 values: RangeValues(provider.priceStart, provider.priceEnd),
//                 min: ParseEngine.minPrice,
//                 max: ParseEngine.maxPrice,
//                 divisions: ParseEngine.priceRangeDivisions,
//                 onChangeEnd: _updateProvider,
//                 onChanged: _updateProvider,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _updateProvider(RangeValues values) {
//     LocatorService.categoryProductsProvider().setPriceRange(
//       start: values.start.floor().toDouble(),
//       end: values.end.floor().toDouble(),
//     );
//   }
// }
//
// class PriceRangeSliderInBottomSheet extends StatelessWidget {
//   const PriceRangeSliderInBottomSheet({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Container(
//       padding: ThemeGuide.padding20,
//       decoration: BoxDecoration(
//         color: theme.colorScheme.background,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             S.of(context).priceRange,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const PriceRangeSlider(),
//         ],
//       ),
//     );
//   }
// }
