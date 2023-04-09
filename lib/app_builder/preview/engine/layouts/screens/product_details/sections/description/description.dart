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

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../../../models/app_template/app_template.dart';
import '../shared.dart';

class PSDescriptionSectionLayout extends StatelessWidget {
  const PSDescriptionSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSDescriptionSectionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: data.showTitle
          ? ExpandablePanel(
              controller: ExpandableController(initialExpanded: data.expanded),
              theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconColor: theme.disabledColor,
                iconPadding: const EdgeInsets.all(0),
              ),
              collapsed: const SizedBox(),
              header: Text(
                'Description',
                style: data.styledData.textStyleData
                    .createTextStyle(forcedColor: theme.disabledColor),
                textAlign: data.styledData.textStyleData.alignment,
              ),
              expanded: Padding(
                padding: data.showTitle
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.all(0),
                child: const _Html(
                    data:
                        '<p>This is some description data for the product</p>'),
              ),
            )
          : Padding(
              padding: data.showTitle
                  ? const EdgeInsets.only(top: 20)
                  : const EdgeInsets.all(0),
              child: const _Html(
                  data: '<p>This is some description data for the product</p>'),
            ),
    );
  }
}

class PSShortDescriptionSectionLayout extends StatelessWidget {
  const PSShortDescriptionSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSShortDescriptionSectionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PSStyledContainerLayout(
      styledData: data.styledData,
      child: data.showTitle
          ? ExpandablePanel(
              controller: ExpandableController(initialExpanded: data.expanded),
              theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconColor: theme.disabledColor,
                iconPadding: const EdgeInsets.all(0),
              ),
              collapsed: const SizedBox(),
              header: Text(
                'Short Description',
                style: data.styledData.textStyleData
                    .createTextStyle(forcedColor: theme.disabledColor),
                textAlign: data.styledData.textStyleData.alignment,
              ),
              expanded: Padding(
                padding: data.showTitle
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.all(0),
                child: const _Html(
                    data:
                        '<p>This is some short description data for the product</p>'),
              ),
            )
          : Padding(
              padding: data.showTitle
                  ? const EdgeInsets.only(top: 20)
                  : const EdgeInsets.all(0),
              child: const _Html(
                  data:
                      '<p>This is some short description data for the product</p>'),
            ),
    );
  }
}

class _Html extends StatelessWidget {
  const _Html({
    Key? key,
    required this.data,
  }) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Html(
      style: {
        'p': Style(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
        ),
        'body': Style(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
        ),
      },
      data: data,
    );
  }
}
