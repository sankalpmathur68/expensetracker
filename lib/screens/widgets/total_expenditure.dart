import 'package:expensetracker/cubit/all_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalExpenditure extends StatelessWidget {
  const TotalExpenditure({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExpenseCubit, AllExpenseState>(
      builder: (context, state) {
        if (state is AllExpenseInitial) {
          return Container(
            height: 50,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                      tween: IntTween(begin: 0, end: state.total?.toInt()),
                      duration: const Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total:",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              // snapshot.data.toString(),
                            ),
                            Image.asset(
                              "assets/images/rupee-sign-svgrepo-com_1.png",
                              height: 20,
                              width: 20,
                            ),
                            Text(
                              "$value",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              // snapshot.data.toString(),
                            ),
                          ],
                        );
                      }),
                  // Text(
                  //   "Total Expenditure ${BlocProvider.of<AllExpenseCubit>(context).totalExpenseofmonth}",
                  //   style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
