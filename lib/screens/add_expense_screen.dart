import 'dart:developer';

import 'package:expensetracker/cubit/catagories_cubit.dart';
import 'package:expensetracker/cubit/expense_cubit.dart';
import 'package:expensetracker/screens/widgets/catagory_widget.dart';
import 'package:expensetracker/screens/widgets/input_widget.dart';
import 'package:expensetracker/screens/widgets/styled_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenxe extends StatelessWidget {
  const AddExpenxe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Expense"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                return CategoryWidget(
                    selectedIcon: Icon(
                      BlocProvider.of<CategoryCubit>(context).iconList[
                          state is CategorySelected ? state.catagory : 'Transportation'],
                      color: Colors.white,
                    ),
                    selectedCategory:
                        state is CategorySelected ? state.catagory : '',
                    state: state is CategoryInitial ? 'initial' : 'selected',
                    inputTitle: "Search Categories",
                    iconMap: BlocProvider.of<CategoryCubit>(context).iconList,
                    onTapblock: (e) {
                      print(e);
                      BlocProvider.of<CategoryCubit>(context)
                          .updateToSelected(e);
                    },
                    onDeleteblock: () {
                      BlocProvider.of<CategoryCubit>(context).updateToInitial();
                    },
                    categories: state is CategoryInitial
                        ? state.catagories ?? BlocProvider.of<CategoryCubit>(context)
                                .searchedList
                        : BlocProvider.of<CategoryCubit>(context).searchedList,
                    onInputUpdate: (value) {
                      BlocProvider.of<CategoryCubit>(context).sortedList(value);
                    });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                return CategoryWidget(
                    selectedIcon: Image.asset(
                      "assets/images/rupee-sign-svgrepo-com_1.png",
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    inputIcon: Image.asset(
                      'assets/images/rupee-sign-svgrepo-com_1.png',
                      width: 20,
                      height: 20,
                    ),
                    selectedCategory:
                        state is Expenseselected ? state.amount : "",
                    state: state is ExpenseInitial ? 'initial' : 'selected',
                    inputTitle: "Enter Amount",
                    iconMap: BlocProvider.of<ExpenseCubit>(context).iconMap,
                    onTapblock: (e) {
                      BlocProvider.of<ExpenseCubit>(context)
                          .updateToSelected(e);
                    },
                    onDeleteblock: () {
                      BlocProvider.of<ExpenseCubit>(context).updateToInitial();
                    },
                    OnEmptyListTitle: '',
                    categories: state is ExpenseInitial
                        ? state.amountList ?? BlocProvider.of<ExpenseCubit>(context).categories
                        : BlocProvider.of<ExpenseCubit>(context).categories,
                    onInputUpdate: (e) {
                      BlocProvider.of<ExpenseCubit>(context).addAmountinlist(e);
                    });
              },
            ),
            BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TakeInput(
                      inputTitle: "Add Note...",
                      onUpdate: (value) {
                        if (state is Expenseselected) {
                          BlocProvider.of<ExpenseCubit>(context)
                              .updateToSelected(state.amount, note: value);
                        }
                      }),
                );
              },
            ),
            BlocBuilder<ExpenseCubit, ExpenseState>(
              builder: (context, stateExp) {
                return BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, stateCat) {
                    log(stateCat.toString());
                    if (stateExp is Expenseselected) {
                      if (stateCat is CategorySelected) {
                        return StyledButton(
                            onTap: () {
                              BlocProvider.of<ExpenseCubit>(context)
                                  .uploadExpenseToDatabase(stateExp.amount,
                                      stateCat.catagory, stateExp.note);
                            },
                            child: const Text('Add'));
                      }
                    }
                    return const SizedBox();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
