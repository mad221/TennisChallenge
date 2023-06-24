import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class PlayerAnimation {
  late SpriteAnimation player1AnimationMoveLeft;
  late SpriteAnimation player1AnimationMoveRight;
  late SpriteAnimation player1AnimationSelect;
  late Images playerImage;

  PlayerAnimation({required this.playerImage});

  Future<void> onLoad() async {
    // Note that you could also use Sprite.load for this.
    final imgLeft = await playerImage.load('sprites/playerOneMovement.png');
    final imgRight =
        await playerImage.load('sprites/playerOneMovementRight.png');

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
    player1AnimationSelect = player1AnimationMoveLeft;
  }

  void selectRightAnimation() {
    player1AnimationSelect = player1AnimationMoveRight;
  }

  void render(Canvas canvas, Rect player) {
    player1AnimationSelect.getSprite().renderRect(canvas, player);
  }

  void update(double dt) {
    player1AnimationSelect.update(dt);
  }
}
