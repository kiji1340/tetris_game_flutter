import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris_game/data/DataNotifier.dart';

class ScoreBar extends StatefulWidget {
  const ScoreBar({Key? key}) : super(key: key);

  @override
  State createState() => _ScoreBarState();
}

class _ScoreBarState extends State<ScoreBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo[800]!, Colors.indigo[500]!],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Score:  ${context.watch<DataNotifier>().score}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
