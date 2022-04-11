import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/block/block.dart';
import 'package:tetris_game/block/block_movement.dart';

import 'block/game_block/i_block.dart';
import 'block/game_block/j_block.dart';
import 'block/game_block/l_block.dart';
import 'block/game_block/o_block.dart';
import 'block/game_block/s_block.dart';
import 'block/game_block/t_block.dart';
import 'block/game_block/z_block.dart';

const BLOCK_X = 10;
const BLOCK_Y = 20;
const REFRESH_RATE = 300;
const GAME_AREA_BORDER_WIDTH = 2.0;
const SUB_BLOCK_EDGE_WIDTH = 2.0;

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State createState() => GameState();
}

class GameState extends State<Game> {
  GlobalKey _gameAreaKey = GlobalKey();

  double _subBlockWidth = 0;
  Block? block;
  Duration duration = const Duration(milliseconds: REFRESH_RATE);
  Timer? timer;
  bool isPlaying = false;

  Block? getNewBlock() {
    int blockType = Random().nextInt(7);
    switch (blockType) {
      case 0:
        return IBlock(0);
      case 1:
        return JBlock(0);
      case 2:
        return LBlock(0);
      case 3:
        return OBlock(1);
      case 4:
        return SBlock(0);
      case 5:
        return TBlock(0);
      case 6:
        return ZBlock(0);
      default:
        return null;
    }
  }

  void startGame() {
    RenderBox? gameRender =
        _gameAreaKey.currentContext?.findRenderObject() as RenderBox?;
    if (gameRender is RenderBox) {
      isPlaying = true;
      _subBlockWidth =
          (gameRender.size.width - GAME_AREA_BORDER_WIDTH * 2) / BLOCK_X;

      block = getNewBlock();

      timer = Timer.periodic(duration, onPlay);
    }
  }

  void endGame() {
    isPlaying = false;
    timer?.cancel();
  }

  void onPlay(Timer timer) {
    setState(() {
      block?.move(BlockMovement.DOWN);
    });
  }

  Positioned getPositionedSquareContainer(Color color, int x, int y) {
    return Positioned(
      left: x * _subBlockWidth,
      top: y * _subBlockWidth,
      child: Container(
        width: _subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
        height: _subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
      ),
    );
  }

  Widget? drawBlocks() {
    if (block == null) return null;
    List<Positioned> subBlocks = [];

    //current block
    for (var subBlock in block!.subBlocks) {
      subBlocks.add(getPositionedSquareContainer(
        subBlock.color,
        subBlock.x + block!.x,
        subBlock.y + block!.y,
      ));
    }
    return Stack(
      children: subBlocks,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: BLOCK_X / BLOCK_Y,
      child: Container(
        key: _gameAreaKey,
        decoration: BoxDecoration(
            color: Colors.indigo[800],
            border: Border.all(
              width: 2.0,
              color: Colors.indigoAccent,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: drawBlocks(),
      ),
    );
  }
}
