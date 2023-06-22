import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Player extends PositionComponent {
  late Rect playerRect;
  late Color color;

  Player({required this.color});

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    playerRect = toRect();
    canvas.drawRect(playerRect, Paint()..color = color);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
