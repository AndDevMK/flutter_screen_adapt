import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenAdaptBinding extends WidgetsFlutterBinding {
  /// 设计稿宽度
  final int _designWidth = 375;
  late ViewConfiguration _viewConfiguration;

  ViewConfiguration get viewConfiguration => _viewConfiguration;

  static WidgetsBinding ensureInitialized() {
    /// 防止多次调用创建多个实例
    try {
      WidgetsBinding.instance;
    } catch (e) {
      ScreenAdaptBinding();
    }
    return WidgetsBinding.instance;
  }

  @override
  ViewConfiguration createViewConfiguration() {
    final FlutterView view = platformDispatcher.implicitView!;
    final double devicePixelRatio = view.physicalSize.width / _designWidth;
    _viewConfiguration = ViewConfiguration(
      size: view.physicalSize / devicePixelRatio,
      devicePixelRatio: devicePixelRatio,
    );
    return _viewConfiguration;
  }

  /// fixme：修正事件分发中涉及的devicePixelRatio，bug例如：SingleChildScrollView在横屏时，无法滚动
  @override
  void initInstances() {
    super.initInstances();
    platformDispatcher.onPointerDataPacket = _handlePointerDataPacket;
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    if (_pendingPointerEvents.isEmpty && !locked) {
      scheduleMicrotask(_flushPointerEventQueue);
    }
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _handlePointerDataPacket(PointerDataPacket packet) {
    // We convert pointer data to logical pixels so that e.g. the touch slop can be
    // defined in a device-independent manner.
    try {
      _pendingPointerEvents.addAll(PointerEventConverter.expand(packet.data, _devicePixelRatioForView));
      if (!locked) {
        _flushPointerEventQueue();
      }
    } catch (error, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: 'gestures library',
        context: ErrorDescription('while handling a pointer data packet'),
      ));
    }
  }

  double? _devicePixelRatioForView(int viewId) {
    final FlutterView? view = platformDispatcher.view(id: viewId);
    return view == null ? null : view.physicalSize.width / _designWidth;
  }

  void _flushPointerEventQueue() {
    assert(!locked);

    while (_pendingPointerEvents.isNotEmpty) {
      handlePointerEvent(_pendingPointerEvents.removeFirst());
    }
  }
}
