import 'package:flutter/material.dart';

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
      Colors.blue[300]!,
      orientationIndex
  );
}