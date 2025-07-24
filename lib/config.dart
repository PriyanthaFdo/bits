import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Config {
  static const backgroundColor = Colors.green;
  static const showGrid = true;
  static const zoomSpeed = 0.002;
  static const maxZoom = 5.0;
  static const worldMarginSize = 0.1; // %
  static const gridOverlayCellSize = 100.0;

  static final worldSize = Vector2(1500, 900);

  // Bit configs
  static double bitMaxSpeed = 50;
  static double bitMaxAngularSpeed = 2;
}
