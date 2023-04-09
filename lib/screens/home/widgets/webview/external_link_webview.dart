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
// // @dart=2.9
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../../controllers/uiController.dart';
// import '../../../../generated/l10n.dart';
// import 'view_model.dart';
//
// class HomeExternalLinkWebView extends StatelessWidget {
//   const HomeExternalLinkWebView({
//     @required this.externalLink,
//     Key key,
//   }) : super(key: key);
//
//   final String externalLink;
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<HomeExternalLinkWebViewModel>(
//       create: (context) => HomeExternalLinkWebViewModel(externalLink),
//       child: Scaffold(
//         appBar: AppBar(bottom: const _ProgressIndicator()),
//         bottomNavigationBar: const _NavigationControls(),
//         body: const _Body(),
//       ),
//     );
//   }
// }
//
// class _ProgressIndicator extends StatelessWidget
//     implements PreferredSizeWidget {
//   const _ProgressIndicator({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Selector<HomeExternalLinkWebViewModel, bool>(
//       selector: (context, d) => d.isLoading,
//       builder: (context, loading, child) {
//         if (loading) {
//           return child;
//         } else {
//           return const SizedBox();
//         }
//       },
//       child: const LinearProgressIndicator(minHeight: 4),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(4);
// }
//
// class _Body extends StatelessWidget {
//   const _Body({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     final provider =
//         Provider.of<HomeExternalLinkWebViewModel>(context, listen: false);
//     return WebView(
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (webViewController) async {
//         provider.controller.complete(webViewController);
//         webViewController.loadUrl(provider.initialUrl);
//       },
//       onWebResourceError: (error) {
//         provider.updateError(
//           error.description ?? lang.somethingWentWrong,
//         );
//       },
//       onPageStarted: (_) {
//         provider.updateLoading(true);
//       },
//       onPageFinished: (url) async {
//         provider.onPageFinished(url);
//       },
//       gestureNavigationEnabled: true,
//     );
//   }
// }
//
// class _NavigationControls extends StatelessWidget {
//   const _NavigationControls({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final lang = S.of(context);
//     return SafeArea(
//       bottom: true,
//       child: Consumer<HomeExternalLinkWebViewModel>(
//           builder: (context, provider, w) {
//         return FutureBuilder<WebViewController>(
//           future: provider.controller?.future,
//           builder: (BuildContext context,
//               AsyncSnapshot<WebViewController> snapshot) {
//             final bool webViewReady =
//                 snapshot.connectionState == ConnectionState.done;
//             final WebViewController controller = snapshot.data;
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios),
//                   onPressed: !webViewReady
//                       ? null
//                       : () async {
//                           if (await controller.canGoBack()) {
//                             await controller.goBack();
//                           } else {
//                             UiController.showNotification(
//                               context: context,
//                               color: Colors.red,
//                               title: lang.nothingInHistory,
//                               message: lang.nothingInHistoryMessage,
//                             );
//                             return;
//                           }
//                         },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.arrow_forward_ios),
//                   onPressed: !webViewReady
//                       ? null
//                       : () async {
//                           if (await controller.canGoForward()) {
//                             await controller.goForward();
//                           } else {
//                             UiController.showNotification(
//                               context: context,
//                               color: Colors.red,
//                               title: lang.nothingInForwardHistory,
//                               message: lang.nothingInForwardHistoryMessage,
//                             );
//                             return;
//                           }
//                         },
//                 ),
//                 IconButton(
//                   icon: const Icon(
//                     Icons.refresh,
//                     size: 30,
//                   ),
//                   onPressed: !webViewReady
//                       ? null
//                       : () {
//                           controller.reload();
//                         },
//                 ),
//               ],
//             );
//           },
//         );
//       }),
//     );
//   }
// }
