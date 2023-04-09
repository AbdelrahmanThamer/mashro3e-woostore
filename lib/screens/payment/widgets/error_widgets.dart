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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../themes/theme.dart';
import '../view_model/view_model.dart';

class PaymentInvalidOrder extends StatelessWidget {
  const PaymentInvalidOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox.expand(
      child: Padding(
        padding: ThemeGuide.padding16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                '${lang.invalid} ${lang.order}',
                style: const TextStyle(
                  color: Color(0xFFD32F2F),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Flexible(child: SizedBox(height: 10)),
            Flexible(
              child: Text(
                '${lang.order} ${lang.notAvailable}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            const _RetryButton(),
          ],
        ),
      ),
    );
  }
}

class PaymentInvalidUser extends StatelessWidget {
  const PaymentInvalidUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return SizedBox.expand(
      child: Padding(
        padding: ThemeGuide.padding16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                '${lang.invalid} ${lang.user}',
                style: const TextStyle(
                  color: Color(0xFFD32F2F),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Flexible(child: SizedBox(height: 10)),
            Flexible(
              child: Text(
                '${lang.user} ${lang.notAvailable}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            const _RetryButton(),
          ],
        ),
      ),
    );
  }
}

class PaymentInvalidJWT extends StatelessWidget {
  const PaymentInvalidJWT({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: ThemeGuide.padding20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Flexible(
              child: Text(
                'JWT Auth bad config',
                style: TextStyle(
                  color: Color(0xFFD32F2F),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(child: SizedBox(height: 10)),
            Flexible(
              child: Text(
                'JWT secret key is not configured properly on the server',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            _RetryButton(),
          ],
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(S.of(context).retry),
      onPressed:
          Provider.of<PaymentWebViewModel>(context, listen: false).retryPayment,
    );
  }
}
