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
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../generated/l10n.dart';
import '../../../services/woocommerce/woocommerce.service.dart';
import '../../../shared/widgets/error/errorReload.dart';
import '../viewModel/view_model.dart';

class VendorMoreInfoModal extends StatelessWidget {
  const VendorMoreInfoModal({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final VendorProductsViewModel provider;

  @override
  Widget build(BuildContext context) {
    bool isVendorDataAvailable = false;
    if (provider.vendor.address != null) {
      isVendorDataAvailable = true;
    }

    return ClipRRect(
      borderRadius: ThemeGuide.borderRadiusBottomSheet,
      child: Scaffold(
        body: !isVendorDataAvailable
            ? _FetchData(provider: provider)
            : _Body(vendor: provider.vendor),
      ),
    );
  }
}

class _FetchData extends StatefulWidget {
  const _FetchData({Key? key, required this.provider}) : super(key: key);
  final VendorProductsViewModel provider;

  @override
  State<_FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<_FetchData> {
  bool isLoading = true;
  String? error;
  Vendor? vendor;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetch();
    });
  }

  Future<void> fetch() async {
    try {
      if (!isLoading) {
        if (mounted) {
          setState(() {
            isLoading = true;
            error = null;
          });
        }
      }

      final result = await widget.provider
          .getCompleteVendorData(widget.provider.vendor.id!);

      if (mounted) {
        setState(() {
          isLoading = false;
          error = null;
          vendor = result;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = ExceptionUtils.renderException(e);
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (isNotBlank(error)) {
      return ErrorReload(errorMessage: error!, reloadFunction: fetch);
    }

    if (vendor != null) {
      return _Body(vendor: vendor!);
    }
    return const SizedBox();
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.vendor,
  }) : super(key: key);
  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Padding(
      padding: ThemeGuide.padding20,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Heading(title: lang.address),
            _Decorator(
              child: _BuildRow(
                icon: const Icon(Icons.location_on_rounded),
                text: Text(
                  '${vendor.address?.street_1 ?? ''} ${vendor.address?.street_2 ?? ''}\n${vendor.address?.city ?? ''}, ${vendor.address?.zip ?? ''}\n${vendor.address?.state ?? ''}, ${vendor.address?.country ?? ''}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _Heading(title: lang.contactUs),
            _Decorator(child: _ContactUs(vendor: vendor)),
          ],
        ),
      ),
    );
  }
}

//**********************************************************
// Helper Widgets
//**********************************************************

class _Heading extends StatelessWidget {
  const _Heading({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title ?? 'NA',
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}

class _Decorator extends StatelessWidget {
  const _Decorator({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ThemeGuide.padding10,
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor.withAlpha(10),
        borderRadius: ThemeGuide.borderRadius10,
      ),
      child: child,
    );
  }
}

class _ContactUs extends StatelessWidget {
  const _ContactUs({Key? key, this.vendor}) : super(key: key);
  final Vendor? vendor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isNotBlank(vendor?.phone))
          GestureDetector(
            onTap: () async {
              try {
                await launchUrlString('tel:${vendor?.phone}');
              } catch (e, s) {
                Dev.error(
                  'Cannot open phone: ${vendor?.phone}',
                  error: e,
                  stackTrace: s,
                );
              }
            },
            child: _BuildRow(
              icon: const Icon(Icons.phone_outlined),
              text: Text(
                vendor?.phone ?? '-',
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        if (isNotBlank(vendor?.phone)) const SizedBox(height: 10),
        if (isNotBlank(vendor?.email))
          GestureDetector(
            onTap: () async {
              try {
                await launchUrlString('mailto:${vendor?.email}');
              } catch (e, s) {
                Dev.error(
                  'Cannot open email: ${vendor?.email}',
                  error: e,
                  stackTrace: s,
                );
              }
            },
            child: _BuildRow(
              icon: const Icon(Icons.email),
              text: Text(
                vendor?.email ?? '-',
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        if (isNotBlank(vendor?.email)) const SizedBox(height: 10),
        Wrap(
          children: [
            if (isNotBlank(vendor?.social?.fb))
              _BuildSocialButton(
                icon: const FaIcon(FontAwesomeIcons.facebook),
                url: vendor!.social!.fb!,
              ),
            if (isNotBlank(vendor?.social?.instagram))
              _BuildSocialButton(
                icon: const FaIcon(FontAwesomeIcons.instagram),
                url: vendor!.social!.instagram!,
              ),
            if (isNotBlank(vendor?.social?.linkedin))
              _BuildSocialButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                url: vendor!.social!.linkedin!,
              ),
            if (isNotBlank(vendor?.social?.pinterest))
              _BuildSocialButton(
                icon: const FaIcon(FontAwesomeIcons.pinterest),
                url: vendor!.social!.pinterest!,
              ),
            if (isNotBlank(vendor?.social?.twitter))
              _BuildSocialButton(
                icon: const FaIcon(FontAwesomeIcons.twitter),
                url: vendor!.social!.twitter!,
              ),
            if (isNotBlank(vendor?.social?.youtube))
              _BuildSocialButton(
                icon: const FaIcon(FontAwesomeIcons.youtube),
                url: vendor!.social!.youtube!,
              ),
            if (isNotBlank(vendor?.social?.flickr))
              _BuildSocialButton(
                icon: const FaIcon(FontAwesomeIcons.flickr),
                url: vendor!.social!.flickr!,
              ),
          ],
        ),
      ],
    );
  }
}

class _BuildSocialButton extends StatelessWidget {
  const _BuildSocialButton({
    Key? key,
    required this.icon,
    required this.url,
  }) : super(key: key);
  final Widget icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: () async {
        try {
          await launchUrlString(url);
        } catch (e, s) {
          Dev.error(
            'Cannot open url: $url',
            error: e,
            stackTrace: s,
          );
        }
      },
    );
  }
}

class _BuildRow extends StatelessWidget {
  const _BuildRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Widget icon;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 16),
        Expanded(child: text),
      ],
    );
  }
}
