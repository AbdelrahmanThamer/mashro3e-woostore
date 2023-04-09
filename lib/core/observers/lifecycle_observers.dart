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

class LifecycleObserver extends StatefulWidget {
  const LifecycleObserver({Key key, this.child, this.actionHooks})
      : super(key: key);

  /// Function Hooks to run when the app state changes.
  final Set<Function> actionHooks;
  final Widget child;

  @override
  _LifecycleObserverState createState() => _LifecycleObserverState();
}

class _LifecycleObserverState extends State<LifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      for (final functionHook in widget.actionHooks ?? const {}) {
        functionHook();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
