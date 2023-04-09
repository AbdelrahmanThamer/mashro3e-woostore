// // Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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
// import 'package:am_common_packages/am_common_packages.dart';
// import 'package:device_frame/device_frame.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../ui/buttons/buttons.dart';
// import '../../../ui/list_items/list_items.dart';
// import '../editor.dart';
// import 'engine/engine.dart';
// import 'state/state.dart';
//
// class EditorPreview extends StatelessWidget {
//   const EditorPreview({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       margin: ThemeGuide.marginH5,
//       padding: ThemeGuide.padding10,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: theme.colorScheme.background,
//         borderRadius: ThemeGuide.borderRadius10,
//       ),
//       child: const _DeviceView(),
//     );
//   }
// }
//
// class _DeviceView extends ConsumerWidget {
//   const _DeviceView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(previewStateNotifierProvider);
//     final notifier = ref.read(previewStateNotifierProvider.notifier);
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: Theme.of(context).scaffoldBackgroundColor,
//             borderRadius: ThemeGuide.borderRadius10,
//           ),
//           child: Row(
//             children: [
//               _SelectScreen(
//                 onSelected: (selectedScreen) {
//                   notifier.updateSelectedScreen(selectedScreen);
//                 },
//               ),
//               const Spacer(),
//               IconButton(
//                 tooltip: 'Choose Device',
//                 icon: const Icon(Icons.smartphone_rounded),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (_) {
//                       return const _DevicePickerDialog();
//                     },
//                   );
//                 },
//               ),
//               IconButton(
//                 tooltip: 'Toggle Theme',
//                 icon: const Icon(Icons.color_lens_rounded),
//                 onPressed: () => notifier.updateThemeMode(
//                   state.themeMode == ThemeMode.dark
//                       ? ThemeMode.light
//                       : ThemeMode.dark,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Expanded(
//           child: DeviceFrame(
//             orientation: Orientation.portrait,
//             device: state.selectedDevice,
//             screen: const _Body(),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _Body extends ConsumerWidget {
//   const _Body({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final erp = ref.read(providerOfEditorRepository);
//     final previewState = ref.watch(previewStateNotifierProvider);
//     ref.listen<PreviewState>(previewStateNotifierProvider, (a, b) {
//       if (a?.selectedScreen.id == b.selectedScreen.id) {
//         return;
//       }
//
//       if (b.selectedScreen.appScreenLayoutType !=
//           AppScreenLayoutType.undefined) {
//         if (b.selectedScreen.screenType == AppScreenType.preBuilt) {
//           ParseEngine.globalNavigatorKey.currentState!.pushNamed(
//             'screen',
//             arguments: {'screenId': b.selectedScreen.id},
//           );
//         } else {
//           ParseEngine.globalNavigatorKey.currentState!.pushNamed(
//             'screen',
//             arguments: {'screenId': b.selectedScreen.id},
//           );
//         }
//       } else {
//         ParseEngine.globalNavigatorKey.currentState!.popUntil(
//           ModalRoute.withName('tabbar'),
//         );
//       }
//     });
//     return ValueListenableBuilder<AppTemplate>(
//       valueListenable: erp.appTemplateNotifier,
//       builder: (context, template, _) {
//         if (template.appTabs.isEmpty) {
//           return const SizedBox();
//         }
//         ParseEngine.setTemplate = template;
//         return Theme(
//           data: previewState.themeMode == ThemeMode.dark
//               ? template.appThemes.darkThemeData.createThemeData()
//               : template.appThemes.lightThemeData.createThemeData(),
//           child: SafeArea(
//             child: Navigator(
//               key: ParseEngine.globalNavigatorKey,
//               initialRoute: 'tabbar',
//               onGenerateRoute: (settings) {
//                 switch (settings.name) {
//                   case 'tabbar':
//                     return CupertinoPageRoute(
//                       settings: const RouteSettings(name: 'tabbar'),
//                       builder: (_) => ParseEngine.createTabbedBody(),
//                     );
//
//                   case 'screen':
//                     try {
//                       return CupertinoPageRoute(
//                         settings: const RouteSettings(name: 'screen'),
//                         builder: (_) => ParseEngine.createScreen(
//                           ParseEngine.loadScreen(
//                               (settings.arguments as Map)['screenId']),
//                         ),
//                       );
//                     } catch (e) {
//                       return CupertinoPageRoute(
//                         builder: (_) => const Center(
//                             child: Text('Screen Id argument is required')),
//                       );
//                     }
//                   default:
//                     return CupertinoPageRoute(
//                       builder: (_) =>
//                           const Center(child: Text('Unknown route')),
//                     );
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _SelectScreen extends ConsumerWidget {
//   const _SelectScreen({
//     Key? key,
//     required this.onSelected,
//   }) : super(key: key);
//   final void Function(AppScreenData) onSelected;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final editorRepo = ref.watch(providerOfEditorRepository);
//     final previewState = ref.watch(previewStateNotifierProvider);
//     return HoverButton(
//       tooltip: 'Select Screen',
//       child: Text(previewState.selectedScreen.appScreenLayoutType ==
//               AppScreenLayoutType.undefined
//           ? 'TabBar'
//           : previewState.selectedScreen.name),
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (_) {
//             return Dialog(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: ThemeGuide.borderRadius16,
//               ),
//               child: SizedBox(
//                 height: 500,
//                 width: 500,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Text(
//                         'Select Screen',
//                         style: TextStyle(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                     const Divider(height: 10, thickness: 2),
//                     HoverListItem(
//                       child: const Text('Tabbar'),
//                       onPressed: () {
//                         onSelected(const EmptyScreenData());
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         padding: const EdgeInsets.only(bottom: 100),
//                         itemCount: editorRepo.appTemplate.appScreens.length,
//                         itemBuilder: (_, i) {
//                           return HoverListItem(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   editorRepo.appTemplate.appScreens[i].name,
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   'ID: ${editorRepo.appTemplate.appScreens[i].id}',
//                                   style: const TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             onPressed: () {
//                               onSelected(editorRepo.appTemplate.appScreens[i]);
//                               Navigator.of(context).pop();
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
// class _DevicePickerDialog extends ConsumerWidget {
//   const _DevicePickerDialog({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.watch(previewStateNotifierProvider.notifier);
//     return Dialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: ThemeGuide.borderRadius16,
//       ),
//       child: SizedBox(
//         height: 500,
//         width: 500,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'Select Device',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             Expanded(
//               child: CustomScrollView(
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'iOS',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Divider(
//                             height: 20,
//                             thickness: 2,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverList(
//                     delegate: SliverChildListDelegate(
//                       [
//                         Devices.ios.iPhone13ProMax,
//                         Devices.ios.iPhone13,
//                         Devices.ios.iPhone13Mini,
//                         Devices.ios.iPhone12ProMax,
//                         Devices.ios.iPhone12,
//                         Devices.ios.iPhone12Mini,
//                       ].map<Widget>((e) {
//                         return HoverListItem(
//                           onPressed: () {
//                             notifier.updateDeviceFrame(e);
//                             Navigator.of(context).pop();
//                           },
//                           child: Text(e.name),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   const SliverToBoxAdapter(
//                     child: SizedBox(height: 20),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Android',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Divider(
//                             height: 20,
//                             thickness: 2,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverList(
//                     delegate: SliverChildListDelegate(
//                       [
//                         Devices.android.samsungGalaxyNote20Ultra,
//                         Devices.android.samsungGalaxyNote20,
//                         Devices.android.samsungGalaxyS20,
//                         Devices.android.samsungGalaxyA50,
//                         Devices.android.onePlus8Pro,
//                         Devices.android.sonyXperia1II,
//                         Devices.android.bigPhone,
//                         Devices.android.mediumPhone,
//                         Devices.android.smallPhone,
//                       ].map<Widget>((e) {
//                         return HoverListItem(
//                           onPressed: () {
//                             notifier.updateDeviceFrame(e);
//                             Navigator.of(context).pop();
//                           },
//                           child: Text(e.name),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   const SliverToBoxAdapter(
//                     child: SizedBox(height: 50),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
