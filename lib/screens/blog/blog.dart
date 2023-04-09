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
import 'package:provider/provider.dart';

import '../../app_builder/app_builder.dart';
import '../../generated/l10n.dart';
import '../../models/models.dart';
import '../../providers/utils/viewStateController.dart';
import '../shared/app_bar/app_bar.dart';
import 'view_model/view_model.dart';
import 'widgets/line_item.dart';

class BlogScreenLayout extends StatelessWidget {
  const BlogScreenLayout({
    Key? key,
    required this.screenData,
    this.filter,
  }) : super(key: key);
  final AppBlogScreenData screenData;
  final BlogFilter? filter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => BlogsViewModel(
          screenData: screenData,
          filter: filter,
        ),
        child: const _View(),
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlogsViewModel>(context, listen: false);
    return CustomScrollView(
      controller: provider.scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (provider.screenData.appBarData.show)
          SliverAppBarLayout(
            data: provider.screenData.appBarData,
            overrideTitle: S.of(context).blogs,
          ),
        if (provider.screenData.layout == BlogScreenLayoutType.grid)
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 100),
            sliver: _Grid(),
          ),
        if (provider.screenData.layout == BlogScreenLayoutType.list)
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 100),
            sliver: _VerticalList(),
          ),
      ],
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenData =
        Provider.of<BlogsViewModel>(context, listen: false).screenData;
    return SliverViewStateController<BlogsViewModel>(
      fetchData: Provider.of<BlogsViewModel>(context, listen: false).fetchData,
      builder: () {
        return Selector<BlogsViewModel, List<WordpressPost>>(
          selector: (context, d) => d.postsList,
          shouldRebuild: (a, b) => a.length != b.length,
          builder: (context, list, child) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenData.columns,
                childAspectRatio:
                    screenData.itemStyledData.dimensionsData.aspectRatio,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  return BlogGridListItem(
                    screenData: screenData,
                    blogData: list[i],
                  );
                },
                childCount: list.length,
              ),
            );
          },
        );
      },
    );
  }
}

class _VerticalList extends StatelessWidget {
  const _VerticalList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenData =
        Provider.of<BlogsViewModel>(context, listen: false).screenData;
    return SliverViewStateController<BlogsViewModel>(
      fetchData: Provider.of<BlogsViewModel>(context, listen: false).fetchData,
      builder: () {
        return Selector<BlogsViewModel, List<WordpressPost>>(
          selector: (context, d) => d.postsList,
          shouldRebuild: (a, b) => a.length != b.length,
          builder: (context, list, child) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  return BlogVerticalListItem(
                    screenData: screenData,
                    blogData: list[i],
                  );
                },
                childCount: list.length,
              ),
            );
          },
        );
      },
    );
  }
}
