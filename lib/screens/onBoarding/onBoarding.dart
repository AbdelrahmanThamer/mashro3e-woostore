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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quiver/strings.dart';

import '../../app_builder/app_builder.dart';
import '../../controllers/navigationController.dart';
import '../../generated/l10n.dart';
import '../../services/storage/localStorage.dart';
import '../../themes/theme.dart';

class OnBoardingScreenLayout extends ConsumerStatefulWidget {
  const OnBoardingScreenLayout({
    Key? key,
  }) : super(key: key);

  @override
  _OnBoardingScreenLayoutState createState() => _OnBoardingScreenLayoutState();
}

class _OnBoardingScreenLayoutState extends ConsumerState<OnBoardingScreenLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isDone = false;

  late AppOnBoardingScreenData screenData;

  @override
  void initState() {
    super.initState();

    screenData = ParseEngine.getScreenData(
      screenId: AppPrebuiltScreensId.onBoarding,
      screenType: AppScreenType.preBuilt,
    ) as AppOnBoardingScreenData;

    // Controller that controls the animation.
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Type of animation to perform for `Logo`
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static void _goToLogin() {
    NavigationController.navigator.replace(const LoginRoute());
  }

  static void _goToSignUp() {
    NavigationController.navigator.replace(const SignupRoute());
  }

  static void _goToTabbar() {
    NavigationController.navigator.replace(const TabbarNavigationRoute());
    LocalStorage.setString(LocalStorageConstants.INITIAL_INSTALL, 'done');
    LocalStorage.setInt(LocalStorageConstants.shouldContinueWithoutLogin, 1);
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    if (isDone) {
      _controller.forward();
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/getStarted.svg',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: Text(
                    lang.onBoardingCreateAccountMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _BuildButton(
                  title: lang.login,
                  color: LightTheme.mRed,
                  onPress: _goToLogin,
                ),
                _BuildButton(
                  title: lang.signup,
                  color: LightTheme.mYellow,
                  onPress: _goToSignUp,
                ),
                _BuildButton(
                  title: lang.continueWithoutLogin,
                  color: LightTheme.mPurple,
                  onPress: _goToTabbar,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return IntroductionScreen(
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: theme.colorScheme.primary.withAlpha(80),
          activeColor: theme.colorScheme.primary,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        pages: createPages(context),
        onDone: () async {
          await LocalStorage.setString(
              LocalStorageConstants.INITIAL_INSTALL, 'done');
          setState(() {
            isDone = true;
          });
        },
        showBackButton: false,
        showSkipButton: true,
        showNextButton: false,
        skip: Text(lang.skip),
        next: Text(lang.next),
        done: Text(
          lang.done,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }
  }

  List<PageViewModel> createPages(BuildContext context) {
    final pages = <PageViewModel>[];

    for (final page in screenData.pages) {
      Widget? titleWidget;
      if (isNotBlank(page.titleData.label)) {
        titleWidget = Text(
          page.titleData.label!,
          style: page.titleData.textStyleData.createTextStyle(),
          textAlign: page.descriptionData.textStyleData.alignment,
        );
      }
      Widget? assetWidget;

      if (isNotBlank(page.assetData.path)) {
        final file = File(page.assetData.path!);
        final fileExists = file.existsSync();
        if (fileExists) {
          if (page.assetData.type == OBAssetType.image) {
            assetWidget = Image.file(
              File(page.assetData.path!),
              height: page.assetData.height,
              width: page.assetData.allowFullWidth
                  ? double.infinity
                  : page.assetData.width,
              fit: page.assetData.boxFit,
            );
          }
          if (page.assetData.type == OBAssetType.svg) {
            assetWidget = SvgPicture.file(
              File(page.assetData.path!),
              height: page.assetData.height,
              width: page.assetData.allowFullWidth
                  ? double.infinity
                  : page.assetData.width,
              fit: page.assetData.boxFit,
            );
          }
        }
      }

      Widget? descriptionWidget;
      if (isNotBlank(page.descriptionData.label)) {
        descriptionWidget = Text(
          page.descriptionData.label!,
          style: page.descriptionData.textStyleData.createTextStyle(),
          textAlign: page.descriptionData.textStyleData.alignment,
        );
      }

      pages.add(PageViewModel(
        titleWidget: titleWidget,
        image: assetWidget ??
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
        bodyWidget: descriptionWidget,
      ));
    }

    return pages;
  }
}

class _BuildButton extends StatelessWidget {
  const _BuildButton({
    Key? key,
    required this.title,
    this.color,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final Color? color;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: CupertinoButton(
        color: color ?? Theme.of(context).colorScheme.primary,
        onPressed: onPress,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
