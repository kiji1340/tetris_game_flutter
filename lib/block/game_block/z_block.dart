import 'package:flutter/material.dart';
import 'package:tetris_game/block/sub_block.dart';

import '../block.dart';

class ZBlock extends Block{
  ZBlock(int orientationIndex): super(
      [
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(1, 1),SubBlock(2, 1)],
        [SubBlock(1, 0), SubBlock(0, 1),SubBlock(1, 1),SubBlock(0, 2)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(1, 1),SubBlock(2, 1)],
        [SubBlock(1, 0), SubBlock(0, 1),SubBlock(1, 1),SubBlock(0, 2)]
      ],
      Colors.cyan[300]!,
      orientationIndex
  );
}