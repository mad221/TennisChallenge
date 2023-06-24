import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_game/tennisCourt.dart';
import 'player_animation.dart';

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
  late PlayerAnimation playerAnimation;
  late PlayerAnimation botAnimation;
  bool isLoaded = false;

  double ballDirection = 1;
  bool isCatch = false;
  late double halfGameWidth;

  double direction = 0;
  late double positionX;
  late Vector2 ballPosition;

  double playerSpeed = 200;
  double ballSpeed = 100;

  String imagesPlayerLeft = 'sprites/playerOneMovementLeft.png';
  String imagesPlayerRight = 'sprites/playerOneMovementRight.png';
  String imagesPlaterLeftSmash = 'sprites/playerOnMovementLeftSmash.png';
  String imagesPlaterRightSmash = 'sprites/playerOnMovementRightSmash.png';

  String imagesBotLeft = 'sprites/botPlayerOnMovementLeft.png';
  String imagesBotRight = 'sprites/botPlayerOnMovementRight.png';
  String imagesBotRightSmash = 'sprites/botPlayerOnMovementRightSmash.png';
  String imagesBotLeftSmash = 'sprites/botPlayerOnMovementLeftSmash.png';

  Image? tennisNet;

  late SpriteAnimation tennisNetSprite;

  FlameGame() {
    playerAnimation = PlayerAnimation(
        playerImage: images,
        pathImageLeft: imagesPlayerLeft,
        pathImageRight: imagesPlayerRight,
        pathImageLeftSmash: imagesPlaterLeftSmash,
        pathImageRightSmash: imagesPlaterRightSmash);

    botAnimation = PlayerAnimation(
        playerImage: images,
        pathImageLeft: imagesBotLeft,
        pathImageRight: imagesBotRight,
        pathImageLeftSmash: imagesBotLeftSmash,
        pathImageRightSmash: imagesBotRightSmash);
  }

  @override
  Future<void> onLoad() async {
    await playerAnimation.onLoad().then((value) => isLoaded = true);
    await botAnimation.onLoad().then((value) => isLoaded = true);

    await images.load('sprites/tennisNet.png').then((value) => {
          tennisNetSprite = SpriteAnimation.fromFrameData(
              value,
              SpriteAnimationData.sequenced(
                amount: 1,
                textureSize: Vector2(6, 6),
                stepTime: 0.1,
                loop: false,
              ))
        });

    halfGameWidth = size.x / 2;
    ballPosition = Vector2(halfGameWidth, size.y * 0.9);
    positionX = halfGameWidth;
  }

  void drawTennisNet(Canvas canvas) {
    double tennisNetWidth = 24;
    double tennisBorderleft = size.x - (size.x * 0.205);
    double tennisBorderRight = size.x - (size.x * 0.795);
    double tennisBorder = tennisBorderleft - tennisBorderRight;

    for (int i = 0; i * tennisNetWidth < tennisBorder; i++) {
      tennisNetSprite.getSprite().renderRect(
          canvas,
          Rect.fromLTWH(
              i * tennisNetWidth + size.x * 0.200, size.y * 0.40, 24, 36));
    }
  }

  @override
  void render(Canvas canvas) {
    tennisCourt = TennisCourt(image: images)
      ..x = size.x
      ..y = 0
      ..width = size.x
      ..height = size.y;
    tennisCourt.render(canvas);
    drawTennisNet(canvas);
    player1 = Player(color: Colors.transparent)
      ..x = positionX
      ..y = size.y * 0.01
      ..width = size.x * 0.05
      ..height = size.y * 0.06;
    player1.render(canvas);

    player2 =
        Player(color: Colors.transparent) // change the color to get the hitBox
          ..x = positionX
          ..y = size.y * 0.85
          ..width = size.x * 0.05
          ..height = size.y * 0.1;
    player2.render(canvas);

    if (isLoaded == true) {
      Rect pos = Rect.fromLTWH(positionX - (size.x * 0.09) / 4.5, size.y * 0.80,
          size.x * 0.09, size.y * 0.15);
      playerAnimation.render(canvas, pos);

      Rect posBot = Rect.fromLTWH(positionX - (size.x * 0.09) / 4.5,
          size.y * 0.12 - (size.y * 0.15), size.x * 0.09, size.y * 0.15);
      botAnimation.render(canvas, posBot);
    }

    ball = Ball(pos: ballPosition, screenSize: size);
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
        direction = -1;
        playerAnimation.selectLeftAnimation();
        botAnimation.selectLeftAnimation();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        direction = 1;
        playerAnimation.selectRightAnimation();
        botAnimation.selectRightAnimation();
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
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

    playerAnimation.update(direction, dt);

    botAnimation.update(direction, dt);
    // detect if player touch the ball
    // convert ballCircle to Rect
    if (checkRectangleCircleCollision(
        player1.playerRect,
        Offset(ball.ballCircle.center.x, ball.ballCircle.center.y),
        ball.ballCircle.radius)) {
      botAnimation.smash(ballPosition.x, player1.x);
      ballDirection = 1;
    }

    if (checkRectangleCircleCollision(
        player2.playerRect,
        Offset(ball.ballCircle.center.x, ball.ballCircle.center.y),
        ball.ballCircle.radius)) {
      playerAnimation.smash(ballPosition.x, player2.x);
      ballDirection = -1;
    }

    if (!ballIsOut() && isCatch == false) {
      ballPosition += Vector2(0, ballDirection) * dt * ballSpeed;
    } else {
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
