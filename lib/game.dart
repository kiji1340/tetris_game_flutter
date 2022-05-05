import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/block/block.dart';
import 'package:tetris_game/block/block_movement.dart';
import 'package:tetris_game/block/sub_block.dart';

import 'block/game_block/i_block.dart';
import 'block/game_block/j_block.dart';
import 'block/game_block/l_block.dart';
import 'block/game_block/o_block.dart';
import 'block/game_block/s_block.dart';
import 'block/game_block/t_block.dart';
import 'block/game_block/z_block.dart';

const BLOCKS_X = 10;
const BLOCKS_Y = 20;
const REFRESH_RATE = 300;
const GAME_AREA_BORDER_WIDTH = 2.0;
const SUB_BLOCK_EDGE_WIDTH = 2.0;

enum Collision { LANDED, LANDED_BLOCK, HIT_WALL, HIT_BLOCK, NONE }

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State createState() => GameState();
}

class GameState extends State<Game> {
  final GlobalKey _gameAreaKey = GlobalKey();
  Duration duration = const Duration(milliseconds: REFRESH_RATE);

  double _subBlockWidth = 0;

  BlockMovement? _blockMovement;
  Block? block;
  Timer? timer;
  bool isPlaying = false;
  int _score = 0;

  List<SubBlock>? oldSubBlocks;

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
        return OBlock(0);
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
      oldSubBlocks = <SubBlock>[];
      _score = 0;

      _subBlockWidth =
          (gameRender.size.width - GAME_AREA_BORDER_WIDTH * 2) / BLOCKS_X;

      block = getNewBlock();

      timer = Timer.periodic(duration, onPlay);
    }
  }

  void endGame() {
    isPlaying = false;
    timer?.cancel();
  }

  void onPlay(Timer timer) {
    if (block == null) {
      return;
    }

    var status = Collision.NONE;

    setState(() {
      if (_blockMovement != null) {
        if (!checkOnEdge(_blockMovement!, block!)) {
          block?.move(_blockMovement!);
        }
      }

      //Reverse action if the block hit other sub-blocks
      if (oldSubBlocks != null) {
        for (var oldSubBlock in oldSubBlocks!) {
          for (var subBlock in block!.subBlocks) {
            var x = block!.x + subBlock.x;
            var y = block!.y + subBlock.y;
            if (x == oldSubBlock.x && y == oldSubBlock.y) {
              switch (_blockMovement) {
                case BlockMovement.LEFT:
                  block?.move(BlockMovement.RIGHT);
                  break;
                case BlockMovement.RIGHT:
                  block?.move(BlockMovement.LEFT);
                  break;
                case BlockMovement.ROTATE_CLOCKWISE:
                  block?.move(BlockMovement.ROTATE_COUNTER_CLOCKWISE);
                  break;
                default:
                  break;
              }
            }
          }
        }
      }

      if (!checkAtBottom(block!)) {
        if (!checkAboveBlock(block!)) {
          block!.move(BlockMovement.DOWN);
        } else {
          status = Collision.LANDED_BLOCK;
        }
      } else {
        status = Collision.LANDED;
      }

      if (status == Collision.LANDED || status == Collision.LANDED_BLOCK) {
        for (var subBlock in block!.subBlocks) {
          subBlock.x += block!.x;
          subBlock.y += block!.y;

          oldSubBlocks?.add(subBlock);
        }

        block = getNewBlock();
      }

      _blockMovement = null;
      updateScore();
    });
  }

  void updateScore() {
    var combo = 1;
    Map<int, int> rows = {};
    List<int> rowsToBeRemoved = [];

    // Count number of sub-blocks in each row
    oldSubBlocks?.forEach((subBlock) {
      rows.update(subBlock.y, (value) => ++value, ifAbsent: () => 1);
    });

    // Add score if a full row is found
    rows.forEach((rowNum, count) {
      if (count == BLOCKS_X) {
        _score += combo++;
        print("score = $_score");
        rowsToBeRemoved.add(rowNum);
      }
    });

    if (rowsToBeRemoved.isNotEmpty) {
      removeRows(rowsToBeRemoved);
    }
  }

  void removeRows(List<int> rowsToBeRemoved) {
    rowsToBeRemoved.sort();
    for (var rowNum in rowsToBeRemoved) {
      oldSubBlocks?.removeWhere((subBlock) => subBlock.y == rowNum);
      oldSubBlocks?.forEach((subBlock) {
        if (subBlock.y < rowNum) {
          ++subBlock.y;
        }
      });
    }
  }

  bool checkAtBottom(Block block) {
    return block.y + block.height == BLOCKS_Y;
  }

  bool checkAboveBlock(Block block) {
    if (oldSubBlocks == null || oldSubBlocks!.isEmpty) {
      return false;
    }

    for (var oldSubBlock in oldSubBlocks!) {
      for (var subBlock in block.subBlocks) {
        var x = block.x + subBlock.x;
        var y = block.y + subBlock.y;

        if (x == oldSubBlock.x && y + 1 == oldSubBlock.y) {
          return true;
        }
      }
    }

    return false;
  }

  bool checkOnEdge(BlockMovement blockMovement, Block block) {
    return (blockMovement == BlockMovement.LEFT && block.x <= 0) ||
        (blockMovement == BlockMovement.RIGHT &&
            block.x + block.width >= BLOCKS_X);
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

    //old sub-block
    oldSubBlocks?.forEach((oldSubBlock) {
      subBlocks.add(getPositionedSquareContainer(
        Colors.grey[500]!,
        oldSubBlock.x,
        oldSubBlock.y,
      ));
    });
    return Stack(
      children: subBlocks,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          _blockMovement = BlockMovement.RIGHT;
        } else {
          _blockMovement = BlockMovement.LEFT;
        }
      },
      onTap: () {
        _blockMovement = BlockMovement.ROTATE_CLOCKWISE;
      },
      child: AspectRatio(
        aspectRatio: BLOCKS_X / BLOCKS_Y,
        child: Container(
          key: _gameAreaKey,
          decoration: BoxDecoration(
              color: Colors.indigo[800],
              border: Border.all(
                width: GAME_AREA_BORDER_WIDTH,
                color: Colors.indigoAccent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          child: drawBlocks(),
        ),
      ),
    );
  }
}
