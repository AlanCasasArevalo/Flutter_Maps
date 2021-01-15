part of 'custom_markers.dart';

class DestinationMarkerPainter extends CustomPainter {

  final double distance;
  final String description;

  DestinationMarkerPainter({this.distance, this.description});

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
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);
    
    // white box
    final whiteBox = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(whiteBox, paint);

    // black box
    paint.color = Colors.black87;
    final blackBox = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(blackBox, paint);
    
    // Numero de kilometros
    _textPainterBuilder(
      canvas: canvas,
      fontSize: 25,
      offset: Offset(0, 35),
      text: '${distance.toStringAsFixed(1)}',
      fontWeight: FontWeight.w400,
      minWidth: 70,
      maxWidth: 70
    );

    // Distancia
    _textPainterBuilder(
      canvas: canvas,
      fontSize: 15,
      offset: Offset(0,67),
      text: Constants.destinationWindowInformationDistance,
      fontWeight: FontWeight.w300,
        minWidth: 70,
        maxWidth: 70
    );

    // Descripcion
    _textPainterBuilder(
      canvas: canvas,
      fontSize: 20,
      offset: Offset(80, 35),
      text: this.description,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
      maxWidth: size.width - 100,
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
      textAlign: TextAlign.center,
      maxLines: 2,
      ellipsis: ' ...'
    )..layout(
      maxWidth: maxWidth,
      minWidth: minWidth
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(DestinationMarkerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(DestinationMarkerPainter oldDelegate) => false;
}