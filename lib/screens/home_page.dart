import 'package:expensetracker/cubit/all_Expense_cubit.dart';
import 'package:expensetracker/cubit/auth_cubit.dart';
import 'package:expensetracker/screens/loading_screen.dart';
import 'package:expensetracker/screens/widgets/expense_list.dart';
import 'package:expensetracker/screens/widgets/expense_chart.dart';
import 'package:expensetracker/screens/widgets/expense_filter.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.amber,
          // foregroundColor: Colors.amber,
          title: const Text("SpendWise"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    context.go('/add_expenses');
                  },
                  child: const Icon(CupertinoIcons.add)),
            )
          ]),
      body: BlocProvider(
        create: (context) => AllExpenseCubit(),
        child: BlocBuilder<AllExpenseCubit, AllExpenseState>(
          builder: (context, state) {
            if (state is AllExpenseLoading) {
              return LoadingScreen();
            } else
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const ExpenseFilter(),
                    ExpenseChart(),
                    // BlocProvider(
                    //   create: (context) => AllExpenseCubit(),
                    //   child: const ExpenseChart(),
                    // ),
                    const ExpenseList(),
                    const Text('Signout'),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
