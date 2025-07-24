import 'dart:math' as math;

import 'package:bits/config.dart';
import 'package:bits/game/bits_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bit extends CircleComponent with HasGameReference<BitsGame> {
  Vector2 _velocity = Vector2.zero();
  Vector2 acceleration = Vector2.zero();

  double _angularVelocity = 0;
  double angularAcceleration = 0;

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
    _velocity += acceleration * dt;

    if (_velocity.length > Config.bitMaxVelocity) {
      _velocity = _velocity.normalized() * Config.bitMaxVelocity;
    }

    position += _velocity * dt;

    // rotation
    _angularVelocity += angularAcceleration * dt;

    _angularVelocity = _angularVelocity.clamp(-Config.bitMaxAngularVelocity, Config.bitMaxAngularVelocity);

    final newAngle = angle + _angularVelocity * dt;
    angle = newAngle % (2 * math.pi);

    // clamp to world
    final halfWorldSize = Config.worldSize / 2;

    position = Vector2(
      position.x.clamp(-halfWorldSize.x + radius, halfWorldSize.x - radius),
      position.y.clamp(-halfWorldSize.y + radius, halfWorldSize.y - radius),
    );
  }
}
