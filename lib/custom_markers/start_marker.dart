import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final double blackCircle = 20;
    final double whiteCircle = 7;

    Paint paint = new Paint()..color = Colors.black;

    canvas.drawCircle(
        Offset(blackCircle, size.height - blackCircle),
        blackCircle,
        paint
    );

    paint.color = Colors.white;

    canvas.drawCircle(
        Offset(blackCircle, size.height - blackCircle),
        whiteCircle,
        paint
    );

  }

  @override
  bool shouldRepaint(StartMarkerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(StartMarkerPainter oldDelegate) => false;
}