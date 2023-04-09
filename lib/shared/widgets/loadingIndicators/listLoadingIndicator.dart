// // Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
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
// import '../../customLoader.dart';
//
// class ListLoadingIndicator extends StatelessWidget {
//   const ListLoadingIndicator({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: const Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Center(
//           child: AnimatedOpacity(
//             duration: Duration(milliseconds: 200),
//             opacity: 1,
//             child: CustomLoader(),
//           ),
//         ),
//       ),
//     );
//   }
// }
