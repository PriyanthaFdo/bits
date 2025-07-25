import 'dart:io';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Config {
  static const backgroundColor = Colors.green;
  static const showGrid = true;
  static const zoomSpeed = 0.002;
  static const maxZoom = 5.0;
  static const worldMarginSize = 0.1; // %
  static const gridOverlayCellSize = 100.0;

  static final worldSize = Platform.isAndroid ? Vector2(900, 1600) * 2 : Vector2(1600, 900);

  // Bit configs
  static double bitMaxVelocity = 50;
  static double bitMaxAcceleration = 50;
  static double bitMaxAngularVelocity = 2 * math.pi;
  static double bitMaxAngularAcceleration = 2 * math.pi;
}
