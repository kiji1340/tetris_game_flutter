import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris_game/src/data/data_notifier.dart';
import 'package:tetris_game/src/injector.dart';
import 'package:tetris_game/src/presentation/screens/game_screen.dart';

Future<void> main() async {
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}



