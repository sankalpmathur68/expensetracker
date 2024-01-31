import 'dart:developer';

import 'package:expensetracker/APIs/whole_app_data.dart';
import 'package:expensetracker/cubit/all_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (String i in allcategories.keys.toList()) ...[
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // SizedBox(
                                        //   height: state is AllExpenseInitial
                                        //       ? 220.0 -
                                        //           (((allcategories[i]
                                        //                       ?['amount']) /
                                        //                   max) *
                                        //               (220))
                                        //       : 220.0 - 0,
                                        // ),
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 800),
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
                                              ? (((allcategories[i]
                                                          ?['amount']) /
                                                      max) *
                                                  (220))
                                              : 0,
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        RotatedBox(
                                            quarterTurns: 3,
                                            child: Row(
                                              children: [
                                                Text(i),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Colors.white),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          TweenAnimationBuilder(
                                                              tween: IntTween(
                                                                begin: 0,
                                                                end: allcategories[
                                                                        i]
                                                                    ?['amount'],
                                                              ),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                                return Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/images/rupee-sign-svgrepo-com_1.png",
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                      value
                                                                          .toString(),
                                                                      style: GoogleFonts.roboto(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
                                                                      // snapshot.data.toString(),
                                                                    ),
                                                                  ],
                                                                );
                                                              }),
                                                    )),
                                              ],
                                            )),
                                        Icon(AppData().listIcon[i]),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]
                          ]),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
