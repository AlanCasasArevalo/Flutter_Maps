import 'package:Flutter_Maps/custom_markers/custom_markers.dart';
import 'package:flutter/material.dart';

class PagesToDesignWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
              color: Colors.cyan,
              width: 350,
              height: 150,
              child: CustomPaint(
                painter: DestinationMarkerPainter(
                  distance: 300000,
                  description: 'Chuck Norris rewrote the Google search engine from scratch.'
                ),
              ),
            )
        )
    );
  }
}
