import 'package:expensetracker/screens/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SizedBox(height: 200, width: 200, child: Loading())),
    );
  }
}
