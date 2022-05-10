import 'package:flutter/material.dart';

import '../block.dart';
import '../sub_block.dart';

class SBlock extends Block{
  SBlock(int orientationIndex): super(
      [
        [SubBlock(1, 0), SubBlock(2, 0),SubBlock(0, 1),SubBlock(1, 1)],
        [SubBlock(0, 0), SubBlock(0, 1),SubBlock(1, 1),SubBlock(1, 2)],
        [SubBlock(1, 0), SubBlock(2, 0),SubBlock(0, 1),SubBlock(1, 1)],
        [SubBlock(0, 0), SubBlock(0, 1),SubBlock(1, 1),SubBlock(1, 2)],
      ],
      Colors.orange[300]!,
      orientationIndex
  );
}