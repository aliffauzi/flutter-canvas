import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_canvas/utils/utils.dart';

class ArrowCirclePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final colorList = [Utils.colorRandom(), Utils.colorRandom(), Utils.colorRandom(), Utils.colorRandom()];
    final centerPoint = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 * 0.9;
    final strokeWidth = radius * 0.4;
    final arrowRadius = strokeWidth / 2 * 1.4;
    final paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth;
    final n = 4;
    final eachDegree = 360 / n;
    final rect = Rect.fromCircle(center: centerPoint, radius: radius - (strokeWidth / 2));
    for (var i = 0; i < n; i++) {
      paint.color = colorList[i];
      canvas.drawArc(rect, Utils.degreeToRadian(i*eachDegree), Utils.degreeToRadian(eachDegree), false, paint);
    }

    paint.style = PaintingStyle.fill;
    for (var i = 0; i < n; i++) {
      paint.color = colorList[i];
      final arrowDegree = i * eachDegree +  eachDegree;
      final arrowRadian = Utils.degreeToRadian(arrowDegree);
      final arrowDrawPoint = Offset(cos(arrowRadian) * (radius - (strokeWidth / 2)), sin(arrowRadian) * (radius-(strokeWidth / 2))) + centerPoint;
      final path = Path();
      for (var i = 0; i < 3; i++) {
        final degree = arrowDegree + (i * eachDegree);
        final radian = Utils.degreeToRadian(degree);
        final endPoint = Offset(cos(radian) * arrowRadius, sin(radian) * arrowRadius) + arrowDrawPoint;
        if(i == 0){
          path.moveTo(endPoint.dx, endPoint.dy);
        }
        else{
          path.lineTo(endPoint.dx, endPoint.dy);
        }
      }
      canvas.drawPath(path, paint);
    }
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
  
}