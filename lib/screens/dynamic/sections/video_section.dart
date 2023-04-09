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
import 'package:video_player/video_player.dart';

import '../../../app_builder/app_builder.dart';
import 'shared/decorator.dart';

class VideoSectionLayout extends StatelessWidget {
  const VideoSectionLayout({
    Key? key,
    required this.data,
  }) : super(key: key);
  final VideoSectionData data;

  @override
  Widget build(BuildContext context) {
    return SliverSectionLayoutDecorator(
      styledData: data.styledData,
      sliver: SliverToBoxAdapter(
        child: _VideoPlayer(data: data),
      ),
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  const _VideoPlayer({
    Key? key,
    required this.data,
  }) : super(key: key);
  final VideoSectionData data;

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late VideoPlayerController _controller;

  String get url => widget.data.url;

  @override
  void initState() {
    super.initState();
    final uri = Uri.parse(url);
    if (uri.scheme == 'http') {
      Dev.warn(
          'The video url is of HTTP protocol and may not be allowed by the OS to view');
    }
    _controller = VideoPlayerController.network(uri.toString())
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.setLooping(true);

        ParseEngine.tabController.addListener(_tabControllerListener);
      }).catchError((e, s) {
        Dev.error('Video Section cannot load', error: e, stackTrace: s);
      });
  }

  void _tabControllerListener() {
    if (_controller.value.isInitialized && _controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    ParseEngine.tabController.removeListener(_tabControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: BorderRadius.circular(
                widget.data.styledData.borderRadius,
              ),
              child: AspectRatio(
                aspectRatio: widget.data.dimensionsData.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    if (!_controller.value.isPlaying)
                      Container(
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: const Icon(Icons.play_arrow),
                      ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
