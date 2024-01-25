import 'dart:async';

import 'package:expensetracker/APIs/wholeAppData.dart';
import 'package:expensetracker/cubit/all_Expense_cubit.dart';
import 'package:expensetracker/screens/widgets/loading_widget.dart';

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
          padding: const EdgeInsets.all(8.0),
          child: LimitedBox(
            maxHeight: 500,
            maxWidth: double.infinity,
            child: ListView.builder(
                itemCount: state.listExpenses?.length,
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2),
                itemBuilder: (BuildContext context, index) {
                  return ConnectionState == ConnectionState.waiting
                      ? NoteLoadingWidget()
                      : Padding(
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
                              title: state.listExpenses?[index].category != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.listExpenses?[index].category}",
                                        style: GoogleFonts.roboto(fontSize: 20),
                                      ),
                                    )
                                  : NoteLoadingWidget(),
                              subtitle: state.listExpenses?[index].note == ''
                                  ? Container()
                                  : state.listExpenses?[index].note != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${state.listExpenses?[index].note}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : NoteLoadingWidget(),
                              leading: Icon(AppData().list_icon[
                                  state.listExpenses?[index].category]),
                              trailing:
                                  state.listExpenses?[index].amount != null
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
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          width: 100,
                                          child: NoteLoadingWidget()),
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
      duration: Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedOpacity(
          opacity: animate ? 0 : 1,
          duration: Duration(seconds: 1),
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
