import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_game/tennisCourt.dart';

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
  late TennisCourt tennisCourt;

  double ballDirection = 1;
  bool isCatch = false;
  late double halfGameWidth;

  double direction = 0;
  late double positionX;
  late Vector2 ballPosition;

  double playerSpeed = 500;
  double ballSpeed = 800;

  FlameGame();

  @override
  void render(Canvas canvas) {
    tennisCourt = TennisCourt()
      ..x = size.x
      ..y = 0
      ..width = size.x
      ..height = size.y;
    tennisCourt.render(canvas);

    player1 = Player(color: Colors.red)
      ..x = positionX
      ..y = size.y * 0.05
      ..width = size.x * 0.1
      ..height = size.y * 0.1;
    player1.render(canvas);

    player2 = Player(color: Colors.blue)
      ..x = positionX
      ..y = size.y * 0.85
      ..width = size.x * 0.1
      ..height = size.y * 0.1;
    player2.render(canvas);

    ball = Ball(pos: ballPosition);
    ball.render(canvas);
  }

  bool isInScreen(double x) {
    return (x > size.x * 0.25 && x < size.x * 0.75);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyDownEvent && isInScreen(positionX) == true) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft && !isCatch) {
        print("left");
        direction = -1;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
          !isCatch) {
        direction = 1;
        print("right");
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        print("space");
        isCatch = false;
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

  bool ballIsOut() {
    if (ballPosition.y < -300 || ballPosition.y > size.y * 1.5) {
      positionX = halfGameWidth;
      ballDirection = 0;
      return true;
    }
    return false;
  }

  @override
  void update(double dt) {
    // Get ball in the area
    if (direction != 0) {
      if (positionX + (direction * dt * playerSpeed) >=
          size.x * 0.75 - player1.width) {
        positionX = size.x * 0.75 - player1.width;
      } else if (positionX + (direction * dt * playerSpeed) <= size.x * 0.25) {
        positionX = size.x * 0.25 + 2;
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

    if (!ballIsOut() && isCatch == false) {
      ballPosition += Vector2(0, ballDirection) * dt * ballSpeed;
      print("direction: $direction");
    } else {
      print("else");
      //ball is out
      isCatch = true;
      direction = 0;
      if (ballPosition.y > size.y * 1.5) {
        ballPosition = Vector2(halfGameWidth, player2.y);
      } else if (ballPosition.y < 0) {
        ballPosition = Vector2(halfGameWidth, player1.y);
      }
    }
  }
}
