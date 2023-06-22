// class who draw the tennis court with rect in 2d

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TennisCourt extends PositionComponent {
  late Rect tennisCounrtRect;
  late Rect tennisCounrtRectMidlePart;
  late Rect tennisCounrtRectMidleInPart1MidlePart;
  late Rect tennisCounrtRectMidleInPart1MidlePart1;
  late Rect tennisCounrtRectMidleInPart1MidlePart2;
  late Rect tennisCounrtRectMidleInPart2MidlePart;
  late Rect tennisCounrtRectMidleInPart2MidlePart1;
  late Rect tennisCounrtRectMidleInPart2MidlePart2;
  late Rect bitougnouTop;
  late Rect bitougnouBottom;

  Color color = Colors.white;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()
      ..color = Colors.white // Couleur des côtés du rectangle (blanc)
      ..style =
          PaintingStyle.stroke // Définir le style de dessin comme une ligne
      ..strokeWidth = 15.0; // Largeur de la ligne des côtés du rectangle

    tennisCounrtRect = toRect();
    tennisCounrtRectMidlePart = Rect.fromLTWH(
        tennisCounrtRect.left,
        tennisCounrtRect.top,
        tennisCounrtRect.width,
        tennisCounrtRect.height / 2);

    bitougnouTop = Rect.fromLTWH(
        tennisCounrtRect.left + tennisCounrtRect.width / 2,
        tennisCounrtRectMidlePart.top,
        1,
        15);

    bitougnouBottom = Rect.fromLTWH(
        tennisCounrtRect.left + tennisCounrtRect.width / 2,
        tennisCounrtRectMidlePart.top +
            tennisCounrtRectMidlePart.height * 2 -
            15,
        1,
        15);

    tennisCounrtRectMidleInPart1MidlePart = Rect.fromLTWH(
        tennisCounrtRectMidlePart.left +
            tennisCounrtRectMidlePart.width * 0.25 / 2,
        tennisCounrtRectMidlePart.top,
        tennisCounrtRectMidlePart.width * 0.75,
        tennisCounrtRectMidlePart.height);

    tennisCounrtRectMidleInPart1MidlePart1 = Rect.fromLTWH(
        tennisCounrtRectMidleInPart1MidlePart.left,
        tennisCounrtRectMidleInPart1MidlePart.top +
            tennisCounrtRectMidleInPart1MidlePart.height / 2,
        tennisCounrtRectMidleInPart1MidlePart.width / 2,
        tennisCounrtRectMidleInPart1MidlePart.height / 2);

    tennisCounrtRectMidleInPart1MidlePart2 = Rect.fromLTWH(
        tennisCounrtRectMidleInPart1MidlePart.left +
            tennisCounrtRectMidleInPart1MidlePart.width / 2,
        tennisCounrtRectMidleInPart1MidlePart.top +
            tennisCounrtRectMidleInPart1MidlePart.height / 2,
        tennisCounrtRectMidleInPart1MidlePart.width / 2,
        tennisCounrtRectMidleInPart1MidlePart.height / 2);

    tennisCounrtRectMidleInPart2MidlePart = Rect.fromLTWH(
        tennisCounrtRectMidlePart.left +
            tennisCounrtRectMidlePart.width * 0.25 / 2,
        tennisCounrtRectMidlePart.top + tennisCounrtRectMidlePart.height,
        tennisCounrtRectMidlePart.width * 0.75,
        tennisCounrtRectMidlePart.height);

    tennisCounrtRectMidleInPart2MidlePart1 = Rect.fromLTWH(
        tennisCounrtRectMidleInPart2MidlePart.left +
            tennisCounrtRectMidleInPart2MidlePart.width * 0.50,
        tennisCounrtRectMidleInPart2MidlePart.top,
        tennisCounrtRectMidleInPart2MidlePart.width * 0.50,
        tennisCounrtRectMidleInPart2MidlePart.height / 2);

    tennisCounrtRectMidleInPart2MidlePart2 = Rect.fromLTWH(
        tennisCounrtRectMidleInPart2MidlePart.left,
        tennisCounrtRectMidleInPart2MidlePart.top,
        tennisCounrtRectMidleInPart2MidlePart.width * 0.50,
        tennisCounrtRectMidleInPart2MidlePart.height / 2);

    canvas.drawRect(tennisCounrtRect, paint);
    paint = Paint()
      ..color = Colors.green // Couleur transparente
      ..style =
          PaintingStyle.fill; // Définir le style de dessin comme un remplissage

    canvas.drawRect(tennisCounrtRect, paint);

    paint = Paint()
      ..color = Colors.white // Couleur transparente
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawRect(tennisCounrtRectMidlePart, paint);
    canvas.drawRect(tennisCounrtRectMidleInPart1MidlePart, paint);
    canvas.drawRect(tennisCounrtRectMidleInPart1MidlePart1, paint);
    canvas.drawRect(tennisCounrtRectMidleInPart1MidlePart2, paint);
    canvas.drawRect(tennisCounrtRectMidleInPart2MidlePart, paint);
    canvas.drawRect(tennisCounrtRectMidleInPart2MidlePart1, paint);
    canvas.drawRect(tennisCounrtRectMidleInPart2MidlePart2, paint);
    canvas.drawRect(bitougnouTop, paint);
    canvas.drawRect(bitougnouBottom, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
