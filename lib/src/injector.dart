import 'package:get_it/get_it.dart';
import 'package:tetris_game/src/config/game_config.dart';
import 'package:tetris_game/src/domain/interactors/game_interactors.dart';
import 'package:tetris_game/src/domain/usecases/generate_new_block.dart';
import 'package:tetris_game/src/domain/usecases/logic_game.dart';
import 'package:tetris_game/src/domain/usecases/logic_score.dart';
import 'package:tetris_game/src/presentation/blocs/game/game_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<GameConfig>(GameConfig());

  injector.registerSingleton<GenerateNewBlock>(GenerateNewBlock());
  injector.registerSingleton<LogicGame>(LogicGame());
  injector.registerSingleton<LogicScore>(LogicScore());
  injector.registerSingleton<GameInteractors>(GameInteractors(
      generateNewBlock: injector(),
      logicGame: injector(),
      logicScore: injector()));
  injector.registerSingleton<GameBloc>(GameBloc(injector()));
}
