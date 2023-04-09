// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is, and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../app_builder/app_builder.dart';
import '../../controllers/navigationController.dart';
import '../../generated/l10n.dart';
import '../../providers/userProvider.dart';
import '../../themes/themeGuide.dart';
import '../shared/app_bar/app_bar.dart';
import '../shared/screen_tile/screen_tile_section_layout.dart';

class ProfileScreenLayout extends StatelessWidget {
  const ProfileScreenLayout({
    Key? key,
    required this.screenData,
  }) : super(key: key);
  final AppProfileScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
          _Body(screenData: screenData),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.screenData}) : super(key: key);
  final AppProfileScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> list = [
      'profile-info-container',
      ...screenData.sections,
    ];
    return CustomScrollView(
      controller: ScrollController(),
      slivers: [
        if (screenData.appBarData.show)
          SliverAppBarLayout(
            overrideTitle: S.of(context).profile,
            data: screenData.appBarData,
          ),
        SliverPadding(
          padding: ThemeGuide.listPadding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                if (list[i] == 'profile-info-container') {
                  return const _HeaderInfo();
                }

                return ScreenTileSectionLayout(
                  data: list[i] as ScreenTileSectionData,
                );
              },
              childCount: list.length,
            ),
          ),
        ),
      ],
    );
  }
}

///
/// ## `Description`
///
/// Container for image, name and email.
///
class _HeaderInfo extends StatelessWidget {
  const _HeaderInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        decoration: BoxDecoration(
          color: _theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Selector<UserProvider, String?>(
              selector: (context, d) => d.user.name,
              child: const SizedBox(),
              builder: (context, name, w) {
                if (isNotBlank(name)) {
                  return Flexible(
                    child: Text(
                      name!,
                      style: _theme.textTheme.headline5,
                    ),
                  );
                }
                return w!;
              },
            ),
            const SizedBox(height: 5),
            Selector<UserProvider, String?>(
              selector: (context, d) => d.user.email,
              child: const _ProfileLoginButton(),
              builder: (context, email, w) {
                if (isNotBlank(email)) {
                  return Flexible(
                    child: Text(
                      email!,
                      style: _theme.textTheme.subtitle1,
                    ),
                  );
                }
                return w!;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileLoginButton extends StatelessWidget {
  const _ProfileLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return OutlinedButton.icon(
      onPressed: _login,
      icon: const Icon(Icons.login),
      label: Text(lang.login),
    );
  }

  static void _login() {
    NavigationController.navigator.push(const LoginRoute());
  }
}

// class ProfileInfo extends StatelessWidget {
//   const ProfileInfo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.only(
//         top: 40,
//         right: 30,
//         left: 30,
//         bottom: 100,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const _HeaderInfo(),
//           const SizedBox(height: 30),
//           _ProfileListTile(
//             title: lang.my + ' ' + lang.orders,
//             subtitle: lang.myOrdersSubtitle,
//             onTap: _goToMyOrders,
//             icon: EvaIcons.inbox,
//           ),
//           _ProfileListTile(
//             title: lang.favorites,
//             subtitle: lang.favorites + ' ' + lang.items,
//             onTap: _goToFavorites,
//             icon: Icons.favorite,
//           ),
//           _ProfileListTile(
//             title: lang.profile + ' ' + lang.information,
//             subtitle: lang.profileInformationSubtitle,
//             onTap: _goToEditProfile,
//             icon: Icons.verified_user,
//           ),
//           _ProfileListTile(
//             title: lang.notifications,
//             subtitle: lang.manageNotifications,
//             onTap: _goToNotifications,
//             icon: Icons.notifications_active_rounded,
//           ),
//           _ProfileListTile(
//             title: lang.account,
//             subtitle: lang.accountSettingsSubtitle,
//             onTap: _goToAccountSettings,
//             icon: Icons.account_box,
//           ),
//           _ProfileListTile(
//             title: lang.settings,
//             subtitle: lang.settingsSubtitle,
//             onTap: _goToSettings,
//             icon: EvaIcons.settings,
//           ),
//           const _ChangeThemeTile(),
//         ],
//       ),
//     );
//   }
//
//   static void _goToFavorites() {
//     NavigationController.navigator.push(
//       const FavoritesRoute(),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.myOrders),
//         );
//       },
//     );
//   }
//
//   static void _goToMyOrders() {
//     NavigationController.navigator.push(
//       const MyOrdersRoute(),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.myOrders),
//         );
//       },
//     );
//   }
//
//   static void _goToEditProfile() {
//     NavigationController.navigator.push(
//       const EditProfileRoute(),
//       onFailure: (_) {
//         NavigationController.navigator.push(
//           LoginFromXRoute(loginFrom: LoginFrom.editProfile),
//         );
//       },
//     );
//   }
//
//   static void _goToAccountSettings() {
//     NavigationController.navigator.push(const AccountSettingsRoute());
//   }
//
//   static void _goToSettings() {
//     NavigationController.navigator.push(const SettingsRoute());
//   }
//
//   static void _goToNotifications() {
//     NavigationController.navigator.push(const NotificationScreenRoute());
//   }
// }
