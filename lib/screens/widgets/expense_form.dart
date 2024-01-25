import 'package:expensetracker/screens/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class ExpenseForm extends StatelessWidget {
  const ExpenseForm({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // margin: EdgeInsets.all(8),
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TakeInput(
                icon: Image.asset(
                  "assets/images/rupee-sign-svgrepo-com_1.png",
                  width: 30,
                  height: 30,
                ),
                obsecureText: false,
                inputTitle: "Enter Amount",
                onUpdate: (value) {}),
            Container(
              // duration: const Duration(seconds: 1),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 0),
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1))
              ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
            )
          ],
        )
      ]),
    );
  }
}
