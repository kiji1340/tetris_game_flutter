import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tetris_game/src/domain/interactors/game_interactors.dart';

import '../../../config/game_config.dart';
import '../../../data/datasources/block/block.dart';
import '../../../data/datasources/block/block_movement.dart';
import '../../../data/datasources/block/sub_block.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameInteractors _interactors;
  final GameConfig _gameConfig;

  List<SubBlock> _oldSubBlocks = <SubBlock>[];
  int _score = 0;
  Block? _currentBlock;
  Block? _nextBlock;

  GameBloc(this._interactors, this._gameConfig) : super(GameInitialState()) {
    on<GameEvent>((event, emit) {
      if (event is StartGameEvent) {
        _startGame(emit);
      }

      if(event is SwipeLeftEvent){

      }
      if(event is SwipeRightEvent){

      }
      if(event is SwipeDownEvent){

      }
      if(event is TapEvent){

      }

    });
  }

  void _startGame(Emitter<GameState> emitter) async {
    _oldSubBlocks = <SubBlock>[];
    _score = 0;

    _currentBlock = await _interactors.generateNewBlock();
    _nextBlock = await _interactors.generateNewBlock();

    if(_currentBlock != null){
      emitter.call(DrawingState(_currentBlock!, _oldSubBlocks));
    }

    if(_nextBlock != null){
      emitter.call(DrawingNextBlockState(_nextBlock!));
    }

    emitter.call(UpdateScoreState(_score));
  }

}
