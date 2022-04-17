import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

class OvalPaint extends StatelessWidget {
  const OvalPaint({Key? key}) : super(key: key);

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
    path_0.moveTo(size.width * 0.3332258, size.height * 0.5505951);
    path_0.cubicTo(size.width * 0.5710824, size.height * 0.7787963, size.width * 0.6502505, size.height * 1.089806,
        size.width * 0.5100563, size.height * 1.245252);
    path_0.cubicTo(size.width * 0.3698621, size.height * 1.400698, size.width * 0.06338975, size.height * 1.341720,
        size.width * -0.1744668, size.height * 1.113525);
    path_0.cubicTo(size.width * -0.4123234, size.height * 0.8853290, size.width * -0.4914942, size.height * 0.5743109,
        size.width * -0.3512919, size.height * 0.4188620);
    path_0.cubicTo(size.width * -0.2110895, size.height * 0.2634130, size.width * 0.09536924, size.height * 0.3223938,
        size.width * 0.3332258, size.height * 0.5505951);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff543864).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
