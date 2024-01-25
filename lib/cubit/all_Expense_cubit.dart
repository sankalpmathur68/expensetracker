import 'dart:developer';

import 'package:expensetracker/APIs/fetch_apis.dart';
import 'package:expensetracker/APIs/post_apis.dart';
import 'package:expensetracker/APIs/wholeAppData.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AllExpenseCubit extends Cubit<AllExpenseState> {
  AllExpenseCubit() : super(AllExpenseLoading()) {
    fetchExpenseList();
  }
  List<Expense> expenseList = [];
  fetchExpenseList() async {
    log('callled');
    List<Expense>? allExpenses = await FetchApis().fetchSortedExpenses();
    expenseList.addAll(allExpenses!);
    buildCharts();
    filterExpenses(AppData().months[DateTime.now().month.toString()]);
    // emit(AllExpenseInitial(listExpenses: allExpenses));
  }

  Map<String, Map<String, dynamic>> allCategories = {};
  double max = 0;
  double min = 0;
  filterExpenses(_month) {
    emit(AllExpenseLoading());
    List<Expense> filteredExpenses = [];
    for (Expense expense in expenseList) {
      if (AppData().months[expense.timestamp.toDate().month.toString()] ==
          _month) {
        // log((AppData().months[expense.timestamp.toDate().month] == _month)
        //     .toString());
        // log(expense.category.toString());
        filteredExpenses.add(expense);
      }
    }
    emit(AllExpenseInitial(listExpenses: filteredExpenses, month: _month));
  }

  buildCharts() {
    max = 0;
    min = 10000000000000000000000;

    for (Expense i in expenseList) {
      if (allCategories[i.category] == null) {
        allCategories[i.category] = {'expenses': [], 'amount': 0};
      }
      allCategories[i.category]?['expenses']?.add(i);
      allCategories[i.category]?['amount'] += i.amount;
    }
    // log(allCategories[0].toString());
    final keys = allCategories.keys.toList();
    if (!allCategories.isEmpty) {
      for (int i = 0; i < keys.length; i++) {
        if (allCategories[keys[i]]?['amount'] > max) {
          max = double.parse(allCategories[keys[i]]!['amount'].toString());
        }
        if (allCategories[keys[i]]?['amount'] < min) {
          // min = double.parse(allCategories[keys[i]]?['amount']);
          min = double.parse(allCategories[keys[i]]!['amount'].toString());
        }
      }
    }
  }
}

class AllExpenseInitial extends AllExpenseState {
  List<Expense>? listExpenses;
  String? month;
  AllExpenseInitial({this.listExpenses, this.month});
}

class AllExpenseLoading extends AllExpenseState {}

// class AllExpenseGraphCreated extends AllExpenseState {
//   List<Expense>? listExpenses;
//   final allcategories;
//   AllExpenseGraphCreated({this.allcategories, this.listExpenses});
// }

class AllExpenseState {}
