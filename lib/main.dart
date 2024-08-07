import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris_game/data/DataNotifier.dart';
import 'package:tetris_game/game.dart';
import 'package:tetris_game/next_block.dart';
import 'package:tetris_game/score_bar.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => DataNotifier(),
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Tetris(),
    );
  }
}

class Tetris extends StatefulWidget {
  const Tetris({Key? key}) : super(key: key);

  @override
  State createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
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
                                    context.watch<DataNotifier>().isPlaying
                                        ? 'End'
                                        : 'Start'),
                                style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[200],
                                    ),
                                    backgroundColor: Colors.indigo[700]),
                                onPressed: () {
                                  context.read<DataNotifier>().isPlaying
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
