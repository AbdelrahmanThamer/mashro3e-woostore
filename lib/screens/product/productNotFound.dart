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

import 'package:flutter/material.dart';

import '../../app_builder/app_builder.dart';
import '../../controllers/navigationController.dart';
import '../../generated/l10n.dart';
import '../../locator.dart';
import '../../shared/customLoader.dart';
import '../../shared/widgets/error/errorReload.dart';

class ProductNotFound extends StatelessWidget {
  const ProductNotFound({
    Key? key,
    required this.productId,
    required this.screenData,
  }) : super(key: key);

  final AppProductScreenData screenData;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _Body(productId: productId, screenData: screenData),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.productId,
    required this.screenData,
  }) : super(key: key);

  final AppProductScreenData screenData;
  final String productId;

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
    // fetch the product
    final result = await LocatorService.productsProvider()
        .fetchProductsById([int.parse(widget.productId)]);

    if (result.isNotEmpty) {
      await NavigationController.navigator.pop();
      await Future.delayed(const Duration(milliseconds: 100));
      NavigationController.navigator.push(
        ProductDetailsScreenLayoutRoute(
          id: widget.productId,
          // screenData: widget.screenData,
        ),
      );
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const CustomLoader();
    }

    return ErrorReload(
      errorMessage: S.of(context).somethingWentWrong,
      reloadFunction: init,
    );
  }
}
