import 'package:get_it/get_it.dart';
import 'package:tetris_game/src/config/game_config.dart';
import 'package:tetris_game/src/domain/interactors/game_interactors.dart';
import 'package:tetris_game/src/domain/usecases/generate_new_block.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<GameConfig>(GameConfig());

  injector.registerSingleton<GenerateNewBlock>(GenerateNewBlock());
  injector.registerSingleton<GameInteractors>(GameInteractors(injector()));

}
