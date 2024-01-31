import 'dart:developer';

import 'package:expensetracker/APIs/whole_app_data.dart';
import 'package:expensetracker/cubit/all_expense_cubit.dart';
import 'package:expensetracker/screens/widgets/year_selector.dart';

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
                          builder: (context_) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                    children: months
                                        .map((e) => GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<
                                                            AllExpenseCubit>(
                                                        context)
                                                    .filterExpenses(
                                                        e, state.year);
                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                    AppData().intTomonths[e]),
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
                          child: state.month != null
                              ? Text(
                                  "${AppData().intTomonths[state.month]}",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Select Month",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context_2) {
                            return AlertDialog(
                              content: yearSelector(
                                onChanged: (year) {
                                  BlocProvider.of<AllExpenseCubit>(context)
                                      .filterExpenses(state.month, year);
                                },
                              ),
                            );
                          });
                    },
                    child: Container(
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
                      // child: yearSelector(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: state.year == null
                                ? Text(
                                    "Year",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "${state.year}",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AllExpenseCubit>(context)
                          .selectDateRange(context);
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
                        "Select Range",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      )),
                    ),
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
