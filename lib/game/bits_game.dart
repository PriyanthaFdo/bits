import 'dart:math' as math;

import 'package:bits/config.dart';
import 'package:bits/game/bits_world.dart';
import 'package:bits/utils/extensions/color_extension.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BitsGame extends FlameGame with ScrollDetector, ScaleDetector {
  late final BitsWorld _bitsWorld;
  late final Vector2 _worldSize;
  late final CameraComponent _cameraComponent;
  late final double _minZoom;
  late final double _maxZoom;

  double? _initialZoom;

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
  void onScroll(PointerScrollInfo info) {
    const zoomSpeed = Config.zoomSpeed;

    final deltaZoom = -info.scrollDelta.global.y * zoomSpeed;
    final newZoom = (_cameraComponent.viewfinder.zoom + deltaZoom).clamp(_minZoom, Config.maxZoom);

    _cameraComponent.viewfinder.zoom = newZoom;
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    _initialZoom = _cameraComponent.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final newZoom = (_initialZoom! * info.scale.global.x).clamp(_minZoom, _maxZoom);
    _cameraComponent.viewfinder.zoom = newZoom;
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    _initialZoom = null;
  }
}
