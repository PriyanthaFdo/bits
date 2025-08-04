import 'dart:math' as math;

import 'package:bits/config.dart';
import 'package:bits/game/bits_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bit extends CircleComponent with HasGameReference<BitsGame> {
  // --- Movement ---
  Vector2 _velocity = Vector2.zero();
  Vector2 acceleration = Vector2.zero();

  // --- Rotation ---
  double _angularVelocity = 0;
  double angularAcceleration = 0;

  // --- Life ---
  final double lifeExpectency;
  double _currentLife = 0;

  // --- Color ---
  final Color birthColor;
  final Color deathColor;
  Color _currentColor;

  // --- Shape ---
  @override
  final double radius;

  Bit({
    required Vector2 position,
    this.radius = 10,
    this.lifeExpectency = 1000,
    this.birthColor = Colors.white,
    this.deathColor = Colors.black,
  })  : _currentColor = birthColor,
        super(
          position: position,
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    super.update(dt);

    // Update life
    _currentLife += dt;
    if (_currentLife >= lifeExpectency) {
      removeFromParent();
      return;
    }

    // Update movement
    _velocity += acceleration * dt;
    if (_velocity.length > Config.bitMaxVelocity) {
      _velocity = _velocity.normalized() * Config.bitMaxVelocity;
    }
    position += _velocity * dt;

    // Update rotation
    _angularVelocity += angularAcceleration * dt;
    _angularVelocity = _angularVelocity.clamp(
      -Config.bitMaxAngularVelocity,
      Config.bitMaxAngularVelocity,
    );
    angle = (angle + _angularVelocity * dt) % (2 * math.pi);

    // Clamp to world bounds
    final halfWorldSize = Config.worldSize / 2;
    position = Vector2(
      position.x.clamp(-halfWorldSize.x + radius, halfWorldSize.x - radius),
      position.y.clamp(-halfWorldSize.y + radius, halfWorldSize.y - radius),
    );

    // Update color based on age
    final normalizedAge = (_currentLife / lifeExpectency).clamp(0.0, 1.0);
    _currentColor = Color.lerp(birthColor, deathColor, normalizedAge) ?? _currentColor;
  }

  @override
  void render(Canvas canvas) {
    // Set the current color before drawing
    paint.color = _currentColor;

    // Render the base circle
    super.render(canvas);

    // Draw forward-pointing line from center upward
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;

    final start = Offset(0, -radius / 2);
    final end = Offset(0, -radius);

    canvas.drawLine(start, end, linePaint);
  }
}
