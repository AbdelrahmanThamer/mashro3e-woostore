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

import '../../../../../models/app_template/app_template.dart';
import '../../app_bar/app_bar.dart';

class SinglePostScreenLayout extends StatelessWidget {
  const SinglePostScreenLayout({Key? key, required this.screenData})
      : super(key: key);
  final AppSinglePostScreenData screenData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (screenData.appBarData.show)
            SliverAppBarLayout(data: screenData.appBarData),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 100),
            sliver: SliverToBoxAdapter(child: _PostPreview()),
          ),
        ],
      ),
    );
  }
}

class _PostPreview extends StatelessWidget {
  const _PostPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: ThemeGuide.padding10,
          child: Text(
            'Test title for the post',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: ThemeGuide.borderRadius10,
            child: Image.asset(
              'assets/images/placeholder-image.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Padding(
          padding: ThemeGuide.padding10,
          child: Text('Author name'),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'This is test post data to show the layout of the single post screen \n\nYour HTML post data will be displayed here in the contents \n\nThis is test post data to show the layout of the single post screen \n\nYour HTML post data will be displayed here in the contents'),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: ThemeGuide.borderRadius10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tags',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(50)),
                    child: const Text('Adventure'),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(50)),
                    child: const Text('Comic'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: ThemeGuide.borderRadius10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(50)),
                child: const Text('Latest Blog'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
