import 'package:flutter/material.dart';
import 'package:tetris_game/src/config/app_color.dart';

import '../block.dart';
import '../sub_block.dart';

class OBlock extends Block{
  OBlock(int orientationIndex): super(
      [
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(0, 1),SubBlock(1, 1)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(0, 1),SubBlock(1, 1)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(0, 1),SubBlock(1, 1)],
        [SubBlock(0, 0), SubBlock(1, 0),SubBlock(0, 1),SubBlock(1, 1)]
      ],
      AppColor.blockO,
      orientationIndex
  );
}