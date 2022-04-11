import 'package:flutter/material.dart';
import 'package:tetris_game/block/block.dart';
import 'package:tetris_game/block/sub_block.dart';

class LBlock extends Block{
  LBlock(int orientationIndex): super(
      [
        [SubBlock(0, 0), SubBlock(0, 1),SubBlock(0, 2),SubBlock(1, 2)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(2, 0),SubBlock(0, 1)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(1, 1),SubBlock(1, 2)],
        [SubBlock(2, 0), SubBlock(0, 1),SubBlock(2, 0),SubBlock(2, 1)]
      ],
      Colors.green[300]!,
      orientationIndex
  );
}