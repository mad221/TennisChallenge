// class who draw the tennis court with rect in 2d

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

class TennisCourt extends PositionComponent {
  // get the position of the bounds of the player in the tennis court
  late double minPosPlayerX;
  late double maxPosPlayerX;

  // get the position of the bounds of the bot in the tennis court
  late double minPostBotX;
  late double maxPostBotX;

  late Images image;

  late Path tennisCourtPath;
  late Path tennisCourtMidlePartPath;
  late Path tennisCourtLongLinePath1;
  late Path tennisCourtLongLinePath2;
  late Path tennisCourtMidleInPart1MidlePartPath;
  late Path tennisCourtMidleInPart2MidlePartPath;

  late Rect bitougnouTop;
  late Rect bitougnouBottom;

  Color color = Colors.white;

  TennisCourt({required this.image}) {
    minPosPlayerX = size.x * 0.24;
    maxPosPlayerX = size.x * 0.75;

    minPostBotX = size.x * 0.15;
    maxPostBotX = size.x * 0.85;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()
      ..color = const Color.fromARGB(
          255, 255, 164, 27) // Couleur des côtés du rectangle (blanc)
      ..style =
          PaintingStyle.fill; // Définir le style de dessin comme une ligne

    tennisCourtPath = Path();
    tennisCourtPath.moveTo(size.x * 0.25, 10); // Coin supérieur gauche
    tennisCourtPath.lineTo(size.x * 0.75, 10); // Coin supérieur droit
    tennisCourtPath.lineTo(
        size.x * 0.85, size.y * 0.99); // Coin inférieur droit

    tennisCourtPath.lineTo(
        size.x * 0.15, size.y * 0.99); // Coin inférieur gauche
    tennisCourtPath.lineTo(size.x * 0.25, 10); // Coin supérieur gauche
    tennisCourtPath.close(); // Fermer le rectangle

    canvas.drawPath(tennisCourtPath, paint);

    paint = Paint()
      ..color = Colors.white // Couleur transparente
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5; // Définir le style de dessin comme une ligne
    canvas.drawPath(tennisCourtPath, paint);

    tennisCourtMidlePartPath = Path();
    tennisCourtMidlePartPath.moveTo(
        size.x * 0.205, size.y * 0.45); // Coin supérieur gauche
    tennisCourtMidlePartPath.lineTo(
        size.x * 0.795, size.y * 0.45); // Coin supérieur droit
    canvas.drawPath(tennisCourtMidlePartPath, paint);
    tennisCourtPath.close(); // Fermer le rectangle

    tennisCourtLongLinePath1 = Path();
    tennisCourtLongLinePath1.moveTo(size.x * 0.32, 10); // Coin supérieur gauche
    tennisCourtLongLinePath1.lineTo(
        size.x * 0.25, size.y * 0.99); // Coin supérieur droit
    canvas.drawPath(tennisCourtLongLinePath1, paint);

    tennisCourtLongLinePath2 = Path();
    tennisCourtLongLinePath2.moveTo(size.x * 0.68, 10); // Coin supérieur gauche
    tennisCourtLongLinePath2.lineTo(
        size.x * 0.75, size.y * 0.99); // Coin supérieur droit
    canvas.drawPath(tennisCourtLongLinePath2, paint);

    tennisCourtMidleInPart1MidlePartPath = Path();
    tennisCourtMidleInPart1MidlePartPath.moveTo(
        size.x * 0.50, size.y * 0.45); // Coin supérieur gauche
    tennisCourtMidleInPart1MidlePartPath.lineTo(
        // Coin supérieur droit
        size.x * 0.50,
        size.y * 0.75);
    tennisCourtMidleInPart1MidlePartPath.lineTo(
        // Coin supérieur droit
        size.x * 0.267,
        size.y * 0.75);
    tennisCourtMidleInPart1MidlePartPath.lineTo(
        // Coin supérieur droit
        size.x * 0.733,
        size.y * 0.75);
    canvas.drawPath(tennisCourtMidleInPart1MidlePartPath, paint);

    tennisCourtMidleInPart2MidlePartPath = Path();
    tennisCourtMidleInPart2MidlePartPath.moveTo(
        size.x * 0.50, size.y * 0.50); // Coin supérieur gauche
    tennisCourtMidleInPart2MidlePartPath.lineTo(
        // Coin supérieur droit
        size.x * 0.50,
        size.y * 0.23);
    tennisCourtMidleInPart2MidlePartPath.lineTo(
        // Coin supérieur gauche
        size.x * 0.305,
        size.y * 0.23);
    tennisCourtMidleInPart2MidlePartPath.lineTo(
        // Coin supérieur droit
        size.x * 0.695,
        size.y * 0.23);
    canvas.drawPath(tennisCourtMidleInPart2MidlePartPath, paint);

    bitougnouTop = Rect.fromLTWH(size.x * 0.5, 10, 1, 10);

    bitougnouBottom = Rect.fromLTWH(size.x * 0.5, size.y - 25, 1, 15);

    canvas.drawRect(bitougnouTop, paint);
    canvas.drawRect(bitougnouBottom, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
