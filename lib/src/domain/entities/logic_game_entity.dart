import 'package:tetris_game/src/data/datasources/block/sub_block.dart';

import '../../data/datasources/block/block.dart';

class LogicGameEntity {
  Block block;
  List<SubBlock> oldSubBlock;
  int score;
  bool isGameOver;

  LogicGameEntity(this.block, this.oldSubBlock, this.score, this.isGameOver);
}