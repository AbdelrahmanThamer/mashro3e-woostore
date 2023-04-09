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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:woocommerce/models/wooPoints.dart';

import '../../developer/dev.log.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../models/models.dart';
import '../../shared/customDivider.dart';
import '../../shared/customLoader.dart';
import '../../shared/widgets/user/noUserFound.dart';
import '../../themes/theme.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = LocatorService.userProvider().user;
    final lang = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.my + ' ' + lang.points),
      ),
      body: user != null &&
              user.wooCustomer != null &&
              user.wooCustomer.id != null
          ? const _Body()
          : const NoUserFoundWithImage(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  bool isLoading = true;
  bool isError = false;
  String message = '';

  WooPoints points;

  @override
  void initState() {
    super.initState();

    if (LocatorService.userProvider().user.points == null) {
      // Call the fetch function
      _fetchPoints();
    } else {
      isLoading = false;
      points = LocatorService.userProvider().user.points;
    }
  }

  Future<void> _fetchPoints() async {
    try {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      }

      // Get the points here
      points = await LocatorService.wooService()
          .wc
          .getPointsById(LocatorService.userProvider().user.wooCustomer.id);

      // Set the user points for caching
      LocatorService.userProvider().user.points = points;
      setState(() {
        isLoading = false;
        isError = false;
        message = '';
      });
    } catch (e, s) {
      Dev.error('FetchPoints error', error: e, stackTrace: s);
      setState(() {
        isLoading = false;
        isError = true;
        message = S.of(context).somethingWentWrong;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CustomLoader();
    }

    if (isError) {
      if (isNotBlank(message)) {
        return Center(
          child: Text(message),
        );
      }
      return Center(
        child: Text(S.of(context).somethingWentWrong),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchPoints,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: ThemeGuide.padding20,
          alignment: Alignment.center,
          child: _RenderPoints(points: points),
        ),
      ),
    );
  }
}

class _RenderPoints extends StatelessWidget {
  const _RenderPoints({
    Key key,
    @required this.points,
  }) : super(key: key);
  final WooPoints points;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/gifs/confetti.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: ThemeGuide.borderRadius20,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Wrap(
                      direction: Axis.vertical,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          child: FittedBox(
                            child: Text(
                              points.pointsBalance?.toString() ?? '0',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          lang.points,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: CustomDivider(),
        ),
        const SizedBox(height: 10),
        Text(
          lang.events,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: _RenderEvents(events: points.events),
        ),
      ],
    );
  }
}

class _RenderEvents extends StatelessWidget {
  const _RenderEvents({Key key, @required this.events}) : super(key: key);
  final List<WooPointsEvent> events;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LimitedBox(
      maxHeight: 400,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: events.length,
        itemBuilder: (context, i) {
          return _RenderEventsListItem(theme: theme, event: events[i]);
        },
      ),
    );
  }
}

class _RenderEventsListItem extends StatelessWidget {
  const _RenderEventsListItem({
    Key key,
    @required this.theme,
    @required this.event,
  }) : super(key: key);

  final ThemeData theme;
  final WooPointsEvent event;

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.description ?? lang.notAvailable,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  event.dateDisplayHuman ?? lang.notAvailable,
                  style: theme.textTheme.caption,
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.red.shade200,
            child: Text(
              event.points,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
