import 'package:tetris_game/src/data/datasources/block/sub_block.dart';

import '../../data/datasources/block/block.dart';

class LogicGameEntity {
  Block block;
  List<SubBlock> oldSubBlocks;
  int score;
  bool isGameOver;

  LogicGameEntity(
      {required this.block,
      required this.oldSubBlocks,
      required this.score,
      required this.isGameOver});
}
