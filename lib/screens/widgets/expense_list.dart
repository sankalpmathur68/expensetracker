import 'dart:async';
import 'dart:developer';

import 'package:expensetracker/APIs/whole_app_data.dart';
import 'package:expensetracker/cubit/all_expense_cubit.dart';
import 'package:expensetracker/screens/widgets/loading_widget.dart';
import 'package:expensetracker/screens/widgets/styled_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExpenseCubit, AllExpenseState>(
        builder: (context, state) {
      if (state is AllExpenseInitial) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 16),
          child: LimitedBox(
            maxHeight: 300,
            maxWidth: double.infinity,
            child: ListView.builder(
                itemCount: state.listExpenses?.length,
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2),
                itemBuilder: (BuildContext context, index) {
                  log((state.listExpenses?.length).toString());
                  final day =
                      '${state.listExpenses![index].timestamp.toDate().day < 10 ? "0${state.listExpenses?[index].timestamp.toDate().day}" : state.listExpenses?[index].timestamp.toDate().day}/';
                  final month =
                      '${state.listExpenses![index].timestamp.toDate().month < 10 ? "0${state.listExpenses?[index].timestamp.toDate().month}" : state.listExpenses?[index].timestamp.toDate().month}/';
                  final year =
                      '${state.listExpenses?[index].timestamp.toDate().year}';
                  final date = day + month + year;
                  final hour =
                      '${state.listExpenses![index].timestamp.toDate().hour < 10 ? "0${state.listExpenses?[index].timestamp.toDate().hour}" : state.listExpenses?[index].timestamp.toDate().hour}';
                  final minute =
                      '${state.listExpenses![index].timestamp.toDate().minute < 10 ? "0${state.listExpenses?[index].timestamp.toDate().minute}" : state.listExpenses?[index].timestamp.toDate().minute}';

                  final time = "$hour:$minute";

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                      child: ListTile(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context_) {
                                return AlertDialog(
                                  title: const Text("Delete Expense"),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Text(
                                            "Do You Want To Delete This Expense ?"),
                                        StyledButton(
                                            onTap: () {
                                              BlocProvider.of<AllExpenseCubit>(
                                                      context)
                                                  .deleteSelectedExpense(state
                                                      .listExpenses?[index].id);
                                            },
                                            child: const Text("Continue")),
                                        StyledButton(
                                            onTap: () {},
                                            child: const Text("Keep Expense"))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        title: state.listExpenses?[index].category != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${state.listExpenses?[index].category}",
                                  style: GoogleFonts.roboto(fontSize: 20),
                                ),
                              )
                            : const NoteLoadingWidget(),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$date  $time'),
                        ),
                        leading: Icon(AppData()
                            .listIcon[state.listExpenses?[index].category]),
                        trailing: state.listExpenses?[index].amount != null
                            ? Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/rupee-sign-svgrepo-com_1.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    Text(
                                      "${state.listExpenses?[index].amount}",
                                      style: GoogleFonts.roboto(fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(
                                width: 100, child: NoteLoadingWidget()),
                        isThreeLine: false,
                        dense: true,
                      ),
                    ),
                  );
                }),
          ),
        );
      }
      return const Loading();
    });
  }
}

class NoteLoadingWidget extends StatefulWidget {
  const NoteLoadingWidget({super.key});

  @override
  State<NoteLoadingWidget> createState() => _NoteLoadingWidgetState();
}

class _NoteLoadingWidgetState extends State<NoteLoadingWidget> {
  bool animate = false;
  void _togglePosition() {
    if (mounted) {
      setState(() {
        animate = !animate;
      });
    }
  }

  @override
  void initState() {
    _togglePosition();
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _togglePosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedOpacity(
          opacity: animate ? 0 : 1,
          duration: const Duration(seconds: 1),
          child: Container(
            height: 10,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                gradient: const LinearGradient(colors: [
                  // Colors.grey,
                  Colors.grey,
                  Colors.white,
                  // animate ? Colors.grey : Colors.white,
                ])),
          ),
        ),
      ),
    );
  }
}
