import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tetris_game/src/domain/entities/logic_game_entity.dart';
import 'package:tetris_game/src/domain/entities/logic_game_param.dart';
import 'package:tetris_game/src/domain/entities/logic_score_param.dart';
import 'package:tetris_game/src/domain/interactors/game_interactors.dart';

import '../../../config/game_config.dart';
import '../../../data/datasources/block/block.dart';
import '../../../data/datasources/block/block_movement.dart';
import '../../../data/datasources/block/sub_block.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameInteractors _interactors;

  List<SubBlock> _oldSubBlocks = <SubBlock>[];
  int _score = 0;
  Block? _currentBlock;
  Block? _nextBlock;
  BlockMovement? _blockMovement;

  GameBloc(this._interactors) : super(GameInitialState()) {
    on<GameEvent>((event, emit) {
      if (event is StartGameEvent) {
        _startGame(emit);
        _onPlay(emit);
        _updateScore(emit);
      }

      if (event is SwipeLeftEvent) {}
      if (event is SwipeRightEvent) {}
      if (event is SwipeDownEvent) {}
      if (event is TapEvent) {}
    });
  }

  void _startGame(Emitter<GameState> emit) async {
    _oldSubBlocks = <SubBlock>[];
    _score = 0;

    _createBlockForNextStep(emit);

    emit.call(UpdateScoreState(_score));
  }

  void _onPlay(Emitter<GameState> emit) async {
    if (_currentBlock == null) {
      return;
    }

    LogicGameEntity? gameEntity = await _interactors.logicGame(
      params: LogicGameParam(
          block: _currentBlock!,
          oldSubBlocks: _oldSubBlocks,
          blockMovement: _blockMovement,
          score: _score),
    );

    if (gameEntity == null) {
      return;
    }

    if (gameEntity.isGameOver) {
      //Game over
      emit.call(GameOverState());
    } else {
      emit.call(DrawingState(gameEntity.block, gameEntity.oldSubBlocks));
      _createBlockForNextStep(emit);
    }
    _blockMovement = null;
  }

  void _createBlockForNextStep(Emitter<GameState> emit) async {
    _currentBlock = await _interactors.generateNewBlock();
    _nextBlock = await _interactors.generateNewBlock();

    if (_currentBlock != null) {
      emit.call(DrawingState(_currentBlock!, _oldSubBlocks));
    }

    if (_nextBlock != null) {
      emit.call(DrawingNextBlockState(_nextBlock!));
    }
  }

  void _updateScore(Emitter<GameState> emit) async {
    await _interactors.logicScore(
    );
  }
}
