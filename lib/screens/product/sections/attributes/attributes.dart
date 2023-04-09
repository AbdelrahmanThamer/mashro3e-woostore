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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app_builder/app_builder.dart';
import '../../../../locator.dart';
import '../../../../models/models.dart';
import '../../../../shared/customLoader.dart';
import '../../viewModel/productViewModel.dart';
import 'widgets/attribute_options.dart';
import 'widgets/attribute_options_variation_swatches.dart';

final providerOfPSAttributeSectionDataProvider =
    Provider<PSAttributesSectionData>((ref) {
  return const PSAttributesSectionData(id: -1);
});

class PSAttributesSectionLayout extends ConsumerWidget {
  const PSAttributesSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PSAttributesSectionData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.read(providerOfProductViewModel).currentProduct;
    Widget main = _Body(product: product);
    if (ParseEngine.enabledVariationSwatches) {
      if (LocatorService.wooService().productAttributes.isEmpty) {
        main = _BodyWithVariationSwatchesStateful(product: product);
      } else {
        main = _BodyWithVariationSwatches(product: product);
      }
    }
    return ProviderScope(
      overrides: [
        providerOfPSAttributeSectionDataProvider.overrideWithValue(data),
      ],
      child: main,
    );
  }
}

class _BodyWithVariationSwatches extends StatelessWidget {
  const _BodyWithVariationSwatches({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final list = product.wooProduct.attributes ?? [];
    return Column(
      children: list.map((elem) {
        return AttributeOptionsVariationSwatches(
          product: product,
          options: elem.options,
          name: elem.name,
          attributeKey: elem.name,
        );
      }).toList(),
    );
  }
}

class _BodyWithVariationSwatchesStateful extends StatefulWidget {
  const _BodyWithVariationSwatchesStateful({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  _BodyWithVariationSwatchesStatefulState createState() =>
      _BodyWithVariationSwatchesStatefulState();
}

class _BodyWithVariationSwatchesStatefulState
    extends State<_BodyWithVariationSwatchesStateful> {
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  /// Fetch the wooProduct tags from backend and store them for
  /// future reference
  Future<void> _fetch() async {
    try {
      final result = await LocatorService.wooService().fetchProductAttributes();
      if (result.isEmpty) {
        // show error
        if (mounted) {
          setState(() {
            isError = true;
            isLoading = false;
          });
        }
        return;
      }

      if (mounted) {
        setState(() {
          isError = false;
          isLoading = false;
        });
      }
    } catch (e, s) {
      Dev.error('Fetch product attributes error', error: e, stackTrace: s);
      if (mounted) {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 200,
        child: CustomLoader(),
      );
    }

    if (isError) {
      return _Body(product: widget.product);
    }

    final list = widget.product.wooProduct.attributes ?? [];
    if (list.isEmpty) {
      Dev.warn('No attributes found');
      return const SizedBox();
    }
    return Column(
      children: list.map((elem) {
        return AttributeOptionsVariationSwatches(
          product: widget.product,
          options: elem.options,
          name: elem.name,
          attributeKey: elem.name,
        );
      }).toList(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final list = product.wooProduct.attributes ?? [];
    if (list.isEmpty) {
      return const SizedBox();
    }
    return Column(
      children: list.map((elem) {
        return AttributeOptions(
          product: product,
          options: elem.options,
          name: elem.name,
          attributeKey: elem.name,
        );
      }).toList(),
    );
  }
}

// class _ColorAttribute extends StatelessWidget {
//   const _ColorAttribute({Key? key, required this.data}) : super(key: key);
//   final PSAttributesSectionData data;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment:
//           ParseEngineLayoutUtils.convertTextAlignToCrossAxisAlignment(
//         data.styledData.textStyleData.alignment,
//       ),
//       children: [
//         Text(
//           'Color: Red',
//           style: data.styledData.textStyleData.createTextStyle(),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment:
//               ParseEngineLayoutUtils.convertTextAlignToMainAxisAlignment(
//             data.styledData.textStyleData.alignment,
//           ),
//           children: [
//             const SizedBox(
//               height: 35,
//               width: 35,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: Color(0xFF42A5F5),
//                   borderRadius: ThemeGuide.borderRadius,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             DecoratedBox(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 2,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 borderRadius: ThemeGuide.borderRadius,
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 35,
//                   width: 35,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Color(0xFFEF5350),
//                       borderRadius: ThemeGuide.borderRadius,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             const SizedBox(
//               height: 35,
//               width: 35,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: Color(0xFF66BB6A),
//                   borderRadius: ThemeGuide.borderRadius,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class _SizeAttribute extends StatelessWidget {
//   const _SizeAttribute({
//     Key? key,
//     required this.data,
//   }) : super(key: key);
//   final PSAttributesSectionData data;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Column(
//       crossAxisAlignment:
//           ParseEngineLayoutUtils.convertTextAlignToCrossAxisAlignment(
//         data.styledData.textStyleData.alignment,
//       ),
//       children: [
//         Text(
//           'Size: L',
//           style: data.styledData.textStyleData.createTextStyle(),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment:
//               ParseEngineLayoutUtils.convertTextAlignToMainAxisAlignment(
//             data.styledData.textStyleData.alignment,
//           ),
//           children: [
//             SizedBox(
//               height: 40,
//               width: 40,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: theme.scaffoldBackgroundColor,
//                   borderRadius: ThemeGuide.borderRadius,
//                 ),
//                 child: const Center(child: Text('S')),
//               ),
//             ),
//             const SizedBox(width: 10),
//             SizedBox(
//               height: 40,
//               width: 40,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: theme.scaffoldBackgroundColor,
//                   borderRadius: ThemeGuide.borderRadius,
//                 ),
//                 child: const Center(child: Text('M')),
//               ),
//             ),
//             const SizedBox(width: 10),
//             DecoratedBox(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 2,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 borderRadius: ThemeGuide.borderRadius,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 40,
//                   width: 40,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: theme.scaffoldBackgroundColor,
//                       borderRadius: ThemeGuide.borderRadius,
//                     ),
//                     child: const Center(child: Text('L')),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
