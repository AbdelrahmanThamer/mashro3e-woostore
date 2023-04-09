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

class FilterOnSale<T extends WooFiltersMixin> extends StatelessWidget {
  const FilterOnSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).onSale,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Selector<T, bool>(
          selector: (context, d) => d.filters.onSale,
          builder: (context, value, _) {
            return CupertinoSwitch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: value,
              onChanged:
                  Provider.of<T>(context, listen: false).toggleOnSaleFlag,
            );
          },
        ),
      ],
    );
  }
}

class FilterInStock<T extends WooFiltersMixin> extends StatelessWidget {
  const FilterInStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).inStock,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Selector<T, bool>(
          selector: (context, d) => d.filters.inStock,
          builder: (context, value, _) {
            return CupertinoSwitch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: value,
              onChanged:
                  Provider.of<T>(context, listen: false).toggleInStockFlag,
            );
          },
        ),
      ],
    );
  }
}

class FilterFeatured<T extends WooFiltersMixin> extends StatelessWidget {
  const FilterFeatured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).featured,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Selector<T, bool>(
          selector: (context, d) => d.filters.featured,
          builder: (context, value, _) {
            return CupertinoSwitch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: value,
              onChanged:
                  Provider.of<T>(context, listen: false).toggleFeaturedFlag,
            );
          },
        ),
      ],
    );
  }
}
