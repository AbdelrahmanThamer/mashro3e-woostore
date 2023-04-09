// Copyright (c) 2021 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:woocommerce/models/customer_download.dart';

import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../models/models.dart';
import '../../shared/customLoader.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import '../../shared/widgets/user/noUserFound.dart';
import '../../themes/theme.dart';
import 'viewModel/viewModel.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = LocatorService.userProvider().user;
    final lang = S.of(context);
    return ChangeNotifierProvider<DownloadsViewModel>(
      create: (context) => DownloadsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(lang.downloads),
          actions: const [_ReloadAction()],
        ),
        body: user != null &&
                user.wooCustomer != null &&
                user.wooCustomer.id != null
            ? const _Body()
            : const NoUserFoundWithImage(),
      ),
    );
  }
}

class _ReloadAction extends StatelessWidget {
  const _ReloadAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh_rounded),
      onPressed: Provider.of<DownloadsViewModel>(context, listen: false)
          .fetchDownloads,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadsViewModel>(
      builder: (context, p, _) {
        if (p.isLoading) {
          return const CustomLoader();
        }

        if (p.isError) {
          return Center(
            child: Text(S.of(context).somethingWentWrong),
          );
        }

        if (p.isSuccess && p.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: ThemeGuide.padding10,
            alignment: Alignment.center,
            child: _RenderDownloads(downloads: p.downloads),
          );
        }
        return const NoDataAvailableImage();
      },
    );
  }
}

class _RenderDownloads extends StatelessWidget {
  const _RenderDownloads({Key key, @required this.downloads}) : super(key: key);
  final List<WooCustomerDownload> downloads;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LimitedBox(
      maxHeight: 400,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: downloads.length,
        itemBuilder: (context, i) {
          return _RenderDownloadsListItem(
              theme: theme, downloadItem: downloads[i]);
        },
      ),
    );
  }
}

class _RenderDownloadsListItem extends StatelessWidget {
  const _RenderDownloadsListItem({
    Key key,
    @required this.theme,
    @required this.downloadItem,
  }) : super(key: key);

  final ThemeData theme;
  final WooCustomerDownload downloadItem;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Container(
      margin: ThemeGuide.marginV5,
      padding: ThemeGuide.padding12,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: ThemeGuide.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            downloadItem.productName ?? lang.notAvailable,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _Row(label: lang.name, value: downloadItem.downloadName),
          const SizedBox(height: 2),
          _Row(label: lang.accessExpires, value: downloadItem.accessExpires),
          const SizedBox(height: 2),
          _Row(
            label: lang.downloadsRemaining,
            value: downloadItem.downloadsRemaining,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => openDownloadLink(downloadItem.downloadUrl),
            icon: const Icon(EvaIcons.downloadOutline),
            label: Text(lang.download),
          ),
        ],
      ),
    );
  }

  Future<void> openDownloadLink(String url) async {
    if (url == null) {
      return;
    }

    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    }
  }
}

class _Row extends StatelessWidget {
  const _Row({Key key, this.label, this.value}) : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label ?? ''),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
