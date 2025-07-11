import 'dart:async';

import 'package:bits/game/bits_game.dart';
import 'package:bits/sprites/bit.dart';
import 'package:flame/components.dart';

class BitsWorld extends World with HasGameReference<BitsGame> {
  final List<Bit> _bitList = <Bit>[];

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    _bitList.add(Bit(position: Vector2.zero()));

    for (var bit in _bitList) {
      add(bit);
    }
  }
}
