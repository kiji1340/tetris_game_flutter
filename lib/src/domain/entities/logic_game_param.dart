import 'package:tetris_game/src/data/datasources/block/block_movement.dart';

import '../../data/datasources/block/block.dart';
import '../../data/datasources/block/sub_block.dart';

class LogicGameParam {
  Block block;
  List<SubBlock> oldSubBlocks;
  BlockMovement? blockMovement;
  int score;

  LogicGameParam(this.block, this.oldSubBlocks, this.blockMovement, this.score);
}