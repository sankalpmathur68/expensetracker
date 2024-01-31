import 'package:expensetracker/screens/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(4, 7),
                      spreadRadius: 1,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1)),
                  BoxShadow(
                      offset: const Offset(4, 7),
                      spreadRadius: 1,
                      blurRadius: 10,
                      color: Colors.blue.withOpacity(0.2))
                ],
              ),
              height: 200,
              width: 200,
              child: const Loading())),
    );
  }
}
