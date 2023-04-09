// // Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
// // All Rights Reserved.
// //
// // NOTICE: All information contained herein is, and remains the
// // property of Aniket Malik. The intellectual and technical concepts
// // contained herein are proprietary to Aniket Malik and are protected
// // by trade secret or copyright law.
// //
// // Dissemination of this information or reproduction of this material
// // is strictly forbidden unless prior written permission is obtained from
// // Aniket Malik.
//
// // @dart=2.9
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../locator.dart';
// import '../../../providers/utils/viewStateController.dart';
// import '../models/customSectionData.dart';
// import '../viewModel/homeViewModel.dart';
// import 'customSections/advancedPromotionSection.dart';
// import 'customSections/bannerSection.dart';
// import 'customSections/categories/categories_section.dart';
// import 'customSections/external_link/advancedPromotionSection.dart';
// import 'customSections/external_link/bannerSection.dart';
// import 'customSections/external_link/promotionSection.dart';
// import 'customSections/external_link/sliderSection.dart';
// import 'customSections/promotionSection.dart';
// import 'customSections/regularSection.dart';
// import 'customSections/saleSection.dart';
// import 'customSections/single_product/advancedPromotionSection.dart';
// import 'customSections/single_product/bannerSection.dart';
// import 'customSections/single_product/promotionSection.dart';
// import 'customSections/single_product/sliderSection.dart';
// import 'customSections/sliderSection.dart';
// import 'customSections/tags_section.dart';
//
// class SectionsView extends StatelessWidget {
//   const SectionsView({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<HomeViewModel>.value(
//       value: LocatorService.homeViewModel(),
//       child: const _View(),
//     );
//   }
// }
//
// class _View extends StatelessWidget {
//   const _View({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverViewStateController<HomeViewModel>(
//       fetchData: LocatorService.homeViewModel().fetchSections,
//       builder: () {
//         return Selector<HomeViewModel, List>(
//           selector: (context, d) => d.sectionsList,
//           shouldRebuild: (a, b) => a.length != b.length,
//           builder: (context, list, child) {
//             return SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, i) {
//                   final CustomSectionData sectionData = list[i];
//                   if (sectionData.sectionType == SectionType.undefined) {
//                     return const SizedBox();
//                   }
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 15),
//                     child: _renderSection(sectionData),
//                   );
//                 },
//                 childCount: list.length,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   /// Returns the actual widget for the RuntimeType of the section
//   Widget _renderSection(CustomSectionData data) {
//     switch (data.runtimeType) {
//       case RegularSectionData:
//         return RegularSectionProducts(sectionData: data);
//         break;
//       case BannerSectionData:
//         return BannerSectionProducts(sectionData: data);
//         break;
//       case BannerExternalLinkSectionData:
//         return BannerExternalLinkSectionProducts(sectionData: data);
//         break;
//       case BannerSingleProductSectionData:
//         return BannerSingleProductSectionProducts(sectionData: data);
//         break;
//       case SaleSectionData:
//         return SaleSectionProducts(sectionData: data);
//         break;
//       case PromotionSectionData:
//         return PromotionSectionProducts(sectionData: data);
//         break;
//       case PromotionExternalLinkSectionData:
//         return PromotionExternalLinkSectionProducts(sectionData: data);
//         break;
//       case PromotionSingleProductSectionData:
//         return PromotionSingleProductSectionProducts(sectionData: data);
//         break;
//       case SliderSectionData:
//         return SliderSectionProducts(sectionData: data);
//         break;
//       case SliderExternalLinkSectionData:
//         return SliderExternalLinkSectionProducts(sectionData: data);
//         break;
//       case SliderSingleProductSectionData:
//         return SliderSingleProductSectionProducts(sectionData: data);
//         break;
//       case AdvancedPromotionSectionData:
//         return AdvancedPromotionSection(sectionData: data);
//         break;
//       case AdvancedPromotionExternalLinkSectionData:
//         return AdvancedPromotionExternalLinkSectionProducts(sectionData: data);
//         break;
//       case AdvancedPromotionSingleProductSectionData:
//         return AdvancedPromotionSingleProductSectionProducts(sectionData: data);
//         break;
//       case CategoriesSectionData:
//         return CategoriesSection(sectionData: data);
//         break;
//       case TagsSectionData:
//         return TagsSection(sectionData: data);
//         break;
//       default:
//         return const SizedBox();
//     }
//   }
// }
