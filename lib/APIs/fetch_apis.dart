import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/APIs/post_apis.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchApis {
  fetchSortedExpenses() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final ref = FirebaseFirestore.instance;

    try {
      QuerySnapshot snapshot = await ref
          .collection('users/$uid/expenses')
          .orderBy('timestamp')
          .get();
      List<Expense> expenses = snapshot.docs
          .map((doc) => Expense(
              id: doc.id,
              amount: doc['amount'],
              category: doc['category'],
              note: doc['note'],
              timestamp: doc['timestamp']))
          .toList();
      return expenses.reversed.toList();
    } catch (e) {
      log("Error: ${e.toString()}");
    }
  }
}
