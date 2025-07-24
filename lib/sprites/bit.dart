import 'dart:math' as math;

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
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.save();

    // Move canvas origin to center of the circle
    canvas.translate(radius, radius);

    final Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;

    // Draw line from center to top
    final start = Offset(0, -radius / 2);
    final end = Offset(0, -radius);

    canvas.drawLine(start, end, linePaint);

    canvas.restore();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // movement
    movementVector = Vector2(
      movementVector.x.clamp(-Config.bitMaxSpeed, Config.bitMaxSpeed),
      movementVector.y.clamp(-Config.bitMaxSpeed, Config.bitMaxSpeed),
    );

    position += movementVector * dt;

    // rotation
    rotationSpeed = rotationSpeed.clamp(-Config.bitMaxRotationSpeed, Config.bitMaxRotationSpeed);

    final newAngle = angle + rotationSpeed * dt;
    angle = newAngle % (2 * math.pi);
  }
}
