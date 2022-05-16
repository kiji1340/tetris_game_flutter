part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitialState extends GameState {}


class DrawingState extends GameState {
  final Block block;
  final List<SubBlock> oldSubBlocks;

  DrawingState(this.block, this.oldSubBlocks);
}

class UpdateScoreState  extends GameState{
  final int score;

  UpdateScoreState(this.score);
}

class DrawingNextBlockState extends GameState{
  final Block nextBlock;

  DrawingNextBlockState(this.nextBlock);
}

class GameOverState extends GameState {}