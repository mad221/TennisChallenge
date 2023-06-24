import 'dart:js';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

import 'package:flutter/material.dart';

class Ball extends PositionComponent with CollisionCallbacks {
  late Circle ballCircle;
  late Vector2 pos;
  Color color = Colors.yellow;

  Ball({required this.pos}) {
    ballCircle = Circle(pos, 10);
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Offset offset = Offset(ballCircle.center.x, ballCircle.center.y);
    canvas.drawCircle(offset, 10, Paint()..color = color);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
  }
}
