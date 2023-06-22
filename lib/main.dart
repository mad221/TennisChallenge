import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  double ballDirection = 1;

  late double halfGameWidth;

  double direction = 0;
  double positionX = 500;
  Vector2 ballPosition = Vector2(500, 500);

  double playerSpeed = 500;
  double ballSpeed = 100;

  FlameGame();

  @override
  void render(Canvas canvas) {
    player1 = Player(color: Colors.green)
      ..x = positionX
      ..y = size.y * 0.1
      ..width = size.x * 0.1
      ..height = size.y * 0.1;
    player1.render(canvas);

    player2 = Player(color: Colors.blue)
      ..x = positionX
      ..y = size.y * 0.9
      ..width = size.x * 0.1
      ..height = size.y * 0.1;
    player2.render(canvas);

    ball = Ball(pos: ballPosition);
    ball.render(canvas);

    halfGameWidth = size.x / 2;
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

  bool checkRectangleCircleCollision(
      Rect rectangle, Offset circleCenter, double circleRadius) {
    // Convertir les coordonnées du rectangle en coin inférieur gauche et coin supérieur droit
    double rectLeft = rectangle.left;
    double rectRight = rectangle.right;
    double rectTop = rectangle.top;
    double rectBottom = rectangle.bottom;

    // Trouver les coordonnées les plus proches du cercle à l'intérieur du rectangle
    double closestX = circleCenter.dx.clamp(rectLeft, rectRight);
    double closestY = circleCenter.dy.clamp(rectTop, rectBottom);

    // Calculer la distance entre le cercle et le point le plus proche
    double distance =
        Vector2(circleCenter.dx - closestX, circleCenter.dy - closestY).length;

    // Vérifier si la distance est inférieure ou égale au rayon du cercle
    return distance <= circleRadius;
  }

  @override
  void update(double dt) {
    if (direction != 0) {
      if (positionX + (direction * dt * playerSpeed) > size.x - size.x * 0.1) {
        positionX = size.x - size.x * 0.1;
      } else if (positionX + (direction * dt * playerSpeed) < 0) {
        positionX = 1;
      } else {
        positionX += direction * dt * playerSpeed;
      }
    }
    // detect if player touch the ball
    // convert ballCircle to Rect

    if (checkRectangleCircleCollision(
        player1.playerRect,
        Offset(ball.ballCircle.center.x, ball.ballCircle.center.y),
        ball.ballCircle.radius)) {
      ballDirection = 1;
    }

    if (checkRectangleCircleCollision(
        player2.playerRect,
        Offset(ball.ballCircle.center.x, ball.ballCircle.center.y),
        ball.ballCircle.radius)) {
      ballDirection = -1;
    }

    ballPosition += Vector2(0, ballDirection) * dt * ballSpeed;
  }
}
