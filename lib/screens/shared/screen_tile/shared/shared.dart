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

part of '../screen_tile_section_layout.dart';

class _BaseTile extends StatelessWidget {
  const _BaseTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ScreenTileSectionData data;

  @override
  Widget build(BuildContext context) {
    return _Background(
      child: Row(
        children: [
          _Background.forIcon(child: Icon(data.iconData)),
          const SizedBox(width: 10),
          Text(
            createName(context, data),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String createName(BuildContext context, ScreenTileSectionData data) {
    final lang = S.of(context);

    switch (data.type) {
      case ScreenTileSectionType.myOrders:
        return lang.orders;
      case ScreenTileSectionType.wishlist:
        return lang.favorites;
      case ScreenTileSectionType.profileInformation:
        return lang.editProfile;
      case ScreenTileSectionType.notifications:
        return lang.notifications;
      case ScreenTileSectionType.account:
        return lang.account;
      case ScreenTileSectionType.settings:
        return lang.settings;
      case ScreenTileSectionType.darkMode:
        return '${lang.dark} ${lang.mode}';
      case ScreenTileSectionType.myPoints:
        return lang.points;
      case ScreenTileSectionType.downloads:
        return lang.downloads;
      case ScreenTileSectionType.shippingAddress:
        return lang.shippingAddress;
      case ScreenTileSectionType.billingAddress:
        return '${lang.billing} ${lang.address}';
      case ScreenTileSectionType.changePassword:
        return '${lang.change} ${lang.passwordLabel}';
      case ScreenTileSectionType.logout:
        return lang.logout;
      case ScreenTileSectionType.languages:
        return lang.languages;
      case ScreenTileSectionType.contactUs:
        return lang.contactUs;
      case ScreenTileSectionType.termsOfService:
        return lang.termsOfService;
      case ScreenTileSectionType.privacyPolicy:
        return lang.privacyPolicy;
      case ScreenTileSectionType.shareApp:
        return lang.shareApp;
      case ScreenTileSectionType.aboutUs:
        return lang.aboutUs;
      default:
        return data.name;
    }
  }
}

class _Background extends StatelessWidget {
  const _Background({Key? key, required this.child})
      : forIcon = false,
        super(key: key);

  const _Background.forIcon({Key? key, required this.child})
      : forIcon = true,
        super(key: key);
  final Widget child;
  final bool forIcon;

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = const EdgeInsets.all(10);
    EdgeInsets margin = const EdgeInsets.all(5);
    final theme = Theme.of(context);
    Color color = theme.colorScheme.background;
    if (forIcon) {
      padding = const EdgeInsets.all(15);
      margin = const EdgeInsets.all(0);
      color = theme.scaffoldBackgroundColor;
    }
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: child,
    );
  }
}
