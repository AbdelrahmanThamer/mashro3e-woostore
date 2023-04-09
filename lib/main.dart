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

// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' as legacy;

import 'app_builder/app_builder.dart';
import 'controllers/navigationController.dart';
import 'generated/l10n.dart';
import 'locator.dart';
import 'providers/language.provider.dart';
import 'providers/themeProvider.dart';
import 'services/pushNotification/pushNotification.dart';
import 'themes/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
  ));

  // Set orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupLocator();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await PushNotificationService.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTemplateState = ref.watch(providerOfAppTemplateState);
    ref.read(providerOfParseEngineActiveTemplate);
    return legacy.MultiProvider(
      providers: [
        legacy.ChangeNotifierProvider(
          create: (context) => LocatorService.themeProvider(),
        ),
        legacy.ChangeNotifierProvider(
          create: (context) => LocatorService.productsProvider(),
        ),
        legacy.ChangeNotifierProvider(
          create: (context) => LocatorService.userProvider(),
        ),
        legacy.ChangeNotifierProvider(
          create: (context) => LocatorService.cartViewModel(),
        ),
        legacy.ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
      ],
      child: legacy.Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return legacy.Consumer<LanguageProvider>(
              builder: (context, langProvider, _) {
            return MaterialApp.router(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                FormBuilderLocalizations.delegate,
              ],
              scrollBehavior: const CupertinoScrollBehavior(),
              supportedLocales: S.delegate.supportedLocales,
              locale: langProvider.locale,
              debugShowCheckedModeBanner: false,
              routerDelegate: NavigationController.navigator.delegate(),
              routeInformationParser:
                  NavigationController.navigator.defaultRouteParser(),
              theme: themeProvider.themeMode == ThemeMode.dark
                  ? createTheme(
                      CustomTheme.darkTheme,
                      appTemplateState.template.appThemes.darkThemeData
                          .createThemeData())
                  : createTheme(
                      CustomTheme.lightTheme,
                      appTemplateState.template.appThemes.lightThemeData
                          .createThemeData(),
                    ),
            );
          });
        },
      ),
    );
  }

  ThemeData createTheme(ThemeData original, ThemeData update) {
    final result = original.copyWith(
      colorScheme: update.colorScheme,
      appBarTheme: update.appBarTheme,
      scaffoldBackgroundColor: update.scaffoldBackgroundColor,
      cupertinoOverrideTheme: update.cupertinoOverrideTheme,
      inputDecorationTheme: update.inputDecorationTheme,
      highlightColor: update.colorScheme.primary.withAlpha(50),
      splashColor: update.colorScheme.primary.withAlpha(50),
      dialogTheme: DialogTheme(
        backgroundColor: update.scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: ThemeGuide.borderRadius10,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: update.colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: ThemeGuide.borderRadius,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: update.colorScheme.primary,
          backgroundColor: update.colorScheme.primary.withAlpha(20),
          side: const BorderSide(width: 0, color: Colors.transparent),
        ),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: update.colorScheme.primary,
        activeTrackColor: update.colorScheme.primary.withAlpha(180),
        activeTickMarkColor: update.colorScheme.primary,
        inactiveTrackColor: update.colorScheme.primary.withAlpha(100),
        inactiveTickMarkColor: update.colorScheme.primary,
      ),
      toggleableActiveColor: update.colorScheme.primary,
    );
    return result;
  }
}
