import 'dart:js';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'ball.dart';
import 'player.dart';

void main() {
  final game = FlameGame();
  runApp(GameWidget(game: game));
}

class FlameGame extends Game with KeyboardEvents, TapDetector {
  late Player player1;
  late Player player2;
  late Ball ball;

  late double halfGameWidth;

  double direction = 0;
  double positionX = 500;
  Vector2 ballPosition = Vector2(600, 500);

  double playerSpeed = 500;
  double ballSpeed = 100;

  FlameGame();

  @override
  void render(Canvas canvas) {


    player2 = Player(color: Colors.blue)
      ..x = positionX
      ..y = 500
      ..width = size.x * 0.1
      ..height = size.y * 0.1;
    player2.render(canvas);
    halfGameWidth = size.x / 2;

    ball = Ball(pos: ballPosition);
    ball.render(canvas);
  }

  bool isInScreen(double x) {
    return (x > 0 && x < size.x);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyDownEvent && isInScreen(positionX) == true) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        direction = -1;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        direction = 1;
      }
    } else if (event is RawKeyUpEvent) {
      direction = 0;
    }
    return KeyEventResult.handled;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (isInScreen(positionX)) {
      direction = info.eventPosition.game.x > halfGameWidth ? 1 : -1;
    }
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    direction = 0;
    return true;
  }

  @override
  void update(double dt) {    
    double distanceToMove = ballSpeed * dt;
    Vector2 ballDirection = Vector2(600,0) - ballPosition;
    ballDirection.normalize();
    Vector2 ballMove = ballDirection * distanceToMove;
    ballPosition += ballMove;


    if (direction != 0) {
      if (positionX + (direction * dt * playerSpeed) > size.x - size.x * 0.1) {
        positionX = size.x - size.x * 0.1;
      } else if (positionX + (direction * dt * playerSpeed) < 0) {
        positionX = 1;
      } else {
        positionX += direction * dt * playerSpeed;
      }
    }
  }
}
