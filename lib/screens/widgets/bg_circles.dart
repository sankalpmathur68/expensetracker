// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';

// class RandomMotionCircles extends StatefulWidget {
//   final w;
//   final h;
//   RandomMotionCircles({required this.w, required this.h});
//   @override
//   _RandomMotionCirclesState createState() => _RandomMotionCirclesState();
// }

// class _RandomMotionCirclesState extends State<RandomMotionCircles> {
//   List<Circle> circles = [];

//   @override
//   void initState() {
//     super.initState();
//     // Generate initial set of circles
//     generateCircles();
//     // Start a periodic timer to update the motion of circles
//     Timer.periodic(Duration(milliseconds: 16), (timer) {
//       updateCirclesMotion();
//     });
//   }

//   void generateCircles() {
//     final random = Random();
//     circles = List.generate(
//       10, // Number of circles
//       (index) => Circle(
//         radius: random.nextDouble() * 100,
//         key: UniqueKey(),
//         position: Offset(
//           random.nextDouble() * 200, // Adjust the range as needed
//           random.nextDouble() * 200, // Adjust the range as needed
//         ),
//         velocity: Offset(
//           (random.nextDouble() - 0.5) * 5, // Adjust the range as needed
//           (random.nextDouble() - 0.5) * 5, // Adjust the range as needed
//         ),
//       ),
//     );
//   }

//   void updateCirclesMotion() {
//     setState(() {
//       circles.forEach((circle) {
//         // Update the position based on the velocity
//         circle.position += circle.velocity;

//         // Bounce off the edges of the container
//         if (circle.position.dx < 0 || circle.position.dx > widget.w) {
//           circle.velocity = Offset(-circle.velocity.dx, circle.velocity.dy);
//         }
//         if (circle.position.dy < 0 || circle.position.dy > widget.h) {
//           circle.velocity = Offset(circle.velocity.dx, -circle.velocity.dy);
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Screen_h = MediaQuery.of(context).size.height;
//     final Screen_w = MediaQuery.of(context).size.width;
//     return Container(
//       width: Screen_w,
//       height: Screen_h,
//       color: Colors.transparent,
//       child: Stack(
//         children: circles.map((circle) {
//           return Positioned(
//             left: circle.position.dx,
//             top: circle.position.dy,
//             child: CustomPaint(
//               painter: MyPainter(
//                   x: circle.position.dx,
//                   y: circle.position.dy,
//                   r: circle.radius + 10),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class Circle {
//   final Key key;
//   Offset position;
//   Offset velocity;
//   double radius;

//   Circle({
//     required this.key,
//     required this.radius,
//     required this.position,
//     required this.velocity,
//   });
// }

// class CircleWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 20,
//       height: 20,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.blue,
//       ),
//     );
//   }
// }

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
//   final x;
//   final y;
//   final r;
//   MyPainter({this.x, this.y, this.r});
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Color(int.parse('0xFFF05941'))
//       ..style = PaintingStyle.fill;

//     // Calculate the center of the canvas
//     // Offset center = Offset(size.width / 2, size.height / 2);

//     // // Calculate the radius of the circle
//     // double radius = size.width / 2;

//     // Draw the circle on the canvas
//     canvas.drawCircle(Offset(x, y), r, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
