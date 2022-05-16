import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data_notifier.dart';
import '../views/game.dart';
import '../views/next_block.dart';
import '../views/score_bar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  GlobalKey<GameState> _gameKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TETRIS"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const ScoreBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                          child: Game(
                            key: _gameKey,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
                          child: Column(
                            children: <Widget>[
                              const NextBlock(),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                child: Text(
                                    context
                                        .watch<DataNotifier>()
                                        .isPlaying
                                        ? 'End'
                                        : 'Start'),
                                style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[200],
                                    ),
                                    primary: Colors.indigo[700]),
                                onPressed: () {
                                  context
                                      .read<DataNotifier>()
                                      .isPlaying
                                      ? _gameKey.currentState!.endGame()
                                      : _gameKey.currentState!.startGame();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}