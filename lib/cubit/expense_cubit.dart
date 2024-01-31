import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/APIs/fetch_apis.dart';
import 'package:expensetracker/APIs/post_apis.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseInitial());
  final Map iconMap = {
    '10': Image.asset(
      'assets/images/rupee-sign-svgrepo-com_1.png',
      color: Colors.grey,
      width: 30,
      height: 30,
    ),
    '30': Image.asset(
      'assets/images/rupee-sign-svgrepo-com_1.png',
      color: Colors.grey,
      width: 30,
      height: 30,
    ),
    '50': Image.asset(
      'assets/images/rupee-sign-svgrepo-com_1.png',
      color: Colors.grey,
      width: 30,
      height: 30,
    ),
    '100': Image.asset(
      'assets/images/rupee-sign-svgrepo-com_1.png',
      color: Colors.grey,
      width: 30,
      height: 30,
    ),
    '500': Image.asset(
      'assets/images/rupee-sign-svgrepo-com_1.png',
      color: Colors.grey,
      width: 30,
      height: 30,
    ),
    '1000': Image.asset(
      'assets/images/rupee-sign-svgrepo-com_1.png',
      color: Colors.grey,
      width: 30,
      height: 30,
    ),
    '2000': Image.asset(
      'assets/images/rupee-sign-svgrepo-com_1.png',
      color: Colors.grey,
      width: 30,
      height: 30,
    ),
    // '50': Image.asset('assets/images/rupee-sign-svgrepo-com_1.png'),
  };

  addAmountinlist(amount) {
    final List categoriesList = [...categories];
    categoriesList.add(amount);
    emit(ExpenseInitial(amountList: categoriesList));
  }

  updateToSelected(amount, {note = ''}) {
    emit(Expenseselected(amount: amount, note: note));
  }

  updateToInitial() {
    emit(ExpenseInitial());
  }

  uploadExpenseToDatabase(amount, category, note) {
    final expense = Expense(
        category: category,
        amount: int.parse(amount.toString()),
        note: note,
        timestamp: Timestamp.now());
    PostAPIs().addExpensToDataBase(expense);
    FetchApis().fetchSortedExpenses();

    emit(ExpenseInitial());
  }

  final List categories = [
    '10',
    '30',
    '50',
    '100',
    '500',
    '1000',
    '2000',
  ];
}

class ExpenseInitial extends ExpenseState {
  final List? amountList;
  ExpenseInitial({this.amountList});
}

class Expenseselected extends ExpenseState {
  final amount;
  final note;
  Expenseselected({required this.amount, this.note});
}

class ExpenseState {}
