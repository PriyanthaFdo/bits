import 'package:bits/config.dart';
import 'package:bits/game/bits_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bit extends CircleComponent with HasGameReference<BitsGame> {
  Vector2 movementVector = Vector2.zero();
  double rotationSpeed = 0;

  Bit({
    required Vector2 position,
    double radius = 10,
    Color color = Colors.white,
  }) : super(
         position: position,
         radius: radius,
         paint: Paint()..color = color,
         anchor: Anchor.center,
       );

  @override
  void update(double dt) {
    super.update(dt);

    movementVector = Vector2(
      movementVector.x.clamp(-Config.bitMaxSpeed, Config.bitMaxSpeed),
      movementVector.y.clamp(-Config.bitMaxSpeed, Config.bitMaxSpeed),
    );

    position += movementVector * dt;
  }
}
