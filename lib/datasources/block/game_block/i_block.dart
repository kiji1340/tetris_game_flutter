import 'package:flutter/material.dart';

import '../block.dart';
import '../sub_block.dart';

class IBlock extends Block{
  IBlock(int orientationIndex): super(
    [
      [SubBlock(0, 0), SubBlock(0, 1),SubBlock(0, 2),SubBlock(0, 3)],
      [SubBlock(0, 0), SubBlock(1, 0),SubBlock(2, 0),SubBlock(3, 0)],
      [SubBlock(0, 0), SubBlock(0, 1),SubBlock(0, 2),SubBlock(0, 3)],
      [SubBlock(0, 0), SubBlock(1, 0),SubBlock(2, 0),SubBlock(3, 0)]
    ],
    Colors.red[400]!,
    orientationIndex
  );
}