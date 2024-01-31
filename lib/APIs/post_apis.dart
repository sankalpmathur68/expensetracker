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

  Future<void> deleteExpenseFromDatabase(String expenseId) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      // Reference to the 'expenses' collection for the specific user in Firestore
      CollectionReference expenses =
          FirebaseFirestore.instance.collection('users/$uid/expenses');

      // Use the expenseId to delete the document from the 'expenses' collection
      await expenses.doc(expenseId).delete();

      print('Expense deleted successfully');
    } catch (e) {
      print('Error deleting expense: $e');
      // Handle the error as needed
    }
  }
}

class Expense {
  final String? id;
  final String category;
  final int amount;
  final String note;
  final Timestamp timestamp;
  Expense(
      {this.id,
      required this.category,
      required this.timestamp,
      required this.amount,
      required this.note});
}
