import 'dart:developer';

import 'package:expensetracker/APIs/whole_app_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(CategoryInitial(
          catagories: AppData().categories,
        ));

  final iconList = AppData().listIcon;
  final categoriesList = AppData().categories;
  List searchedList = AppData().categories;
  sortedList(input) {
    searchedList = [];

    for (String i in AppData().categories) {
      if (i.toString().toLowerCase().contains(input.toString())) {
        searchedList.add(i);
      } else {
        searchedList = [];
        searchedList.add(input);
      }
      emit(CategoryInitial(
        catagories: searchedList,
      ));
    }
  }

  addCategoryinlist(category) {
    final List categoriesList = [...AppData().categories];
    if (!categoriesList.contains(category)) {
      log("$category");
      categoriesList.add(category);
    }
    emit(CategoryInitial(catagories: categoriesList));
  }

  updateToSelected(category_) {
    log(category_);
    emit(CategorySelected(catagory: category_));
  }

  updateToInitial() {
    emit(CategoryInitial(catagories: AppData().categories));
  }
}

class CategoryInitial extends CategoryState {
  List catagories;

  CategoryInitial({required this.catagories});
}

class CategorySelected extends CategoryState {
  String catagory;
  CategorySelected({required this.catagory});
}

class CategoryState {}
