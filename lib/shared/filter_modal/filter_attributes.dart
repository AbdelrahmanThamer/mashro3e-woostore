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

part of 'filter_modal.dart';

class FilterAttributes<T extends WooFiltersMixin> extends StatefulWidget {
  const FilterAttributes({Key? key}) : super(key: key);

  @override
  _FilterAttributesState createState() => _FilterAttributesState<T>();
}

class _FilterAttributesState<T extends WooFiltersMixin>
    extends State<FilterAttributes> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  /// Fetch the wooProduct tags from backend and store them for
  /// future reference
  Future<void> _fetch() async {
    try {
      final provider = Provider.of<T>(context, listen: false);
      await provider.fetchProductAttributes(
        await provider.filters.buildTaxonomyQuery(),
      );
    } catch (e, s) {
      Dev.error('Fetch filter attributes error', error: e, stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, _) {
        if (provider.isPALoading) {
          return const LinearProgressIndicator(minHeight: 2);
        }

        if (provider.isPAError) {
          return ErrorReload(
            errorMessage: S.of(context).somethingWentWrong,
            reloadFunction: _fetch,
          );
        }

        if (provider.hasPAData) {
          return Column(
            children: [
              if (provider.showPAOverlayLoading)
                const LinearProgressIndicator(minHeight: 2),
              _ListContainer<T>(list: provider.paList),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _ListContainer<T extends WooFiltersMixin> extends StatelessWidget {
  const _ListContainer({
    Key? key,
    this.list = const <WooStoreProductAttribute>[],
  }) : super(key: key);
  final List<WooStoreProductAttribute> list;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const SizedBox();
    }

    list.removeWhere((element) {
      if (element.terms == null || element.terms!.isEmpty) {
        Dev.warn(
            'Attribute ${element.name} does not have any terms, it will be hidden');
        return true;
      }
      return false;
    });

    final theme = Theme.of(context);
    return ListView.separated(
      separatorBuilder: (context, i) {
        return const Divider();
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, i) {
        if (list[i].terms == null || list[i].terms!.isEmpty) {
          Dev.warn(
              'Attribute ${list[i].name} does not have any terms, it will be hidden');
          return const SizedBox();
        }
        return _AttributeItem<T>(
          attribute: list[i],
          theme: theme,
        );
      },
    );
  }
}

class _AttributeItem<T extends WooFiltersMixin> extends StatelessWidget {
  const _AttributeItem({
    Key? key,
    required this.attribute,
    required this.theme,
  }) : super(key: key);
  final WooStoreProductAttribute attribute;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    // bool shouldExpand = true;
    // for (final obj
    //     in Provider.of<T>(context, listen: false).filters.taxonomyQueryList) {
    //   if (obj.taxonomySlug == attribute.slug) {
    //     shouldExpand = true;
    //   }
    // }
    return ExpandablePanel(
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
      controller: ExpandableController(initialExpanded: true),
      header: Text(
        attribute.name ?? '',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      collapsed: const SizedBox(),
      expanded: attribute.terms == null
          ? const SizedBox()
          : ListView.builder(
              itemCount: attribute.terms!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return _AttributeItemTerm<T>(
                  attribute: attribute,
                  term: attribute.terms![i],
                  theme: theme,
                );
              },
            ),
    );
  }
}

class _AttributeItemTerm<T extends WooFiltersMixin> extends StatelessWidget {
  const _AttributeItemTerm({
    Key? key,
    required this.attribute,
    required this.term,
    required this.theme,
  }) : super(key: key);
  final WooStoreProductAttributeTerm term;
  final ThemeData theme;
  final WooStoreProductAttribute attribute;

  @override
  Widget build(BuildContext context) {
    if (attribute.type == WooStoreProductAttributeType.color) {
      return _buildSelector(context, _buildColor());
    }

    if (attribute.type == WooStoreProductAttributeType.image) {
      return _buildSelector(context, _buildImage());
    }

    return _buildSelector(context, _buildDefault());
  }

  Widget _buildSelector(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: () {
        Provider.of<T>(context, listen: false).setTaxonomyQuery(
          WooProductTaxonomyQuery(
            attribute.slug ?? '',
            term.termId ?? 0,
          ),
        );
      },
      child: Selector<T, WooStoreFilters>(
        selector: (context, d) => d.filters,
        builder: (context, filters, w) {
          bool isTermSelected = false;

          for (final taxObject in filters.taxonomyQueryList) {
            if (taxObject.termId == term.termId) {
              isTermSelected = true;
            }
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                AnimatedContainer(
                  width: isTermSelected ? 50 : 0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: isTermSelected
                      ? Icon(
                          Icons.radio_button_checked_rounded,
                          color: theme.colorScheme.primary,
                        )
                      : const SizedBox(),
                ),
                Expanded(child: w!),
              ],
            ),
          );
        },
        child: child,
      ),
    );
  }

  Widget _buildDefault() {
    return Container(
      padding: ThemeGuide.padding16,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child:
          Text('${term.name} ${term.count != null ? '(${term.count})' : '0'}'),
    );
  }

  Widget _buildColor() {
    if (term.value == null) {
      return _buildDefault();
    }
    return Container(
      padding: ThemeGuide.padding16,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Row(
        children: [
          Text('${term.name} ${term.count != null ? '(${term.count})' : '0'}'),
          const Spacer(),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: color_utils.HexColor.fromDynamicString(term.value!),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (term.value == null) {
      return _buildDefault();
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: Row(
        children: [
          Text('${term.name} ${term.count != null ? '(${term.count})' : '0'}'),
          const Spacer(),
          SizedBox(
            height: 40,
            width: 40,
            child: ExtendedCachedImage(imageUrl: term.value),
          ),
        ],
      ),
    );
  }
}
