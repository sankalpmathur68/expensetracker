import 'dart:developer';

import 'package:expensetracker/APIs/delete_apis.dart';
import 'package:expensetracker/APIs/fetch_apis.dart';
import 'package:expensetracker/APIs/post_apis.dart';
import 'package:expensetracker/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AllExpenseCubit extends Cubit<AllExpenseState> {
  AllExpenseCubit() : super(AllExpenseLoading()) {
    fetchExpenseList();
  }
  List<Expense> expenseList = [];
  fetchExpenseList() async {
    log('callled');
    expenseList.clear();
    filteredExpenses.clear();
    List<Expense>? allExpenses = await FetchApis().fetchSortedExpenses();
    expenseList.addAll(allExpenses!);
    filteredExpenses.addAll(allExpenses);

    // buildCharts();
    filterExpenses(DateTime.now().month, DateTime.now().year);
    // emit(AllExpenseInitial(listExpenses: allExpenses));
  }

  Map<String, Map<String, dynamic>> allCategories = {};
  double max = 0;
  double min = 0;
  double totalExpenseofmonth = 0;
  List<Expense> filteredExpenses = [];
  filterExpenses(month, year) {
    totalExpenseofmonth = 0;

    log("calledcc");
    emit(AllExpenseLoading());
    filteredExpenses.clear();
    year ??= DateTime.now().year;
    for (Expense expense in expenseList) {
      // log(expense.timestamp.toDate().runtimeType.toString());
      // log(year.toString());
      if (expense.timestamp.toDate().month.toString() == month.toString() &&
          expense.timestamp.toDate().year.toString() == year.toString()) {
        filteredExpenses.add(expense);
      }
    }
    buildCharts();
    emit(AllExpenseInitial(
        listExpenses: filteredExpenses,
        total: totalExpenseofmonth,
        month: month?.toString(),
        year: year?.toString()));
  }

  deleteSelectedExpense(expenseId) {
    DeletApis().deleteExpenseFromDatabase(expenseId);
    filterExpenses(DateTime.now().month, DateTime.now().year);
  }

  filterExpensesAccordingRange(RangeDateTime range) {
    totalExpenseofmonth = 0;

    emit(AllExpenseLoading());
    filteredExpenses.clear();
    log(range.end.add(Duration(days: 1)).toString());
    log(range.start.subtract(Duration(days: 1)).toString());

    for (Expense expense in expenseList) {
      if (expense.timestamp
              .toDate()
              .isBefore(range.end.add(Duration(days: 1))) &&
          (expense.timestamp.toDate().isAfter(range.start))) {
        // log((AppData().months[expense.timestamp.toDate().month] == _month)
        //     .toString());
        // log(expense.category.toString());
        filteredExpenses.add(expense);
      }
    }
    buildCharts();
    emit(AllExpenseInitial(
        listExpenses: filteredExpenses,
        pickedRange: range,
        total: totalExpenseofmonth));
  }

  Future<RangeDateTime?> selectDateRange(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime initialStartDate = now.subtract(
        const Duration(days: 7)); // Set initial start date (e.g., 7 days ago)
    DateTime initialEndDate = now; // Set initial end date as today

    DateTimeRange? picked = await showDateRangePicker(
      barrierColor: Colors.blue.shade200,
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      saveText: "Continue",
      initialDateRange:
          DateTimeRange(start: initialStartDate, end: initialEndDate),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            // accentColor: Colors.blue,
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // selectedRowDecoration: BoxDecoration(
            //   color: Colors.blue.shade200, // Set the background color for the selected range
            // ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      filterExpensesAccordingRange(RangeDateTime(picked.start, picked.end));
      // emit(AllExpenseInitial(
      //     listExpenses: expenseList,
      //     pickedRange: RangeDateTime(picked.start, picked.end)));
      // log((picked.start.day).toString());
      // log((picked.end).toString());
      // return RangeDateTime(picked.start, picked.end);
    } else {
      return null; // User canceled the date range selection
    }
    return null;
  }

  buildCharts() {
    log("buildchart");
    totalExpenseofmonth = 0;
    max = 0;
    min = 10000000000000000000000;
    allCategories.clear();
    for (Expense i in filteredExpenses) {
      if (allCategories[i.category] == null) {
        allCategories[i.category] = {'expenses': [], 'amount': 0};
      }
      allCategories[i.category]?['expenses']?.add(i);
      allCategories[i.category]?['amount'] += i.amount;
      totalExpenseofmonth += i.amount;
    }
    // log(allCategories[0].toString());
    final keys = allCategories.keys.toList();
    if (allCategories.isNotEmpty) {
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

class RangeDateTime {
  DateTime start;
  DateTime end;
  RangeDateTime(this.start, this.end);
}

class AllExpenseInitial extends AllExpenseState {
  List<Expense>? listExpenses;
  String? month;
  String? year;
  RangeDateTime? pickedRange;
  double? total;
  AllExpenseInitial(
      {this.total, this.listExpenses, this.month, this.pickedRange, this.year});
}

class AllExpenseLoading extends AllExpenseState {}

// class AllExpenseGraphCreated extends AllExpenseState {
//   List<Expense>? listExpenses;
//   final allcategories;
//   AllExpenseGraphCreated({this.allcategories, this.listExpenses});
// }

class AllExpenseState {}
