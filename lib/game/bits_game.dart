import 'package:bits/config.dart';
import 'package:bits/game/bits_world.dart';
import 'package:bits/utils/extensions/color_extension.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BitsGame extends FlameGame {
  late final BitsWorld bitsWorld;
  late final CameraComponent cameraComponent;

  @override
  Color backgroundColor() {
    return Config.backgroundColor.darken(0.5);
  }

  @override
  Future<void> onLoad() async {
    bitsWorld = BitsWorld();

    cameraComponent = CameraComponent.withFixedResolution(
      world: bitsWorld,
      width: Config.worldSize.x + 50,
      height: Config.worldSize.y + 50,
    );

    cameraComponent.viewfinder.anchor = Anchor.center;
    cameraComponent.viewfinder.position = Vector2.zero();

    addAll([
      cameraComponent,
      bitsWorld,
    ]);
  }
}
