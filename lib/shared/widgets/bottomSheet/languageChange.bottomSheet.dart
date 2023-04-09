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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../../constants/languages.dart';
import '../../../generated/l10n.dart';
import '../../../providers/language.provider.dart';
import '../../../themes/theme.dart';

class LanguageChangeBottomSheet extends StatelessWidget {
  const LanguageChangeBottomSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: ThemeGuide.borderRadius20,
      ),
      child: const _RenderList(),
    );
  }
}

class _RenderList extends StatelessWidget {
  const _RenderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Locale> list = S.delegate.supportedLocales;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: list.length,
      itemBuilder: (context, i) {
        return _ListItem(locale: list[i], theme: theme);
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    Key? key,
    required this.locale,
    required this.theme,
  }) : super(key: key);
  final Locale locale;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final info = _getLanguageInfo(locale.languageCode, locale.countryCode);

    if (info == null) {
      return const SizedBox();
    }

    final bool isSelected = Intl.getCurrentLocale() == locale.languageCode;

    return GestureDetector(
      onTap: () {
        Provider.of<LanguageProvider>(context, listen: false)
            .changeLocale(locale);
      },
      child: Container(
        margin: ThemeGuide.marginV5,
        padding: ThemeGuide.marginV10,
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: ThemeGuide.borderRadius10,
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            'assets/svg/flags/' + info['asset'],
            height: 40,
            width: 60,
          ),
          title: Text(info['title'] ?? ''),
          trailing: isSelected
              ? Icon(Icons.circle, color: theme.colorScheme.primary)
              : const SizedBox(),
        ),
      ),
    );
  }

  /// Returns the language information from the lang code and country
  /// code
  Map<String, dynamic>? _getLanguageInfo(
    String? languageCode,
    String? countryCode,
  ) {
    if (isBlank(languageCode) && isBlank(countryCode)) {
      return null;
    }
    return kSupportedLanguages.firstWhereOrNull(
      (element) {
        if (isNotBlank(languageCode) && isNotBlank(countryCode)) {
          return languageCode == element['languageCode'] &&
              countryCode == element['countryCode'];
        } else if (isNotBlank(languageCode) && isBlank(countryCode)) {
          return languageCode == element['languageCode'];
        } else if (isBlank(languageCode) && isNotBlank(countryCode)) {
          return countryCode == element['countryCode'];
        } else {
          return false;
        }
      },
    );
  }
}
