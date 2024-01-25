import 'dart:developer';

import 'package:expensetracker/APIs/wholeAppData.dart';
import 'package:expensetracker/cubit/all_Expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExpenseCubit, AllExpenseState>(
      builder: (context, state) {
        final allcategories =
            BlocProvider.of<AllExpenseCubit>(context).allCategories;
        final max = BlocProvider.of<AllExpenseCubit>(context).max;
        final min = BlocProvider.of<AllExpenseCubit>(context).min;
        log("$max $min");
        for (String i in allcategories.keys.toList()) {
          log((allcategories[i]!['amount']).toString());
          // log((((allcategories[i]?['amount']) / max) * (300)).toString());
        }
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
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
                  borderRadius: BorderRadius.circular(20)),
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      for (String i in allcategories.keys.toList()) ...[
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 800),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                  ),
                                ),
                                // height: 250,

                                height: state is AllExpenseInitial
                                    ? (((allcategories[i]?['amount']) / max) *
                                        (250))
                                    : 0,
                                width: 40,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RotatedBox(
                                      quarterTurns: 3, child: Text('$i')),
                                  Icon(AppData().list_icon['$i']),
                                ],
                              ),
                            ),
                          ],
                        )
                      ]
                    ]),
                  ],
                ),
              )),
        );
      },
    );
  }
}
