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
// import 'package:badges/badges.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../constants/config.dart';
// import '../../controllers/navigationController.dart';
// import '../../generated/l10n.dart';
// import '../../locator.dart';
// import '../../shared/customLoader.dart';
// import '../cart/viewModel/viewModel.dart';
// import '../categories/widgets/homeList/categoriesList.dart';
// import 'viewModel/homeViewModel.dart';
// import 'widgets/sections_view.dart';
//
// class Home extends StatelessWidget {
//   const Home({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: () =>
//             LocatorService.tabbarController().handleExitEvent(context),
//         child: RefreshIndicator(
//           onRefresh: LocatorService.homeViewModel().refresh,
//           child: CustomScrollView(
//             controller: LocatorService.homeViewModel().scrollController,
//             physics: const BouncingScrollPhysics(
//               parent: AlwaysScrollableScrollPhysics(),
//             ),
//             slivers: const [
//               SliverAppBar(
//                 title: _Heading(),
//                 automaticallyImplyLeading: false,
//                 centerTitle: false,
//                 actions: [
//                   if (Config.homePageAppBarShowNotificationIcon)
//                     _NotificationIcon(),
//                   if (Config.homePageAppBarShowCartIcon) _CartIcon(),
//                 ],
//               ),
//               if (Config.showCategoriesInHome) CategoriesList(),
//               SectionsView(),
//               SliverToBoxAdapter(child: _ListBottomLoading()),
//               SliverToBoxAdapter(child: SizedBox(height: 100)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _ListBottomLoading extends StatelessWidget {
//   const _ListBottomLoading({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<HomeViewModel>.value(
//       value: LocatorService.homeViewModel(),
//       child: Selector<HomeViewModel, bool>(
//         selector: (context, d) => d.moreDataLoading,
//         builder: (context, loading, w) {
//           if (loading) {
//             return w;
//           }
//           return const SizedBox();
//         },
//         child: const Padding(
//           padding: EdgeInsets.symmetric(vertical: 50),
//           child: Center(child: CustomLoader()),
//         ),
//       ),
//     );
//   }
// }
//
// class _Heading extends StatelessWidget {
//   const _Heading({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final lang = S.of(context);
//     return RichText(
//       text: TextSpan(
//         text: '${lang.welcomeTo}\n',
//         style: theme.textTheme.caption,
//         children: [
//           TextSpan(
//             text: Config.appName,
//             style: theme.textTheme.headline6,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _NotificationIcon extends StatelessWidget {
//   const _NotificationIcon({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         NavigationController.navigator.push(const NotificationScreenRoute());
//       },
//       icon: const Icon(Icons.notifications_none_rounded),
//     );
//   }
// }
//
// class _CartIcon extends StatelessWidget {
//   const _CartIcon({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         NavigationController.navigator.push(const CartRoute());
//       },
//       icon: Selector<CartViewModel, int>(
//         selector: (context, d) => d.totalItems,
//         builder: (context, count, w) {
//           if (count == null || count <= 0) {
//             return w;
//           }
//           return Badge(
//             toAnimate: false,
//             badgeColor: Theme.of(context).colorScheme.primary,
//             badgeContent: Text(
//               count.toString(),
//               style: const TextStyle(color: Colors.white),
//             ),
//             child: w,
//           );
//         },
//         child: const Icon(EvaIcons.shoppingCartOutline),
//       ),
//     );
//   }
// }
