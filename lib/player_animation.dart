import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class PlayerAnimation {
  late SpriteAnimation player1AnimationMoveLeft;
  late SpriteAnimation player1AnimationMoveRight;
  late SpriteAnimation player1AnimationSelect;
  late Images playerImage;
  late String pathImageLeft;
  late String pathImageRight;

  PlayerAnimation(
      {required this.playerImage,
      required this.pathImageLeft,
      required this.pathImageRight});

  Future<void> onLoad() async {
    // Note that you could also use Sprite.load for this.
    final imgLeft = await playerImage.load(pathImageLeft);
    final imgRight = await playerImage.load(pathImageRight);

    player1AnimationMoveLeft = SpriteAnimation.fromFrameData(
        imgLeft,
        SpriteAnimationData.sequenced(
          amount: 3,
          textureSize: Vector2(32, 32),
          texturePosition: Vector2(196, 60),
          stepTime: 0.1,
        ));
    player1AnimationMoveRight = SpriteAnimation.fromFrameData(
        imgRight,
        SpriteAnimationData.sequenced(
          amount: 3,
          textureSize: Vector2(32, 32),
          amountPerRow: 3,
          stepTime: 0.1,
        ));

    player1AnimationSelect = player1AnimationMoveRight;
  }

  void selectLeftAnimation() {
    if (player1AnimationSelect != player1AnimationMoveLeft) {
      player1AnimationSelect = player1AnimationMoveLeft;
    }
  }

  void selectRightAnimation() {
    if (player1AnimationSelect != player1AnimationMoveRight) {
      player1AnimationSelect = player1AnimationMoveRight;
    }
  }

  void render(Canvas canvas, Rect player) {
    player1AnimationSelect.getSprite().renderRect(canvas, player);
  }

  void update(double dt) {
    player1AnimationSelect.update(dt);
  }
}
