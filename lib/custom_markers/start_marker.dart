part of 'custom_markers.dart';

class StartMarkerPainter extends CustomPainter {

  final int minutes;

  StartMarkerPainter(this.minutes);

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
    
    // Shadow
    final Path path = new Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);
    
    // white box
    final whiteBox = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(whiteBox, paint);

    // black box
    paint.color = Colors.black87;
    final blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, paint);
    
    // Textos
    _textPainterBuilder(
      canvas: canvas,
      fontSize: 30,
      offset: Offset(40,35),
      text: '$minutes',
      fontWeight: FontWeight.w400
    );

    // Tiempo
    _textPainterBuilder(
      canvas: canvas,
      fontSize: 20,
      offset: Offset(40,67),
      text: Constants.startMarkerDurationTime,
      fontWeight: FontWeight.w300
    );

    // Min
    _textPainterBuilder(
      canvas: canvas,
      fontSize: 22,
      offset: Offset(size.width/2.4, 50),
      text: Constants.startWindowInformationTitle,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
      maxWidth: size.width - 70,
      minWidth: 80
    );

  }

  void _textPainterBuilder(
      {Canvas canvas, double fontSize, FontWeight fontWeight, String text, Offset offset, Color color = Colors.white, double maxWidth = 70, double minWidth = 70}) {
    TextSpan textSpan = TextSpan(
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      text: text
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: maxWidth,
      minWidth: minWidth
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(StartMarkerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(StartMarkerPainter oldDelegate) => false;
}