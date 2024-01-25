import 'dart:developer';

import 'package:expensetracker/APIs/wholeAppData.dart';
import 'package:expensetracker/cubit/all_Expense_cubit.dart';
import 'package:expensetracker/screens/loading_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseFilter extends StatelessWidget {
  const ExpenseFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExpenseCubit, AllExpenseState>(
      builder: (context, state) {
        log(state.toString());
        final months = AppData().months.values.toList();

        if (state is AllExpenseInitial) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // BlocProvider.of<AllExpenseCubit>(context)
                      //     .filterExpenses('February');

                      showDialog(
                          context: context,
                          builder: (_context) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                    children: months
                                        .map((e) => GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<
                                                            AllExpenseCubit>(
                                                        context)
                                                    .filterExpenses(e);
                                                Navigator.pop(_context);
                                              },
                                              child: ListTile(
                                                title: Text(e),
                                              ),
                                            ))
                                        .toList()),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 50,
                      width: 140,
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
                      child: Center(
                          child: Text(
                        "${state.month}",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Container(
                    // height: 50,
                    // width: 140,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "2024",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 140,
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
                    child: Center(
                        child: Text(
                      "Select Range",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
