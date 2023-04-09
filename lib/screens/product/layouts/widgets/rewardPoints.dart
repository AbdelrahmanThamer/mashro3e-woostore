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
// import 'package:provider/provider.dart';
//
// import '../../../../constants/appStrings.dart';
// import '../../../../constants/config.dart';
// import '../../viewModel/productViewModel.dart';
// import 'shared/sectionDecorator.dart';
// import 'shared/subHeading.dart';
//
// class ProductRewardPointsView extends StatelessWidget {
//   const ProductRewardPointsView({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Does not show the view if [Config.enablePointsAndRewardsSupport]
//     // is set to false or [Config.showPointsInProductScreen] is set
//     // to false.
//     if (!Config.enablePointsAndRewardsSupport ||
//         !Config.showPointsInProductScreen) {
//       return const SizedBox();
//     }
//     return Selector<ProductViewModel, int>(
//       selector: (context, d) => d.points,
//       builder: (context, value, _) {
//         if (value == null || value <= 0) {
//           return const SizedBox();
//         }
//         return SectionDecorator(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SubHeading(
//                 title: AppStrings.reward + ' ' + AppStrings.points,
//               ),
//               const SizedBox(height: 10),
//               Wrap(
//                 children: [
//                   const Text(AppStrings.pointsMessage1),
//                   Text(
//                     ' ${value.toString()} ',
//                     style: const TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                   const Text(AppStrings.pointsMessage2),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
