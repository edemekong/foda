import 'package:flutter/material.dart';
import 'package:foda/themes/app_theme.dart';

//Add this CustomPaint widget to the Widget Tree

class AmaobaPaint extends StatelessWidget {
  const AmaobaPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppTheme.size(context);
    return CustomPaint(
      size: Size(size.width, (size.width * 0.9029767677395006).toDouble()),
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5536019, size.height * -0.02835005);
    path_0.cubicTo(size.width * 0.7116701, size.height * -0.03968002, size.width * 0.8849088, size.height * 0.001391446,
        size.width * 0.9872922, size.height * 0.06507523);
    path_0.cubicTo(size.width * 1.094666, size.height * 0.1311478, size.width * 1.131184, size.height * 0.2198273,
        size.width * 1.131074, size.height * 0.3589481);
    path_0.cubicTo(size.width * 1.126958, size.height * 0.4992646, size.width * 1.103974, size.height * 0.5466796,
        size.width * 1.022353, size.height * 0.6269443);
    path_0.cubicTo(size.width * 0.9870295, size.height * 0.6647885, size.width * 0.9553485, size.height * 0.9256846,
        size.width * 0.8748859, size.height * 0.8869807);
    path_0.cubicTo(size.width * 0.7911891, size.height * 0.8467293, size.width * 0.7387051, size.height * 1.001902,
        size.width * 0.6627715, size.height * 0.8964775);
    path_0.cubicTo(size.width * 0.5689205, size.height * 0.7615310, size.width * 0.4062827, size.height * 1.004442,
        size.width * 0.3321788, size.height * 0.9654757);
    path_0.cubicTo(size.width * 0.2411989, size.height * 0.9250286, size.width * 0.4042141, size.height * 0.6747164,
        size.width * 0.2700087, size.height * 0.6201511);
    path_0.cubicTo(size.width * -0.06875325, size.height * 0.4824165, size.width * 0.3272844, size.height * 0.2654514,
        size.width * 0.2586745, size.height * 0.2034368);
    path_0.cubicTo(size.width * 0.09407083, size.height * 0.05465261, size.width * 0.3960902, size.height * -0.02005428,
        size.width * 0.5536019, size.height * -0.02835005);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff202040).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
