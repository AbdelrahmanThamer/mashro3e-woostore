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

class FilterPriceRangeSlider<T extends WooFiltersMixin> extends StatefulWidget {
  const FilterPriceRangeSlider({Key? key}) : super(key: key);

  @override
  State<FilterPriceRangeSlider> createState() =>
      _FilterPriceRangeSliderState<T>();
}

class _FilterPriceRangeSliderState<T extends WooFiltersMixin>
    extends State<FilterPriceRangeSlider> {
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
    // Function Log
    Dev.debugFunction(
      functionName: '_fetch',
      className: '_FilterPriceRangeSliderState',
      fileName: 'filter_price_range_slider.dart',
      start: true,
    );
    try {
      final provider = Provider.of<T>(context, listen: false);
      await provider
          .fetchProductMinMaxPrices(provider.buildSelectedCatIds().toList());
    } catch (e, s) {
      Dev.error('Fetch filter attributes error', error: e, stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, _) {
        if (provider.isPMMPLoading) {
          return const LinearProgressIndicator(minHeight: 2);
        }

        if (provider.isPMMPError) {
          return ErrorReload(
            errorMessage: S.of(context).somethingWentWrong,
            reloadFunction: () {
              provider.fetchProductMinMaxPrices(
                  provider.buildSelectedCatIds().toList());
            },
          );
        }

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                      '${ParseEngine.currency} ${provider.filters.minPrice?.toInt().toString()}'),
                  const Spacer(),
                  Text(
                      '${ParseEngine.currency} ${provider.filters.maxPrice?.toInt().toString()}'),
                ],
              ),
            ),
            RangeSlider(
              values: RangeValues(
                provider.filters.minPrice ?? 0,
                provider.filters.maxPrice ?? provider.priceEnd,
              ),
              min: provider.priceStart,
              max: provider.priceEnd,
              divisions: provider.buildPriceRangeDivisions(
                provider.priceEnd,
                provider.priceStart,
              ),
              onChangeEnd: (values) {
                // Update the provider with the values.
                provider.setPriceRange(
                  start: values.start.floor().toDouble(),
                  end: values.end.floor().toDouble(),
                );
              },
              onChanged: (values) {
                // Update the provider with the values.
                provider.setPriceRange(
                  start: values.start.floor().toDouble(),
                  end: values.end.floor().toDouble(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
