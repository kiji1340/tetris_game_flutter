import 'package:flutter/material.dart';
import 'package:tetris_game/src/config/app_color.dart';

import '../block.dart';
import '../sub_block.dart';

class JBlock extends Block{
  JBlock(int orientationIndex): super(
      [
        [SubBlock(1, 0), SubBlock(1, 1),SubBlock(1, 2),SubBlock(0, 2)],
        [SubBlock(0, 0), SubBlock(0, 1),SubBlock(1, 1),SubBlock(2, 1)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(0, 1),SubBlock(0, 2)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(2, 0),SubBlock(2, 1)]
      ],
      AppColor.blockJ,
      orientationIndex
  );
}