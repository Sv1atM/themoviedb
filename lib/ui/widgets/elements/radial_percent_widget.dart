import 'dart:math' show pi;

import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {
  final double percent;
  final double radius;
  final Color? backgroundColor;
  final Color? lineColor;
  final Widget? child;

  const RadialPercentWidget({
    Key? key,
    this.percent = 0.0,
    required this.radius,
    this.backgroundColor,
    this.lineColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2 * radius,
      height: 2 * radius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _RadialPercentWidgetPainter(
            percent: percent,
            radius: radius,
            backgroundColor: backgroundColor ?? Colors.black,
            lineColor: lineColor ?? Colors.white,
          )),
          Center(child: child),
        ],
      ),
    );
  }
}

class _RadialPercentWidgetPainter extends CustomPainter {
  final double percent;
  final Color backgroundColor;
  final Color lineColor;
  final double radius;
  static final _twoPi = 2 * pi;
  static final _halfPi = pi / 2;

  _RadialPercentWidgetPainter({
    required this.percent,
    required this.radius,
    required this.backgroundColor,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var arcRect = _calculateArcRect(size);
    _drawBackground(canvas, size);
    _drawFreeArc(canvas, arcRect);
    _drawFilledArc(canvas, arcRect);
  }

  Rect _calculateArcRect(Size size) {
    final margin = radius * 0.15;
    return Offset(margin, margin) & Size(2 * (radius - margin), 2 * (radius - margin));
  }

  void _drawBackground(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  void _drawFreeArc(Canvas canvas, Rect arcRect) {
    final paint = Paint()
      ..color = lineColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.1;
    canvas.drawArc(arcRect, _twoPi * percent - _halfPi, _twoPi * (1.0 - percent), false, paint);
  }

  void _drawFilledArc(Canvas canvas, Rect arcRect) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.1
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, -_halfPi, _twoPi * percent, false, paint);
  }

  @override
  bool shouldRepaint(covariant _RadialPercentWidgetPainter oldDelegate) => false;
}
