import 'dart:js';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

import 'package:flutter/material.dart';

class Ball extends PositionComponent {
  late Circle ballCircle;
  late Circle BallShadow;
  late Vector2 pos;
  Color color = Colors.yellow;
  Color shadowColor = Color.fromARGB(155, 0, 0, 0);
  late Vector2 screenSize;

  late double amplitude; // Amplitude de la sinusoïde
  late double period; // Périod of the sinusoïde

  Ball({required this.pos, required this.screenSize}) {
    ballCircle = Circle(pos, 10);
    amplitude = screenSize.x * 0.05;
    period = screenSize.y / 1;
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final posXInSin = amplitude *
        sin(
          2 * pi * ballCircle.center.y / period,
        ).abs();

    final radius = 8 + posXInSin / 20;

    Offset offsetShadow =
        Offset(posXInSin + ballCircle.center.x, ballCircle.center.y + 10);
    canvas.drawCircle(offsetShadow, radius - 2, Paint()..color = shadowColor);

    Offset offset = Offset(ballCircle.center.x, ballCircle.center.y);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }
}
