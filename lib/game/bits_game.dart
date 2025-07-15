import 'dart:math' as math;

import 'package:bits/config.dart';
import 'package:bits/game/bits_world.dart';
import 'package:bits/utils/extensions/color_extension.dart';
import 'package:bits/utils/global_getters.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BitsGame extends FlameGame with ScrollDetector, ScaleDetector, MouseMovementDetector {
  late final BitsWorld _bitsWorld;
  late final Vector2 _worldSize;
  late final CameraComponent _cameraComponent;
  late final double _minZoom;
  late final double _maxZoom;

  double? _initialZoom;
  Vector2 _latestMousePosition = Vector2.zero();

  @override
  Color backgroundColor() {
    return Config.backgroundColor.darken(0.5);
  }

  @override
  Future<void> onLoad() async {
    _bitsWorld = BitsWorld();
    _worldSize = Config.worldSize;
    _maxZoom = Config.maxZoom;

    _cameraComponent = CameraComponent(world: _bitsWorld);
    _cameraComponent.viewfinder.anchor = Anchor.center;
    _cameraComponent.viewfinder.position = Vector2.zero();

    addAll([
      _cameraComponent,
      _bitsWorld,
    ]);

    final screenSize = size;
    final worldSizeWithMargin = _worldSize * 1.05;

    _minZoom = math.min(
      screenSize.x / worldSizeWithMargin.x,
      screenSize.y / worldSizeWithMargin.y,
    );

    _cameraComponent.viewfinder.zoom = _minZoom;
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    _latestMousePosition = info.eventPosition.global;
  }

  @override
  void onScroll(PointerScrollInfo info) {
    const zoomSpeed = Config.zoomSpeed;
    final pointerScreenPos = info.eventPosition.global;
    final viewfinder = _cameraComponent.viewfinder;

    // Step 1: get world position under pointer before zoom
    final beforeZoomWorldPos = viewfinder.globalToLocal(pointerScreenPos);

    // Step 2: apply zoom delta
    final deltaZoom = -info.scrollDelta.global.y * zoomSpeed;
    final newZoom = (viewfinder.zoom + deltaZoom).clamp(_minZoom, _maxZoom);
    viewfinder.zoom = newZoom;

    // Step 3: get world position under pointer after zoom
    final afterZoomWorldPos = viewfinder.globalToLocal(pointerScreenPos);

    // Step 4: offset camera so that the point under the cursor stays the same
    viewfinder.position += (beforeZoomWorldPos - afterZoomWorldPos);
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    _initialZoom = _cameraComponent.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final viewfinder = _cameraComponent.viewfinder;
    final currentScale = info.scale.global;
    final newZoom = (_initialZoom! * currentScale.x).clamp(_minZoom, _maxZoom);

    if (currentScale.isIdentity()) {
      final dragDelta = info.delta.global;
      viewfinder.position -= dragDelta / newZoom;
    } else {
      viewfinder.zoom = newZoom;
      final focalScreenPoint = hasMouse ? _latestMousePosition : info.eventPosition.global;

      final worldBefore = viewfinder.globalToLocal(focalScreenPoint);
      final worldAfter = viewfinder.globalToLocal(focalScreenPoint);

      // 4. Adjust camera to keep focal point stable
      viewfinder.position += worldBefore - worldAfter;
    }
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    _initialZoom = null;
  }
}
