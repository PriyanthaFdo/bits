import 'dart:async';
import 'dart:math';

import 'package:bits/config.dart';
import 'package:bits/game/bits_game.dart';
import 'package:bits/game/grid_overlay.dart';
import 'package:bits/sprites/bit.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BitsWorld extends World with HasGameReference<BitsGame> {
  final List<Bit> _bitList = <Bit>[];
  final random = Random();
  late final GridOverlay _gridOverlay;

  @override
  FutureOr<void> onLoad() {
    // add the world map
    add(
      RectangleComponent(
        size: Config.worldSize,
        position: Vector2.zero(),
        anchor: Anchor.center,
        paintLayers: [
          // Fill
          Paint()..color = Config.backgroundColor,

          // Border
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0,
        ],
      ),
    );

    _gridOverlay = GridOverlay(cellSize: Config.gridOverlayCellSize, showGrid: true);
    _bitList.add(
      Bit(
        position: Vector2(
          (random.nextDouble() * Config.worldSize.x) - (Config.worldSize.x / 2),
          (random.nextDouble() * Config.worldSize.y) - (Config.worldSize.y / 2),
        ),
      ),
    );

    if (Config.showGrid) {
      add(_gridOverlay);
    }

    for (var bit in _bitList) {
      add(bit);
    }
  }
}
