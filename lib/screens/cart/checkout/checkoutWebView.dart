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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controllers/uiController.dart';
import '../../../developer/dev.log.dart';
import '../../../generated/l10n.dart';
import '../../../locator.dart';
import 'viewModel/viewModel.dart';
import 'widgets/payment.dart';

class CheckoutWebView extends StatelessWidget {
  const CheckoutWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ChangeNotifierProvider<CheckoutWebViewModel>(
      create: (context) => CheckoutWebViewModel(),
      builder: (context, snapshot) {
        return _HandleBack(
          child: Scaffold(
            appBar: AppBar(
              title: Text(lang.checkout),
              bottom: const _ProgressIndicator(),
            ),
            bottomNavigationBar: const _NavigationControls(),
            body: const _Body(),
          ),
        );
      },
    );
  }
}

class _HandleBack extends StatelessWidget {
  const _HandleBack({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Selector<CheckoutWebViewModel, bool>(
      selector: (context, d) => d.isLoading,
      builder: (context, loading, w) {
        return WillPopScope(
          child: w!,
          onWillPop: () async {
            if (loading) {
              UiController.showNotification(
                context: context,
                title: lang.processing,
                message: lang.checkoutProcessingMessage,
                color: Colors.red,
              );
              return Future.value(false);
            }
            return Future.value(true);
          },
        );
      },
      child: child,
    );
  }
}

class _ProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const _ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CheckoutWebViewModel, bool>(
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
    final lang = S.of(context);
    return Consumer<CheckoutWebViewModel>(
      builder: (context, provider, _) {
        if (provider.isCheckoutSuccessful) {
          return const PaymentSuccessful();
        }
        if (provider.isSuccess) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewController) async {
              provider.controller.complete(webViewController);

              if (isNotBlank(LocatorService.userProvider().user.id)) {
                try {
                  Dev.debug('Attempt to set user auth token');
                  final String? token =
                      await LocatorService.wooService().wc.getAuthTokenFromDb();
                  if (token != null && token.isNotEmpty) {
                    provider.url += '&jwt=$token';
                    Dev.debug('User auth token set');
                  } else {
                    Dev.warn('User Auth token is empty');
                  }
                } catch (e, s) {
                  Dev.error('Auth Token Set Error', error: e, stackTrace: s);
                }
              } else {
                // change the url as well
                Dev.debug('No user found, changing the URL');
                // set the cart contents and load the cart from
                // those contents
                try {
                  final list =
                      LocatorService.cartViewModel().createOrderWPILineItems();
                  final cartPayloadMap = {
                    'line_items': list.map((e) => e.toJson()).toList(),
                    'coupon_code': LocatorService.cartViewModel()
                        .selectedCoupon
                        .value
                        .code,
                    'customer_note':
                        LocatorService.cartViewModel().customerNote,
                  };

                  final jsonString = jsonEncode(cartPayloadMap);
                  provider.url +=
                      '&cart_data=${Uri.encodeComponent(jsonString)}';
                } catch (e, s) {
                  Dev.error('cannot create cart data', error: e, stackTrace: s);
                }
              }

              try {
                // Load the actual url with the auth headers specified
                print(provider.url);
                webViewController.loadUrl(provider.url);
              } catch (e, s) {
                Dev.error('WebView Load error', error: e, stackTrace: s);
                provider.updateError(lang.somethingWentWrong);
              }
            },
            onWebResourceError: (error) {
              provider.updateError(
                error.description,
              );
            },
            onPageStarted: (_) {
              provider.updateLoading(true);
            },
            onPageFinished: (url) async {
              provider.checkStatus(url);
            },
            gestureNavigationEnabled: true,
          );
        } else if (provider.isError) {
          return Center(
            child: Text(provider.errorMessage ?? lang.somethingWentWrong),
          );
        } else {
          return const SizedBox();
        }
      },
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
      child: Consumer<CheckoutWebViewModel>(builder: (context, provider, w) {
        if (provider.isCheckoutSuccessful) {
          return const SizedBox();
        }
        return FutureBuilder<WebViewController>(
          future: provider.controller.future,
          builder: (
            BuildContext context,
            AsyncSnapshot<WebViewController> snapshot,
          ) {
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
