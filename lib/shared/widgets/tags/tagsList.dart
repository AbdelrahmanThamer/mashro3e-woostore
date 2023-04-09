// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../developer/dev.log.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import '../../../providers/utils/viewStateController.dart';
import '../../../screens/tags/viewModel/view_model.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../themes/themeGuide.dart';
import '../../../utils/utils.dart';

class TagsList extends StatelessWidget {
  const TagsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ChangeNotifierProvider<TagsViewModel>.value(
      value: LocatorService.tagsViewModel(),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: ViewStateController<TagsViewModel>(
          fetchData: LocatorService.tagsViewModel().getTags,
          child: Selector<TagsViewModel, List<WooProductTag>>(
            selector: (context, d) => d.tags,
            builder: (context, value, w) {
              Dev.info(
                  'Selector Building for categories Provider for tags list');
              if (value.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.length,
                  itemBuilder: (context, i) {
                    final item = value[i];
                    return _Item(tag: item);
                  },
                );
              } else {
                return Text(lang.emptyList);
              }
            },
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key key, @required this.tag}) : super(key: key);
  final WooProductTag tag;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.grey.withAlpha(50)
            : Colors.black26,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Row(
        children: [
          Center(child: Text('# ' + Utils.capitalize(tag.name))),
        ],
      ),
    );
  }
}
