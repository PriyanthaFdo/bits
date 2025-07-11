import 'package:bits/game/bits_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bit extends CircleComponent with HasGameReference<BitsGame> {
  Bit({
    required Vector2 position,
    double radius = 10,
    Color color = Colors.white,
  }) : super(
         position: position,
         radius: radius,
         paint: Paint()..color = color,
       );
}
