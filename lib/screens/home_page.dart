import 'package:expensetracker/cubit/all_expense_cubit.dart';
import 'package:expensetracker/cubit/auth_cubit.dart';
import 'package:expensetracker/screens/loading_screen.dart';
import 'package:expensetracker/screens/widgets/expense_list.dart';
import 'package:expensetracker/screens/widgets/expense_chart.dart';
import 'package:expensetracker/screens/widgets/expense_filter.dart';
import 'package:expensetracker/screens/widgets/show_range.dart';
import 'package:expensetracker/screens/widgets/total_expenditure.dart';
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
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Spendwise"),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: BlocBuilder<AllExpenseCubit, AllExpenseState>(
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () async {
                        await BlocProvider.of<AllExpenseCubit>(context)
                            .fetchExpenseList();
                      },
                      child: const Icon(CupertinoIcons.refresh));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                  onTap: () {
                    context.go('/add_expenses');
                  },
                  child: const Icon(CupertinoIcons.add)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).signOut();
                  },
                  child: const Icon(Icons.logout)),
            )
          ]),
      body: BlocBuilder<AllExpenseCubit, AllExpenseState>(
        builder: (context, state) {
          if (state is AllExpenseLoading) {
            return const LoadingScreen();
          } else if (state is AllExpenseInitial) {
            return const SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ExpenseFilter(),
                  showRange(),
                  TotalExpenditure(),
                  ExpenseChart(),
                  ExpenseList(),
                ],
              ),
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
