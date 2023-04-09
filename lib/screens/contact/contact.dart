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

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../app_builder/app_builder.dart';
import '../../controllers/uiController.dart';
import '../../generated/l10n.dart';
import '../../themes/theme.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.contactUs),
      ),
      body: Padding(
        padding: ThemeGuide.padding20,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/contactSupport.svg',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  lang.contactUsMessage,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () async {
                  if (await canLaunchUrlString(ParseEngine.contactUsUrl)) {
                    await launchUrlString(ParseEngine.contactUsUrl);
                  } else {
                    UiController.showNotification(
                      context: context,
                      title: lang.failed,
                      message: lang.couldNotLaunch,
                      color: Colors.red,
                    );
                  }
                },
                icon: const Icon(EvaIcons.browserOutline),
                label: Text(lang.website),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () async {
                  if (await canLaunchUrlString(
                      'tel:' + ParseEngine.contactUsPhone)) {
                    await launchUrlString('tel:' + ParseEngine.contactUsPhone);
                  } else {
                    UiController.showNotification(
                      context: context,
                      title: lang.failed,
                      message: lang.couldNotLaunch,
                      color: Colors.red,
                    );
                  }
                },
                icon: const Icon(EvaIcons.phoneCallOutline),
                label: Text(lang.call),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () async {
                  if (await canLaunchUrlString(
                      'mailto:' + ParseEngine.contactUsEmail)) {
                    await launchUrlString(
                        'mailto:' + ParseEngine.contactUsEmail);
                  } else {
                    UiController.showNotification(
                      context: context,
                      title: lang.failed,
                      message: lang.couldNotLaunch,
                      color: Colors.red,
                    );
                  }
                },
                icon: const Icon(EvaIcons.emailOutline),
                label: Text(lang.emailLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
