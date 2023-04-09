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

import '../../generated/l10n.dart';
import '../../utils/style.dart';

class RenderAttributes extends StatelessWidget {
  const RenderAttributes({Key? key, required this.attributes})
      : super(key: key);
  final Map<dynamic, dynamic> attributes;

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [];

    attributes.forEach((key, value) {
      if (key.toString().toLowerCase() == 'color' ||
          key.toString().toLowerCase() == 'colour') {
        list.add(ItemColorAttributeOption(colorName: value.toString()));
      } else {
        list.add(ItemAttributeOption(name: key, option: value));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }
}

class ItemAttributeOption extends StatelessWidget {
  const ItemAttributeOption({
    Key? key,
    required this.name,
    required this.option,
  }) : super(key: key);
  final String name;
  final String option;

  @override
  Widget build(BuildContext context) {
    final title = _createTitle(context, name);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        '$title:  $option',
        style: UIStyle.isDarkMode(context)
            ? const TextStyle(
                fontSize: 14,
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              )
            : const TextStyle(
                fontSize: 14,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
      ),
    );
  }

  String _createTitle(BuildContext context, String name) {
    final lang = S.of(context);
    if (name.toLowerCase() == 'size' || name.toLowerCase() == 'sizes') {
      return lang.size;
    } else {
      return name;
    }
  }
}

class ItemColorAttributeOption extends StatelessWidget {
  const ItemColorAttributeOption({Key? key, required this.colorName})
      : super(key: key);
  final String colorName;

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Text(
            '${lang.color}:  ',
            style: UIStyle.isDarkMode(context)
                ? const TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                  )
                : const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          // Container(
          //   height: 15,
          //   width: 15,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(2),
          //     color: HexColor(colorName),
          //   ),
          // ),
          // const SizedBox(width: 8),
          FittedBox(
            child: Text(
              colorName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: UIStyle.isDarkMode(context)
                  ? const TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                    )
                  : const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
