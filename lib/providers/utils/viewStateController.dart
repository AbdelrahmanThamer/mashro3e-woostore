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

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../developer/dev.log.dart';
import '../../shared/customLoader.dart';
import '../../shared/widgets/error/errorReload.dart';
import '../../shared/widgets/error/noDataAvailable.dart';
import 'baseProvider.dart';
import 'widgets/customMessage.dart';

///
/// ### `Description`
///
/// Controls the state of the view and calls the `fetchData` function in
/// init state.
/// There are 4 main states that the view can have:
///
/// 1. Loading
/// 2. Success - Data available
/// 3. Error
/// 4. No data - Request is successful but with no data available.
///
class ViewStateController<T extends BaseProvider> extends StatefulWidget {
  const ViewStateController({
    Key? key,
    required this.child,
    required this.fetchData,
    this.isDataAvailable = false,
    this.disposeFunction,
    this.customMessageWidget,
  }) : super(key: key);

  /// The widget that is shown when the data request is successful and there
  /// is data to render on the screen
  final Widget child;

  /// Function to get the data for the `View`. It usually is an async function
  /// to an API or Repository
  /// It is called as soon as the controller is inserted in the widget tree.
  ///
  /// This function is even called during `ViewState.LOADING` on initialization
  /// if `isDataAvailable` flag is set to `false`
  final void Function() fetchData;

  /// Flag to override the `fetchData` instantiation when the controller is
  /// instantiated. The will not allow the call to `fetchData` function
  /// at instantiation.
  final bool isDataAvailable;

  /// A function to dispose any of the resources before unloading the
  /// viewStateController
  final void Function()? disposeFunction;

  /// Show this widget instead of the default to show a custom message on the
  /// screen
  final Widget? customMessageWidget;

  @override
  _ViewStateControllerState<T> createState() => _ViewStateControllerState();
}

class _ViewStateControllerState<T extends BaseProvider>
    extends State<ViewStateController<T>> {
  /// Variable to store the instance of the provider
  late BaseProvider ref;

  @override
  void initState() {
    super.initState();
    ref = Provider.of<T>(context, listen: false);
    final ViewState state = ref.state;

    // Function Log
    Dev.debugFunction(
      functionName: 'initState',
      className: 'ViewStateController',
      start: true,
      fileName: 'viewStateController.dart',
      customMessage: 'Initiating for ${ref.runtimeType}',
    );

    if (state == ViewState.LOADING && !widget.isDataAvailable) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        widget.fetchData();
      });
    }
  }

  @override
  void dispose() {
    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'ViewStateController',
      start: false,
      fileName: 'viewStateController.dart',
      customMessage: 'Disposing for ${ref.runtimeType}',
    );

    if (widget.disposeFunction != null) {
      widget.disposeFunction!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<T, ViewState>(
      selector: (context, d) => d.state,
      shouldRebuild: (a, b) => a != b,
      builder: (context, viewState, _) {
        // viewState =
        //     widget.isDataAvailable ? ViewState.DATA_AVAILABLE : viewState;
        final size = MediaQuery.of(context).size;
        switch (viewState) {
          case ViewState.LOADING:
            return LimitedBox(
              maxHeight: size.height - size.height / 5,
              child: const Center(child: CustomLoader()),
            );

          case ViewState.ERROR:
            return LimitedBox(
              maxHeight: size.height - size.height / 5,
              child: Center(
                child: ErrorReloadWithIcon(
                  reloadFunction: widget.fetchData,
                  errorMessage: ref.error,
                ),
              ),
            );

          case ViewState.DATA_AVAILABLE:
            return widget.child;

          case ViewState.NO_DATA_AVAILABLE:
            return LimitedBox(
              maxHeight: size.height - size.height / 5,
              child: const Center(child: NoDataAvailableImage()),
            );

          case ViewState.CUSTOM_MESSAGE:
            return widget.customMessageWidget ??
                CustomMessage(text: ref.message);

          default:
            return LimitedBox(
              maxHeight: size.height - size.height / 5,
              child: Center(
                child: ErrorReloadWithIcon(
                  reloadFunction: widget.fetchData,
                  errorMessage: ref.error,
                ),
              ),
            );
        }
      },
    );
  }
}

