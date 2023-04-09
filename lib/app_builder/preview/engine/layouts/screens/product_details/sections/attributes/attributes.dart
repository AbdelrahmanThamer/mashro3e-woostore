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

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';

import '../../../../../../../models/app_template/app_template.dart';
import '../../../../utils.dart';
import '../shared.dart';

class PSAttributesSectionLayout extends StatelessWidget {
  const PSAttributesSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSAttributesSectionData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PSStyledContainerLayout(
          styledData: data.styledData,
          child: _ColorAttribute(data: data),
        ),
        PSStyledContainerLayout(
          styledData: data.styledData,
          child: _SizeAttribute(data: data),
        ),
      ],
    );
  }
}

class _ColorAttribute extends StatelessWidget {
  const _ColorAttribute({Key? key, required this.data}) : super(key: key);
  final PSAttributesSectionData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          ParseEngineLayoutUtils.convertTextAlignToCrossAxisAlignment(
        data.styledData.textStyleData.alignment,
      ),
      children: [
        Text(
          'Color: Red',
          style: data.styledData.textStyleData.createTextStyle(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment:
              ParseEngineLayoutUtils.convertTextAlignToMainAxisAlignment(
            data.styledData.textStyleData.alignment,
          ),
          children: [
            const SizedBox(
              height: 35,
              width: 35,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFF42A5F5),
                  borderRadius: ThemeGuide.borderRadius,
                ),
              ),
            ),
            const SizedBox(width: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: ThemeGuide.borderRadius,
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFEF5350),
                      borderRadius: ThemeGuide.borderRadius,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const SizedBox(
              height: 35,
              width: 35,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFF66BB6A),
                  borderRadius: ThemeGuide.borderRadius,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SizeAttribute extends StatelessWidget {
  const _SizeAttribute({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSAttributesSectionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment:
          ParseEngineLayoutUtils.convertTextAlignToCrossAxisAlignment(
        data.styledData.textStyleData.alignment,
      ),
      children: [
        Text(
          'Size: L',
          style: data.styledData.textStyleData.createTextStyle(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment:
              ParseEngineLayoutUtils.convertTextAlignToMainAxisAlignment(
            data.styledData.textStyleData.alignment,
          ),
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: ThemeGuide.borderRadius,
                ),
                child: const Center(child: Text('S')),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 40,
              width: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: ThemeGuide.borderRadius,
                ),
                child: const Center(child: Text('M')),
              ),
            ),
            const SizedBox(width: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: ThemeGuide.borderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: ThemeGuide.borderRadius,
                    ),
                    child: const Center(child: Text('L')),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
