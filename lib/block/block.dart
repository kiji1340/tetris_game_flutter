import 'package:flutter/material.dart';
import 'package:tetris_game/block/sub_block.dart';
import 'block_movement.dart';

class Block {
  List<List<SubBlock>> orientations = <List<SubBlock>>[];
  late int x;
  late int y;
  int orientationIndex;

  Block(this.orientations, Color color, this.orientationIndex){
    x = 3;
    y = -width -1;
    this.color = color;
  }

  set color(Color color) {
    for (var orientation in orientations) {
      for (var subBlock in orientation) {
        subBlock.color = color;
      }
    }
  }

  Color get color {
    return orientations[0][0].color;
  }

  List<SubBlock> get subBlocks {
    return orientations[orientationIndex];
  }

  int get width {
    int maxX = 0;
    for (var element in subBlocks) {
      if (element.x > maxX) maxX = element.x;
    }
    return maxX + 1;
  }

  int get height {
    int maxY = 0;
    for (var element in subBlocks) {
      if (element.y > maxY) maxY = element.y;
    }
    return maxY + 1;
  }

  void move(BlockMovement blockMovement){
    switch(blockMovement){
      case BlockMovement.UP:
        y -= 1;
        break;
      case BlockMovement.DOWN:
        y += 1;
        break;
      case BlockMovement.LEFT:
        x -= 1;
        break;
      case BlockMovement.RIGHT:
        x += 1;
        break;
      case BlockMovement.ROTATE_CLOCKWISE:
        orientationIndex = ++orientationIndex  % 4;
        break;
      case BlockMovement.ROTATE_COUNTER_CLOCKWISE:
        orientationIndex = (orientationIndex + 3) % 4;
        break;
    }
  }
}
