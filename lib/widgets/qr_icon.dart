import 'package:flutter/material.dart';

class QrIcon extends StatelessWidget {
  const QrIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CustomPaint(
          painter: BorderPainter(),
          child: Container(
            width: BarReaderSize.width,
            height: BarReaderSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 4.5,
                      height: 4.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.zero),
                    ),
                    Container(
                      width: 4.5,
                      height: 4.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.zero),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 4.5,
                      height: 4.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.zero),
                    ),
                    CustomPaint(
                        painter: BorderPainter1(),
                        child: Container(
                          width: 4.2,
                          height: 4.2,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BorderPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = .08;
    final radius = .35;
    final tRadius = 4 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.zero);
    final clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect4 = Rect.fromLTWH(
      1.4,
      1.4,
      1.4,
      1.4,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3)
      ..addRect(clippingRect4);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 1.0;
    final radius = 3.0;
    final tRadius = 2 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.zero);
    final clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 20;
  static double height = 20;
}
