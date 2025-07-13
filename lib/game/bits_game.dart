import 'dart:math' as math;

import 'package:bits/config.dart';
import 'package:bits/game/bits_world.dart';
import 'package:bits/utils/extensions/color_extension.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BitsGame extends FlameGame with ScrollDetector {
  late final BitsWorld bitsWorld;
  late final Vector2 worldSize;
  late final CameraComponent cameraComponent;
  late final double _minZoom;

  @override
  Color backgroundColor() {
    return Config.backgroundColor.darken(0.5);
  }

  @override
  Future<void> onLoad() async {
    bitsWorld = BitsWorld();
    worldSize = Config.worldSize;

    cameraComponent = CameraComponent(world: bitsWorld);
    cameraComponent.viewfinder.anchor = Anchor.center;
    cameraComponent.viewfinder.position = Vector2.zero();

    addAll([
      cameraComponent,
      bitsWorld,
    ]);

    final screenSize = size;
    final worldSizeWithMargin = worldSize * 1.05;

    _minZoom = math.min(
      screenSize.x / worldSizeWithMargin.x,
      screenSize.y / worldSizeWithMargin.y,
    );

    cameraComponent.viewfinder.zoom = _minZoom;
  }

  @override
  void onScroll(PointerScrollInfo info) {
    const zoomSpeed = Config.zoomSpeed;

    final deltaZoom = -info.scrollDelta.global.y * zoomSpeed;
    final newZoom = (cameraComponent.viewfinder.zoom + deltaZoom).clamp(_minZoom, Config.maxZoom);

    cameraComponent.viewfinder.zoom = newZoom;
  }
}
