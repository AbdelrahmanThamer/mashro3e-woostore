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
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../constants/config.dart';
import '../../controllers/navigationController.dart';
import '../../controllers/uiController.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../services/woocommerce/woocommerce.service.dart';
import '../../shared/customLoader.dart';
import '../../shared/widgets/error/errorReload.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import '../../utils/utils.dart';
import '../product/photoView/photoView.dart';
import '../product/viewModel/productViewModel.dart';
import 'addReview.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ChangeNotifierProvider(
      create: (context) => PVMReviewNotifier(productId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(lang.allReviews),
        ),
        body: const _ListContainer(),
        bottomNavigationBar: Builder(builder: (context) {
          return Provider.of<PVMReviewNotifier>(context)
                      .currentProduct
                      ?.wooProduct
                      .reviewsAllowed ??
                  false
              ? const Padding(
                  padding: ThemeGuide.padding16,
                  child: _AddReviewButton(),
                )
              : const SizedBox();
        }),
      ),
    );
  }
}

class _ListContainer extends StatelessWidget {
  const _ListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Consumer<PVMReviewNotifier>(
        builder: (context, p, w) {
          if (p.isLoading) {
            return const Center(child: CustomLoader());
          } else if (p.isError && !p.hasData) {
            return ErrorReload(
              errorMessage: p.errorMessage,
              reloadFunction: p.fetchProductReviews,
            );
          } else if (p.isSuccess && !p.hasData) {
            return w!;
          } else {
            return RefreshIndicator(
              onRefresh: p.onRefresh,
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  itemCount: p.reviews.length,
                  itemBuilder: (context, i) {
                    return _ReviewRowContainer(review: p.reviews[i]);
                  },
                ),
              ),
            );
          }
        },
        child: const NoDataAvailableImage(),
      ),
    );
  }
}

class _AddReviewButton extends StatelessWidget {
  const _AddReviewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: GradientButton(
          onPress: () {
            if (isBlank(LocatorService.userProvider().user.id)) {
              UiController.showErrorNotification(
                context: context,
                title: '${lang.no} ${lang.user}',
                message:
                    '${lang.login} ${lang.toLowerCase} ${lang.add} ${lang.review}',
              );
            } else {
              UiController.showModal(
                context: context,
                child: AddReview(
                  notifier: Provider.of<PVMReviewNotifier>(
                    context,
                    listen: false,
                  ),
                ),
              );
            }
          },
          child: Text(
            lang.addReview,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewRowContainer extends StatelessWidget {
  const _ReviewRowContainer({
    Key? key,
    required this.review,
  }) : super(key: key);

  final WooProductReview review;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    String? rating;

    if (review.rating != null) {
      rating = review.rating.toString();
    }

    String date = '';
    if (isNotBlank(review.dateCreated)) {
      final parsedDate = DateTime.parse(review.dateCreated!);
      date = DateFormat('d MMM \'\'yy h:mm a').format(parsedDate);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _theme.disabledColor.withAlpha(10),
        borderRadius: ThemeGuide.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (rating != null)
            Row(
              children: [
                Text(
                  review.reviewer ?? lang.name,
                  style: _theme.textTheme.subtitle1,
                ),
                if (date.isNotEmpty)
                  Text(
                    ' ${String.fromCharCode(0x2022)} $date',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF757575),
                      fontSize: 12,
                    ),
                  ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  color: Color(0xFFFBC02D),
                  size: 20,
                ),
                Text(
                  rating,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            )
          else
            Text(
              review.reviewer ?? lang.name,
              style: _theme.textTheme.subtitle1,
            ),
          const SizedBox(height: 8),
          Text(Utils.removeAllHtmlTags(review.review)),
          if (kEnablePhotoReviewPluginSupport &&
              review.images != null &&
              review.images!.isNotEmpty)
            _ShowImageWidget(images: review.images!),
        ],
      ),
    );
  }
}

class _ShowImageWidget extends StatelessWidget {
  const _ShowImageWidget({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: ExpandableThemeData(
        iconColor: Theme.of(context).iconTheme.color,
        headerAlignment: ExpandablePanelHeaderAlignment.center,
      ),
      controller: ExpandableController(initialExpanded: true),
      collapsed: const SizedBox(),
      expanded: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                NavigationController.navigator.pushWidget(
                  GalleryPhotoViewWrapper(images: images, initialIndex: index),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 180,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: ThemeGuide.borderRadius,
                    child: ExtendedCachedImage(imageUrl: images[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
