import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class PlayerAnimation {
  late SpriteAnimation playerMoveLeft;
  late SpriteAnimation playerMoveRight;
  late SpriteAnimation spriteMoveSelected;

  late SpriteAnimation playerLeftSmash;
  late SpriteAnimation playerRightSmash;
  late SpriteAnimation spriteSmashSelected;

  late Images playerImage;
  late String pathImageLeft;
  late String pathImageRight;
  late String pathImageRightSmash;
  late String pathImageLeftSmash;

  bool isSmash = false;

  PlayerAnimation(
      {required this.playerImage,
      required this.pathImageLeft,
      required this.pathImageRight,
      required this.pathImageLeftSmash,
      required this.pathImageRightSmash});

  Future<void> onLoad() async {
    // Note that you could also use Sprite.load for this.
    final imgLeft = await playerImage.load(pathImageLeft);
    final imgRight = await playerImage.load(pathImageRight);
    final imgleftSmash = await playerImage.load(pathImageLeftSmash);
    final imgRightSmash = await playerImage.load(pathImageRightSmash);

    playerMoveLeft = SpriteAnimation.fromFrameData(
        imgLeft,
        SpriteAnimationData.sequenced(
          amount: 3,
          textureSize: Vector2(32, 32),
          stepTime: 0.1,
        ));

    playerMoveRight = SpriteAnimation.fromFrameData(
        imgRight,
        SpriteAnimationData.sequenced(
          amount: 3,
          textureSize: Vector2(32, 32),
          amountPerRow: 3,
          stepTime: 0.1,
        ));

    playerLeftSmash = SpriteAnimation.fromFrameData(
        imgleftSmash,
        SpriteAnimationData.sequenced(
          amount: 6,
          textureSize: Vector2(32, 32),
          stepTime: 0.05,
          loop: false,
        ));

    playerRightSmash = SpriteAnimation.fromFrameData(
        imgRightSmash,
        SpriteAnimationData.sequenced(
            amount: 6,
            textureSize: Vector2(32, 32),
            stepTime: 0.05,
            loop: false));

    spriteMoveSelected = playerMoveRight;
  }

  void selectLeftAnimation() {
    if (spriteMoveSelected != playerMoveLeft) {
      spriteMoveSelected = playerMoveLeft;
    }
  }

  void selectRightAnimation() {
    if (spriteMoveSelected != playerMoveRight) {
      spriteMoveSelected = playerMoveRight;
    }
  }

  void smash(double ballPositionX, double playerPositionX) {
    if (ballPositionX > playerPositionX) {
      spriteSmashSelected = playerRightSmash;
    } else {
      spriteSmashSelected = playerLeftSmash;
    }
    spriteSmashSelected.reset();
    isSmash = true;
  }

  void render(Canvas canvas, Rect player) {
    if (isSmash == true) {
      spriteSmashSelected.getSprite().renderRect(canvas, player);
    } else {
      spriteMoveSelected.getSprite().renderRect(canvas, player);
    }
  }

  void update(double direction, double dt) {
    if (direction == 0 && isSmash == false) {
      spriteMoveSelected.update(0);
    } else if (isSmash == true) {
      spriteSmashSelected.update(dt);
      spriteSmashSelected.isLastFrame ? isSmash = false : isSmash = true;
    } else {
      spriteMoveSelected.update(dt);
    }
  }
}
