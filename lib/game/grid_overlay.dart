import 'package:bits/config.dart';
import 'package:bits/game/bits_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GridOverlay extends Component with HasGameReference<BitsGame> {
  final double cellSize;
  final Paint _paint;
  final bool showGrid;
  final double thickness;

  GridOverlay({
    this.cellSize = 100,
    this.showGrid = true,
    Color color = Colors.white54,
    this.thickness = 0.5,
  }) : _paint = Paint()
         ..color = color
         ..strokeWidth = thickness;

  @override
  void render(Canvas canvas) {
    if (!showGrid) return;

    final size = Config.worldSize;
    final left = -size.x / 2;
    final top = -size.y / 2;
    final right = size.x / 2;
    final bottom = size.y / 2;

    // Vertical lines
    for (double x = left + left % cellSize; x <= right; x += cellSize) {
      canvas.drawLine(Offset(x, top), Offset(x, bottom), _paint);
    }

    // Horizontal lines
    for (double y = top + top % cellSize; y <= bottom; y += cellSize) {
      canvas.drawLine(Offset(left, y), Offset(right, y), _paint);
    }

    // Center point
    canvas.drawCircle(Offset.zero, 3, Paint()..color = Colors.white);
  }
}
