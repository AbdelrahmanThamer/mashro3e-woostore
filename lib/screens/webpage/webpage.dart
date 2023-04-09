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
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app_builder/app_builder.dart';
import '../../constants/wooConfig.dart';
import '../../controllers/uiController.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../shared/app_bar/app_bar.dart';
import 'view_model.dart';

class WebpageScreenLayout extends StatelessWidget {
  const WebpageScreenLayout({Key? key, required this.screenData})
      : super(key: key);
  final AppWebpageScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WebpageScreenLayoutViewModel>(
      create: (context) => WebpageScreenLayoutViewModel(
        '${screenData.url}?k=0',
      ),
      child: Scaffold(
        bottomNavigationBar: const _NavigationControls(),
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            if (screenData.appBarData.show)
              SliverAppBarLayout(
                data: screenData.appBarData,
                bottomWidget: const _ProgressIndicator(),
              ),
            if (screenData.appBarData.show)
              const SliverFillRemaining(child: _Body())
            else
              const SliverFillRemaining(
                child: SafeArea(top: true, bottom: true, child: _Body()),
              )
          ],
        ),
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const _ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<WebpageScreenLayoutViewModel, bool>(
      selector: (context, d) => d.isLoading,
      builder: (context, loading, child) {
        if (loading) {
          return child!;
        } else {
          return const SizedBox();
        }
      },
      child: const LinearProgressIndicator(minHeight: 4),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(4);
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool allowAutoLogin = true;
    final provider =
        Provider.of<WebpageScreenLayoutViewModel>(context, listen: false);
    String url = provider.initialUrl;

    // check if the initial url is the same as the website url
    try {
      if (provider.initialUrl.contains(WooConfig.wordPressUrl)) {
        allowAutoLogin = true;
      } else {
        allowAutoLogin = false;
      }
    } catch (e, s) {
      Dev.error(
        'Could not check for url similarity for auto login',
        error: e,
        stackTrace: s,
      );
    }

    if (allowAutoLogin) {
      url =
          '${WooConfig.wordPressUrl}/wp-json/woostore_pro_api/flutter_user/login_and_redirect?redirect_url=${provider.initialUrl}';
    }
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (webViewController) async {
        provider.controller.complete(webViewController);

        if (allowAutoLogin &&
            isNotBlank(LocatorService.userProvider().user.id)) {
          try {
            Dev.debug('Attempt to set user auth token');
            final String? token =
                await LocatorService.wooService().wc.getAuthTokenFromDb();
            if (token != null && token.isNotEmpty) {
              url += '&jwt=$token';
              Dev.debug('User auth token set');
            } else {
              Dev.warn('User Auth token is empty');
            }
          } catch (e, s) {
            Dev.error('Auth Token Set Error', error: e, stackTrace: s);
          }
        }

        try {
          webViewController.loadUrl(url);
        } catch (e, s) {
          Dev.error('WebView Load error', error: e, stackTrace: s);
          provider.updateError(S.of(context).somethingWentWrong);
        }
      },
      onWebResourceError: (error) {
        provider.updateError(error.description);
      },
      onPageStarted: (_) {
        provider.updateLoading(true);
      },
      onPageFinished: (url) async {
        provider.onPageFinished(url);
      },
      gestureNavigationEnabled: true,
    );
  }
}

class _NavigationControls extends StatelessWidget {
  const _NavigationControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SafeArea(
      bottom: true,
      child: Consumer<WebpageScreenLayoutViewModel>(
          builder: (context, provider, w) {
        return FutureBuilder<WebViewController>(
          future: provider.controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> snapshot) {
            final bool webViewReady =
                snapshot.connectionState == ConnectionState.done;
            final WebViewController? controller = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: !webViewReady
                      ? null
                      : () async {
                          if (await controller?.canGoBack() ?? false) {
                            await controller?.goBack();
                          } else {
                            UiController.showNotification(
                              context: context,
                              color: Colors.red,
                              title: lang.nothingInHistory,
                              message: lang.nothingInHistoryMessage,
                            );
                            return;
                          }
                        },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: !webViewReady
                      ? null
                      : () async {
                          if (await controller?.canGoForward() ?? false) {
                            await controller?.goForward();
                          } else {
                            UiController.showNotification(
                              context: context,
                              color: Colors.red,
                              title: lang.nothingInForwardHistory,
                              message: lang.nothingInForwardHistoryMessage,
                            );
                            return;
                          }
                        },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 30,
                  ),
                  onPressed: !webViewReady
                      ? null
                      : () {
                          controller?.reload();
                        },
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
