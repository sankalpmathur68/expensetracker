import 'package:expensetracker/cubit/all_expense_cubit.dart';
import 'package:expensetracker/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class showRange extends StatelessWidget {
  const showRange({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExpenseCubit, AllExpenseState>(
      builder: (context, state) {
        if (state is AllExpenseInitial) {
          if (state.pickedRange == null) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${state.pickedRange?.start.day}/${state.pickedRange?.start.month}/${state.pickedRange?.start.year}",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "-",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.w100),
                    ),
                    Text(
                      "${state.pickedRange?.end.day}/${state.pickedRange?.end.month}/${state.pickedRange?.end.year}",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
