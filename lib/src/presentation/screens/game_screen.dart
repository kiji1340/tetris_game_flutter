import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_game/src/injector.dart';

import '../blocs/game/game_bloc.dart';
import '../views/game_view.dart';
import '../views/next_block.dart';
import '../views/score_bar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  final GameBloc _gameBloc = injector.get<GameBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _gameBloc,
      child: Scaffold(
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
                        const Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                            child: GameView(),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                5.0, 10.0, 10.0, 10.0),
                            child: Column(
                              children: <Widget>[
                                const NextBlock(),
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  child: BlocBuilder<GameBloc, GameState>(
                                    bloc: _gameBloc,
                                    builder: (context, state) {
                                      if (state is GamePlayingState) {
                                        return Text(
                                            state.isPlaying ? 'End' : 'Start');
                                      } else {
                                        return const Text('Start');
                                      }
                                    },
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[200],
                                      ),
                                      primary: Colors.indigo[700]),
                                  onPressed: () {
                                    _gameBloc.add(StartGameEvent());
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
      ),
    );
  }
}
