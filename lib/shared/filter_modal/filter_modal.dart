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
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../services/woocommerce/woocommerce.service.dart';
import '../../../../shared/widgets/error/errorReload.dart';
import '../../../../utils/colors.utils.dart' as color_utils;
import '../../app_builder/app_builder.dart';
import '../../controllers/navigationController.dart';
import 'filterCategories.dart';
import 'filterTags.dart';
import 'filter_view_model.dart';

part './filter_attributes.dart';
part './filter_price_range_slider.dart';
part './filter_toggles.dart';

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

class FilterModal<T extends FilterViewModel> extends StatelessWidget {
  const FilterModal({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final T provider;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    return ChangeNotifierProvider<T>.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(lang.filter),
          actions: const [CloseButton()],
        ),
        body: Padding(
          padding: ThemeGuide.padding20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              FilterOnSale<T>(),
              const Divider(),
              FilterInStock<T>(),
              const Divider(),
              FilterFeatured<T>(),
              const Divider(),
              ExpandablePanel(
                theme: theme.brightness == Brightness.dark
                    ? const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.white,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      )
                    : const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.black,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                header: _Heading(text: lang.categories),
                collapsed: const SizedBox(),
                expanded: FilterCategories<T>(),
              ),
              const Divider(),
              ExpandablePanel(
                theme: theme.brightness == Brightness.dark
                    ? const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.white,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      )
                    : const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.black,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                header: _Heading(text: lang.tags),
                collapsed: const SizedBox(),
                expanded: FilterTags<T>(),
              ),
              const Divider(),
              ExpandablePanel(
                theme: theme.brightness == Brightness.dark
                    ? const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.white,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      )
                    : const ExpandableThemeData(
                        hasIcon: true,
                        iconColor: Colors.black,
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                header: _Heading(text: lang.price),
                collapsed: const SizedBox(),
                expanded: FilterPriceRangeSlider<T>(),
              ),
              const Divider(),
              FilterAttributes<T>(),
              const SizedBox(height: 20),
              const _ApplyFilterButton(),
              const _ClearFilters(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ClearFilters<T extends FilterViewModel> extends StatelessWidget {
  const _ClearFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return GestureDetector(
      onTap: Provider.of<T>(context, listen: false).clearFilters,
      child: Container(
        padding: ThemeGuide.padding20,
        child: Center(child: Text(lang.clearFilters)),
      ),
    );
  }
}

class _ApplyFilterButton<T extends FilterViewModel> extends StatelessWidget {
  const _ApplyFilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SafeArea(
      bottom: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GradientButton(
          onPress: () {
            Provider.of<T>(context, listen: false).onApplyFilters();
            NavigationController.navigator.pop();
          },
          child: Text(
            lang.apply,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