///
/// ### `Description`
///
/// Controls the state of the sliver view and calls the `fetchData` function in
/// init state.
/// There are 4 main states that the view can have:
///
/// 1. Loading
/// 2. Success - Data available
/// 3. Error
/// 4. No data - Request is successful but with no data available.
///
class SliverViewStateController<T extends BaseProvider> extends StatefulWidget {
  const SliverViewStateController({
    Key? key,
    required this.builder,
    required this.fetchData,
    this.isDataAvailable = false,
  }) : super(key: key);

  /// Returns the sliver widget which can be used in the slivers
  final Widget Function() builder;

  /// Function to get the data for the `View`. It usually is an async function
  /// to an API or Repository
  /// It is called as soon as the controller is inserted in the widget tree.
  ///
  /// This function is even called during `ViewState.LOADING` on initialization
  /// if `isDataAvailable` flag is set to `false`
  final void Function() fetchData;

  /// Flag to override the `fetchData` instantiation when the controller is
  /// instantiated. The will not allow the call to `fetchData` function
  /// at instantiation.
  final bool isDataAvailable;

  @override
  _SliverViewStateControllerState<T> createState() =>
      _SliverViewStateControllerState();
}

class _SliverViewStateControllerState<T extends BaseProvider>
    extends State<SliverViewStateController<T>> {
  /// Variable to store the instance of the provider
  late T ref;

  @override
  void initState() {
    super.initState();
    ref = Provider.of<T>(context, listen: false);
    final ViewState state = ref.state;

    // Function Log
    Dev.debugFunction(
      functionName: 'initState',
      className: 'SliverViewStateController',
      start: true,
      fileName: 'viewStateController.dart',
      customMessage: 'Initiating Type: ${ref.runtimeType}',
    );

    if (state == ViewState.LOADING && !widget.isDataAvailable) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        widget.fetchData();
      });
    }
  }

  @override
  void dispose() {
    // Function Log
    Dev.debugFunction(
      functionName: 'dispose',
      className: 'SliverViewStateController',
      start: false,
      fileName: 'viewStateController.dart',
      customMessage: 'Disposing Type: ${ref.runtimeType}',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<T, ViewState>(
      selector: (context, d) => d.state,
      shouldRebuild: (a, b) => true,
      builder: (context, viewState, _) {
        viewState =
            widget.isDataAvailable ? ViewState.DATA_AVAILABLE : viewState;
        final size = MediaQuery.of(context).size;
        switch (viewState) {
          case ViewState.LOADING:
            return SliverToBoxAdapter(
              child: LimitedBox(
                maxHeight: size.height - size.height / 5,
                child: const Center(child: CustomLoader()),
              ),
            );

          case ViewState.ERROR:
            return SliverToBoxAdapter(
              child: LimitedBox(
                maxHeight: size.height - size.height / 5,
                child: Center(
                  child: ErrorReloadWithIcon(
                    reloadFunction: widget.fetchData,
                    errorMessage: ref.error,
                  ),
                ),
              ),
            );

          case ViewState.DATA_AVAILABLE:
            return widget.builder();

          case ViewState.NO_DATA_AVAILABLE:
            return SliverToBoxAdapter(
              child: LimitedBox(
                maxHeight: size.height - size.height / 5,
                child: const Center(child: NoDataAvailableImage()),
              ),
            );

          default:
            return SliverToBoxAdapter(
              child: LimitedBox(
                maxHeight: size.height - size.height / 5,
                child: Center(
                  child: ErrorReloadWithIcon(
                    reloadFunction: widget.fetchData,
                    errorMessage: ref.error,
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
