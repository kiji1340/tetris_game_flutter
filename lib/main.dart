import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris_game/src/data/data_notifier.dart';
import 'package:tetris_game/src/presentation/screens/game_screen.dart';

Future<void> main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => DataNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}



