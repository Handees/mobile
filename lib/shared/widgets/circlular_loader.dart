// import 'package:flutter/material.dart';

// class CircularLoader extends StatelessWidget {
//   const CircularLoader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(300, 200),
//       painter: LinePainter(),

//     );
//   }
// }

// class LinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.teal
//       ..strokeWidth = 15;

//     Offset start = Offset(0, size.height / 2);
//     Offset end = Offset(size.width, size.height / 2);

//     canvas.drawLine(start, end, paint);
    

//     canvas.drawCircle(start, 25.0, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
