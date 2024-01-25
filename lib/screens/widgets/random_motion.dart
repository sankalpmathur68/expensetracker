// import 'dart:math';

// import 'package:expensetracker/screens/widgets/painter.dart';
// import 'package:flutter/material.dart';

// class RandomMotionWidget extends StatefulWidget {
//   @override
//   _RandomMotionWidgetState createState() => _RandomMotionWidgetState();
// }

// class _RandomMotionWidgetState extends State<RandomMotionWidget> {
//   double xPosition = 0;
//   double yPosition = 0;

//   @override
//   void initState() {
//     super.initState();
//     // Start the random motion when the widget is first created
//     startRandomMotion();
//   }

//   void startRandomMotion() {
//     // Generate random values for x and y positions
//     final random = Random();
//     xPosition = random.nextDouble() * 200; // Adjust the range as needed
//     yPosition = random.nextDouble() * 200; // Adjust the range as needed

//     // Trigger a rebuild to update the widget with the new positions
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//         curve: Curves.easeInOut,
//         parent: ModalRoute.of(context)!.animation!,
//       )),
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(xPosition, yPosition),
//           child: C(),
//         );
//       },
//     );
//   }
// }
