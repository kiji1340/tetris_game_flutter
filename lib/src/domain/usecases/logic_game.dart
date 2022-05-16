import 'package:tetris_game/src/config/collision.dart';
import 'package:tetris_game/src/config/game_config.dart';
import 'package:tetris_game/src/data/datasources/block/block_movement.dart';
import 'package:tetris_game/src/domain/entities/logic_game_param.dart';

import '../../core/usecase.dart';
import '../../data/datasources/block/block.dart';
import '../../data/datasources/block/sub_block.dart';
import '../entities/logic_game_entity.dart';

class LogicGame implements UseCase<LogicGameEntity?, LogicGameParam> {
  final GameConfig _gameConfig;

  LogicGame(this._gameConfig);

  @override
  Future<LogicGameEntity?> call({LogicGameParam? params}) {
    return Future.sync(() => onPlay(params));
  }


  LogicGameEntity? onPlay(LogicGameParam? params) {
    if (params == null) {
      return null;
    }

    Block block = params.block;
    List<SubBlock> oldSubBlocks = params.oldSubBlocks;
    int score = params.score;
    bool isGameOver = false;

    BlockMovement? blockMovement = params.blockMovement;

    var status = Collision.NONE;

    if(blockMovement != null){
      if(!_checkOnEdge(blockMovement, block)){
        block.move(blockMovement);
      }
    }

    for (var oldSubBlock in oldSubBlocks) {
      for (var subBlock in block.subBlocks) {
        var x = block.x + subBlock.x;
        var y = block.y + subBlock.y;
        if (x == oldSubBlock.x && y == oldSubBlock.y) {
          switch (blockMovement) {
            case BlockMovement.LEFT:
              block.move(BlockMovement.RIGHT);
              break;
            case BlockMovement.RIGHT:
              block.move(BlockMovement.LEFT);
              break;
            case BlockMovement.ROTATE_CLOCKWISE:
              block.move(BlockMovement.ROTATE_COUNTER_CLOCKWISE);
              break;
            default:
              break;
          }
        }
      }
    }

    if (!_checkAtBottom(block)) {
      if (!_checkAboveBlock(block, oldSubBlocks)) {
        block.move(BlockMovement.DOWN);
      } else {
        status = Collision.LANDED_BLOCK;
      }
    } else {
      status = Collision.LANDED;
    }

    if (status == Collision.LANDED_BLOCK && block.y < 0) {
      isGameOver = true;
    } else if (status == Collision.LANDED ||
        status == Collision.LANDED_BLOCK) {
      for (var subBlock in block.subBlocks) {
        subBlock.x += block.x;
        subBlock.y += block.y;

        oldSubBlocks.add(subBlock);
      }
    }

    return LogicGameEntity(block, oldSubBlocks, score, isGameOver);
  }


  bool _checkAtBottom(Block block) {
    return block.y + block.height == _gameConfig.blocksY;
  }

  bool _checkAboveBlock(Block block, List<SubBlock> oldSubBlocks) {
    if (oldSubBlocks.isEmpty) {
      return false;
    }

    for (var oldSubBlock in oldSubBlocks) {
      for (var subBlock in block.subBlocks) {
        var x = block.x + subBlock.x;
        var y = block.y + subBlock.y;

        if (x == oldSubBlock.x && y + 1 == oldSubBlock.y) {
          return true;
        }
      }
    }

    return false;
  }

  bool _checkOnEdge(BlockMovement blockMovement, Block block) {
    bool condition1 = blockMovement == BlockMovement.LEFT && block.x <= 0;
    bool condition2 =  (blockMovement == BlockMovement.RIGHT &&
        block.x + block.width >= _gameConfig.blocksX);
    return condition1 || condition2;
  }
}
