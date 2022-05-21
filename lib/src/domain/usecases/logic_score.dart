import 'package:tetris_game/src/config/game_config.dart';
import 'package:tetris_game/src/core/usecase.dart';
import 'package:tetris_game/src/data/datasources/block/sub_block.dart';
import 'package:tetris_game/src/domain/entities/logic_score_entity.dart';
import 'package:tetris_game/src/domain/entities/logic_score_param.dart';
import 'package:tetris_game/src/injector.dart';

class LogicScore extends UseCase<LogicScoreEntity?, LogicScoreParam> {
  final GameConfig _config = injector.get<GameConfig>();


  @override
  Future<LogicScoreEntity?> call({LogicScoreParam? params}) {
    return Future.sync(() => _runLogic(params));
  }

  LogicScoreEntity? _runLogic(LogicScoreParam? params) {
    if (params == null) {
      return null;
    }

    int combo = 1;
    Map<int, int> rows = {};
    List<int> rowsToBeRemoved = [];



    // count number of sub-blocks in each row
    for (var subBlock in params.oldSubBlocks) {
      rows.update(subBlock.y, (value) => ++value, ifAbsent: () => 1);
    }

    rows.forEach((rowNum, countSubBlock) {
      if (countSubBlock == _config.blocksX) {
        combo++;
        rowsToBeRemoved.add(rowNum);
      }
    });

    if(rowsToBeRemoved.isNotEmpty){
      _removeRows(rowsToBeRemoved, params.oldSubBlocks);
    }
    int score = params.score + combo;

    return LogicScoreEntity(oldSubBlocks: params.oldSubBlocks, score: score);
  }

  void _removeRows(List<int> rowsToBeRemoved, List<SubBlock> oldSubBlocks){
    rowsToBeRemoved.sort();
    for(var rowNum in rowsToBeRemoved){
      oldSubBlocks.removeWhere((subBlock) => subBlock.y == rowNum);
      for (var subBlock in oldSubBlocks) {
        if(subBlock.y < rowNum){
          ++subBlock.y;
        }
      }
    }
  }
}
