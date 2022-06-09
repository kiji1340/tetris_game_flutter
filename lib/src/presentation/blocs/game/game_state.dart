part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitialState extends GameState {}


class GamePlayingState extends GameState{
   final bool isPlaying;
   GamePlayingState(this.isPlaying);
}


class DrawingState extends GameState {
  final Block block;
  final List<SubBlock> oldSubBlocks;

  DrawingState(this.block, this.oldSubBlocks);
}

class UpdateScoreState  extends GameState{
  final List<SubBlock> oldSubBlocks;
  final int score;

  UpdateScoreState(this.oldSubBlocks, this.score);
}

class DrawingNextBlockState extends GameState{
  final Block nextBlock;

  DrawingNextBlockState(this.nextBlock);
}

class GameOverState extends GameState {}