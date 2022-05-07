import 'package:flutter/foundation.dart';

class DataNotifier with ChangeNotifier{
  int score = 0;
  bool isPlaying = false;

  void setScore(score){
    this.score = score;
    notifyListeners();
  }

  void addScore(int score){
    this.score += score;
    notifyListeners();
  }

  void setIsPlaying(isPlaying){
    this.isPlaying = isPlaying;
    notifyListeners();
  }
}