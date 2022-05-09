import 'package:flutter/material.dart';

import '../datasources/block/block.dart';

class DataNotifier with ChangeNotifier {
  int score = 0;
  bool isPlaying = false;
  Block? nextBlock;

  void setScore(score) {
    this.score = score;
    notifyListeners();
  }

  void addScore(int score) {
    this.score += score;
    notifyListeners();
  }

  void setIsPlaying(isPlaying) {
    this.isPlaying = isPlaying;
    notifyListeners();
  }

  void setNextBlock(Block nextBlock) {
    this.nextBlock = nextBlock;
    notifyListeners();
  }

  Widget getNextBlockWidget() {
    if (!isPlaying) {
      return Container();
    }

    if (nextBlock == null) {
      return Container();
    } else {
      var width = nextBlock!.width;
      var height = nextBlock!.height;
      Color color;

      List<Widget> columns = [];
      for (var y = 0; y < height; y++) {
        List<Widget> rows = [];
        for (var x = 0; x < width; x++) {
          if (nextBlock!.subBlocks
              .where((subBlock) => subBlock.x == x && subBlock.y == y)
              .isNotEmpty) {
            color = nextBlock!.color;
          } else {
            color = Colors.transparent;
          }

          rows.add(Container(
            width: 12,
            height: 12,
            color: color,
          ));
        }

        columns.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ));
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: columns,
      );
    }
  }
}
