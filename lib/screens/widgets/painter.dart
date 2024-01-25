// import 'package:flutter/material.dart';

// class CustomShape extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 200,
//       child: CustomPaint(
//         painter: MyPainter(),
//       ),
//     );
//   }
// }

// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Color(int.parse('0xFFF05941'))
//       ..style = PaintingStyle.fill;

//     // Calculate the center of the canvas
//     Offset center = Offset(size.width / 2, size.height / 2);

//     // Calculate the radius of the circle
//     double radius = size.width / 2;

//     // Draw the circle on the canvas
//     canvas.drawCircle(center, radius, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
