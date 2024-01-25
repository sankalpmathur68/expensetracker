import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostAPIs {
  addExpensToDataBase(Expense expense) async {
    final ref = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      ref.collection('users/$uid/expenses').add({
        "amount": expense.amount,
        'note': expense.note,
        'category': expense.category,
        'timestamp': expense.timestamp
      });
    } catch (e) {
      log("Error: $e");
    }
  }
}

class Expense {
  final String category;
  final int amount;
  final String note;
  final Timestamp timestamp;
  Expense(
      {required this.category,
      required this.timestamp,
      required this.amount,
      required this.note});
}
