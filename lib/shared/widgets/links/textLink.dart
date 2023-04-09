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
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TextLink extends StatelessWidget {
  const TextLink({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    if (isBlank(url)) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrlString(url!)) {
          await launchUrlString(url!);
        }
      },
      child: Text(
        url!,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 16,
        ),
      ),
    );
  }
}
