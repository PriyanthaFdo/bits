import 'package:bits/config.dart';
import 'package:bits/game/bits_game.dart';
import 'package:bits/utils/extensions/color_extension.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final BitsGame game;

  @override
  void initState() {
    game = BitsGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Config.backgroundColor.lighten(0.5)),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: GameWidget(game: game),
          ),
        ),
      ),
    );
  }
}
