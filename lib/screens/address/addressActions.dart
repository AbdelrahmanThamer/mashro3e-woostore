// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

import '../../controllers/navigationController.dart';
import '../../controllers/uiController.dart';
import '../../generated/l10n.dart';
import '../../models/address.model.dart';
import '../../themes/theme.dart';
import 'updateAddress.dart';

class AddressActionsAnimated extends StatefulWidget {
  const AddressActionsAnimated({
    Key key,
    @required this.child,
    @required this.address,
  }) : super(key: key);

  final Widget child;
  final Address address;

  @override
  _AddressActionsAnimatedState createState() => _AddressActionsAnimatedState();
}

class _AddressActionsAnimatedState extends State<AddressActionsAnimated> {
  bool showActions = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final lang = S.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          showActions = !showActions;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _theme.disabledColor.withAlpha(10),
          borderRadius: ThemeGuide.borderRadius10,
        ),
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: showActions ? 50 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Text(
                    lang.actions,
                    style: _theme.textTheme.headline6,
                  ),
                  const Spacer(),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _edit(context, widget.address);
                    },
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _delete(context, widget.address);
                    },
                  ),
                ],
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }

  static void _edit(BuildContext context, Address address) {
    UiController.showModal(
      context: context,
      child: UpdateAddress(
        isShipping: true,
        address: address,
      ),
    );
  }

  static void _delete(BuildContext context, Address address) {
    showDialog(
      context: context,
      builder: (context) {
        return _ConfirmDeleteDialog(address: address);
      },
    );
  }
}

class _ConfirmDeleteDialog extends StatelessWidget {
  const _ConfirmDeleteDialog({
    Key key,
    @required this.address,
  }) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return AlertDialog(
      title: Text(lang.deleteAddressQuestion),
      shape: const RoundedRectangleBorder(
        borderRadius: ThemeGuide.borderRadius10,
      ),
      actions: <Widget>[
        InkWell(
          radius: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Text(
              lang.yes,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onTap: _yesFun,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Text(
              lang.no,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onTap: _noFun,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }

  static void _yesFun() {
    NavigationController.navigator.pop();
  }

  static void _noFun() {
    NavigationController.navigator.pop();
  }
}
