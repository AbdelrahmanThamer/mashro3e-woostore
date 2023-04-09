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
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:quiver/strings.dart';
//
// import '../../constants/config.dart';
// import '../../controllers/authController.dart';
// import '../../controllers/navigationController.dart';
// import '../../generated/l10n.dart';
// import '../../locator.dart';
// import '../../shared/widgets/listTiles/settingsItemTile.dart';
// import '../login/enums/loginFromXEnum.dart';
//
// class AccountSettings extends StatelessWidget {
//   const AccountSettings({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isUserEmpty = isBlank(LocatorService.userProvider()?.user?.id);
//     final lang = S.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(lang.account),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           children: <Widget>[
//             if (Config.showPointsListTile)
//               SettingsItemTile(
//                 title: lang.my + ' ' + lang.points,
//                 iconData: Icons.post_add_rounded,
//                 onTap: _goToPointsScreen,
//               ),
//             if (Config.showCustomerDownloadsListTile)
//               SettingsItemTile(
//                 title: lang.downloads,
//                 iconData: EvaIcons.downloadOutline,
//                 onTap: _goToDownloadsScreen,
//               ),
//             SettingsItemTile(
//               title: lang.shippingAddress,
//               iconData: Icons.local_shipping,
//               onTap: _goToShippingAddress,
//             ),
//             SettingsItemTile(
//               title: lang.billing + ' ' + lang.address,
//               iconData: Icons.credit_card_rounded,
//               onTap: _goToBillingAddress,
//             ),
//             SettingsItemTile(
//               title: lang.change + ' ' + lang.passwordLabel,
//               iconData: Icons.security,
//               onTap: _goToChangePassword,
//             ),
//             SettingsItemTile(
//               title: isUserEmpty ? lang.login : lang.logout,
//               iconData: isUserEmpty ? Icons.login : Icons.logout,
//               onTap: isUserEmpty ? _login : _logout,
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   static void _goToPointsScreen() {
//     NavigationController.navigator.push(
//       const PointsScreenRoute(),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.myPoints),
//         );
//       },
//     );
//   }
//
//   static void _goToDownloadsScreen() {
//     NavigationController.navigator.push(
//       const DownloadsScreenRoute(),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.customerDownloads),
//         );
//       },
//     );
//   }
//
//   static void _goToShippingAddress() {
//     NavigationController.navigator.push(
//       AddressScreenRoute(isShipping: true),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.shippingAddress),
//         );
//       },
//     );
//   }
//
//   static void _goToBillingAddress() {
//     NavigationController.navigator.push(
//       AddressScreenRoute(isShipping: false),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.billingAddress),
//         );
//       },
//     );
//   }
//
//   static void _goToChangePassword() {
//     NavigationController.navigator.push(
//       const ChangePasswordRoute(),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.changePassword),
//         );
//       },
//     );
//   }
//
//   static void _logout() {
//     AuthController.logout();
//   }
//
//   static void _login() {
//     NavigationController.navigator.push(const LoginRoute());
//   }
// }
