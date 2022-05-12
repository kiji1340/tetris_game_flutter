import 'dart:math';

import 'package:tetris_game/src/core/usecase.dart';

import '../../data/datasources/block/block.dart';
import '../../data/datasources/block/game_block/i_block.dart';
import '../../data/datasources/block/game_block/j_block.dart';
import '../../data/datasources/block/game_block/l_block.dart';
import '../../data/datasources/block/game_block/o_block.dart';
import '../../data/datasources/block/game_block/s_block.dart';
import '../../data/datasources/block/game_block/t_block.dart';
import '../../data/datasources/block/game_block/z_block.dart';

class GenerateNewBlock implements UseCase<Block?, void> {
  @override
  Future<Block?> call({void params}) {
    return Future.sync(() => _getNewBlock());
  }

  Block? _getNewBlock() {
    int blockType = Random().nextInt(7);
    switch (blockType) {
      case 0:
        return IBlock(0);
      case 1:
        return JBlock(0);
      case 2:
        return LBlock(0);
      case 3:
        return OBlock(0);
      case 4:
        return SBlock(0);
      case 5:
        return TBlock(0);
      case 6:
        return ZBlock(0);
      default:
        return null;
    }
  }

}