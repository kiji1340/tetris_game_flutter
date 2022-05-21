import 'package:tetris_game/src/domain/usecases/generate_new_block.dart';
import 'package:tetris_game/src/domain/usecases/logic_game.dart';

import '../usecases/logic_score.dart';

class GameInteractors {
  final GenerateNewBlock generateNewBlock;
  final LogicGame logicGame;
  final LogicScore logicScore;

  GameInteractors(
      {required this.generateNewBlock,
      required this.logicGame,
      required this.logicScore});
}
