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

import 'dart:io';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../../app_builder/app_builder.dart';
import '../../../controllers/authController.dart';
import '../../../controllers/navigationController.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../providers/themeProvider.dart';
import '../../accountSettings/delete_account.dart';

part 'shared/shared.dart';

class ScreenTileSectionLayout extends StatelessWidget {
  const ScreenTileSectionLayout({Key? key, required this.data})
      : super(key: key);
  final ScreenTileSectionData data;

  @override
  Widget build(BuildContext context) {
    if (data.type == ScreenTileSectionType.deleteAccount) {
      return _DeleteAccountTile(data: data);
    }
    if (data.type == ScreenTileSectionType.logout) {
      return const _LoginLogoutTile();
    }
    if (data.type == ScreenTileSectionType.darkMode) {
      return _ChangeThemeTile(data: data);
    }

    if (data.type == ScreenTileSectionType.shareApp) {
      return _ShareAppTile(data: data);
    }
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: data.action,
      )?.call(),
      child: _BaseTile(data: data),
    );
  }
}

class _DeleteAccountTile extends StatelessWidget {
  const _DeleteAccountTile({Key? key, required this.data}) : super(key: key);
  final ScreenTileSectionData data;

  @override
  Widget build(BuildContext context) {
    final bool isUserEmpty = isBlank(LocatorService.userProvider().user.id);
    final lang = S.of(context);
    if (isUserEmpty) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () =>
          NavigationController.navigator.pushWidget(const DeleteAccountPage()),
      child: _Background(
        child: Row(
          children: [
            _Background.forIcon(child: Icon(data.iconData, color: Colors.red)),
            const SizedBox(width: 10),
            Text(
              '${lang.delete} ${lang.account}',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginLogoutTile extends StatelessWidget {
  const _LoginLogoutTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isUserEmpty = isBlank(LocatorService.userProvider().user.id);
    final lang = S.of(context);
    return GestureDetector(
      onTap: isUserEmpty ? _login : _logout,
      child: _Background(
        child: Row(
          children: [
            _Background.forIcon(
              child: isUserEmpty
                  ? const Icon(Icons.login)
                  : const Icon(Icons.logout),
            ),
            const SizedBox(width: 10),
            Text(
              isUserEmpty ? lang.login : lang.logout,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  static void _logout() {
    AuthController.logout();
  }

  static void _login() {
    NavigationController.navigator.push(const LoginRoute());
  }
}

class _ChangeThemeTile extends StatelessWidget {
  const _ChangeThemeTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ScreenTileSectionData data;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return _Background(
      child: Row(
        children: [
          _Background.forIcon(child: Icon(data.iconData)),
          const SizedBox(width: 10),
          Text(
            '${lang.dark} ${lang.mode}',
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Consumer<ThemeProvider>(
            builder: (context, provider, _) {
              return CupertinoSwitch(
                value: provider.themeMode == ThemeMode.dark,
                onChanged: (_) {
                  provider.toggleThemeMode();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ShareAppTile extends StatelessWidget {
  const _ShareAppTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ScreenTileSectionData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ParseEngine.createAction(
        context: context,
        action: data.action,
      )?.call(),
      child: _Background(
        child: Row(
          children: [
            _Background.forIcon(
              child: Icon(
                Platform.isAndroid ? Icons.share : Icons.ios_share_rounded,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              S.of(context).shareApp,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
