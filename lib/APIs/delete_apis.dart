import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeletApis {
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
