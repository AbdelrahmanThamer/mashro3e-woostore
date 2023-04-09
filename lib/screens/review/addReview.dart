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
import 'dart:io';
import 'dart:math';

import 'package:am_common_packages/am_common_packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../constants/config.dart';
import '../../controllers/navigationController.dart';
import '../../controllers/uiController.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../models/models.dart';
import '../../services/woocommerce/woocommerce.service.dart';
import '../../shared/authScreenWidgets/authSreenWidgets.dart';
import '../../utils/utils.dart';
import '../product/viewModel/productViewModel.dart';

class AddReview extends StatelessWidget {
  const AddReview({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  final PVMReviewNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ChangeNotifierProvider<PVMReviewNotifier>.value(
      value: notifier,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 120,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: ThemeGuide.borderRadius20,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: ThemeGuide.listPadding,
              children: [
                Row(
                  children: [
                    Text(
                      lang.addReview,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const CloseButton(onPressed: _close),
                  ],
                ),
                const SizedBox(height: 10),
                if (notifier.currentProduct != null)
                  _Form(product: notifier.currentProduct!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _close() {
    NavigationController.navigator.pop();
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final GlobalKey<FormBuilderState> fKey = GlobalKey<FormBuilderState>();

  bool isLoading = false;
  bool isError = false;
  String errorText = '';

  // Information of the user
  User? user;

  // Rating
  double ratingCount = 5;

  Set<File>? images;

  @override
  void initState() {
    super.initState();
    user = LocatorService.userProvider().user;
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    bool showName = true;
    bool showEmail = true;

    if (user != null) {
      if (isNotBlank(user!.name)) {
        showName = false;
      }
      if (isNotBlank(user!.email)) {
        showEmail = false;
      }
    }

    return FormBuilder(
      key: fKey,
      child: Column(
        children: [
          if (showName)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(hintText: lang.name),
                maxLines: 1,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                  FormBuilderValidators.maxLength(50),
                ]),
              ),
            ),
          if (showEmail)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(hintText: lang.emailLabel),
                maxLines: 1,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: FormBuilderTextField(
              name: 'review',
              decoration: InputDecoration(hintText: lang.writeAReview + ' ...'),
              maxLines: 10,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(10),
              ]),
            ),
          ),
          if (kEnablePhotoReviewPluginSupport)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: ThemeGuide.borderRadius10,
              ),
              child: Row(
                children: [
                  Text('${lang.add} ${lang.image}'),
                  const Spacer(),
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          if (kEnablePhotoReviewPluginSupport &&
              images != null &&
              images!.isNotEmpty)
            _ImagesWidget(
              images: images!,
              onUpdate: (imagesSet) {
                if (imagesSet.isEmpty) {
                  images = null;
                } else {
                  images = imagesSet;
                }
                if (mounted) {
                  setState(() {});
                }
              },
            ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: ThemeGuide.borderRadius10,
            ),
            child: Row(
              children: [
                Text(lang.rating),
                const Spacer(),
                RatingBar.builder(
                  glow: false,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) => ratingCount = rating,
                ),
              ],
            ),
          ),
          if (isError) ShowError(text: errorText),
          SafeArea(
            child: Submit(
              isLoading: isLoading,
              onPress: submit,
              label: lang.submit,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    final provider = Provider.of<PVMReviewNotifier>(context, listen: false);
    if (fKey.currentState!.saveAndValidate()) {
      setState(() {
        isLoading = !isLoading;
      });
      try {
        // if images is not empty then convert them to base64 images
        final Set<String>? imageBase64List = await _convertImages(images);

        final WooProductReview review = WooProductReview(
          id: Random().nextInt(1000000),
          productId: int.tryParse(widget.product.id.toString()),
          rating: ratingCount.toInt(),
          review: fKey.currentState!.value['review'],
          reviewer: user?.name ?? fKey.currentState!.value['name'],
          reviewerEmail: user?.email ?? fKey.currentState!.value['email'],
          images: imageBase64List?.toList(),
        );

        final WooProductReview? result =
            await LocatorService.wooService().wc.createProductReviewWithApi(
                  productId: review.productId!,
                  reviewer: review.reviewer!,
                  reviewerEmail: review.reviewerEmail!,
                  review: review.review!,
                  rating: review.rating,
                  images: imageBase64List?.toList(),
                );

        if (result is WooProductReview) {
          setState(() {
            isLoading = !isLoading;
            errorText = '';
            isError = false;
          });

          // Add review to list
          provider.addToReviews(result);

          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }

          final lang = S.of(context);

          UiController.showNotification(
            context: context,
            title: lang.success,
            message: '${lang.addReview} ${lang.success}',
            color: Colors.green,
          );
          return;
        }

        setState(() {
          isLoading = !isLoading;
          errorText = '';
          isError = false;
        });
      } catch (e) {
        setState(() {
          isLoading = !isLoading;
          errorText = Utils.renderException(e);
          isError = true;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      if (mounted) {
        setState(() {
          isError = false;
          errorText = '';
        });
      }

      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (images == null) {
          images ??= {};
          images!.add(File(image.path));
        } else {
          images!.add(File(image.path));
        }
        isError = false;
        errorText = '';
        if (mounted) {
          setState(() {});
        }
      } else {
        throw Exception('Could not get the image');
      }
    } catch (e, s) {
      Dev.error('pick image add review error', error: e, stackTrace: s);
      if (mounted) {
        setState(() {
          isError = true;
          errorText = 'Unable to pick image, try again';
        });
      }
    }
  }

  Future<Set<String>?> _convertImages(Set<File>? imagesSet) async {
    if (imagesSet == null || imagesSet.isEmpty) {
      return null;
    }

    final Set<String> temp = {};
    for (final file in imagesSet) {
      final List<int> imageBytes = await file.readAsBytes();
      temp.add(base64Encode(imageBytes));
    }
    return temp;
  }
}

class _ImagesWidget extends StatelessWidget {
  const _ImagesWidget({
    Key? key,
    required this.images,
    required this.onUpdate,
  }) : super(key: key);
  final Set<File> images;
  final void Function(Set<File>) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 180,
                width: 180,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: ThemeGuide.borderRadius,
                      child: Image.file(
                        images.elementAt(index),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: GestureDetector(
                        onTap: () {
                          final temp = images;
                          temp.remove(images.elementAt(index));
                          onUpdate(temp);
                        },
                        child: Container(
                          padding: ThemeGuide.padding,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: ThemeGuide.borderRadius,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
