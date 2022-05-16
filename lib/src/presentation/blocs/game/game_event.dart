part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class StartGameEvent extends GameEvent{}

class SwipeLeftEvent extends GameEvent{}

class SwipeRightEvent extends GameEvent{}

class SwipeDownEvent extends GameEvent{}

class TapEvent extends GameEvent{}