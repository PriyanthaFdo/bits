import 'package:bits/config.dart';
import 'package:bits/game/bits_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BitsGame extends FlameGame {
  late final BitsWorld bitsWorld;
  late final CameraComponent cameraComponent;

  @override
  Color backgroundColor() {
    return Config.backgroundColor;
  }

  @override
  Future<void> onLoad() async {
    bitsWorld = BitsWorld();

    // Create camera and attach it to the world
    cameraComponent = CameraComponent.withFixedResolution(
      world: bitsWorld,
      width: 800, // design resolution width
      height: 600, // design resolution height
    );

    cameraComponent.viewfinder.anchor = Anchor.center;

    addAll([
      cameraComponent,
      bitsWorld,
    ]);

    // Optionally center the camera on (0, 0)
    cameraComponent.viewfinder.position = Vector2.zero();
  }
}
