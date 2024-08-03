import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  CollectionReference expenditures = FirebaseFirestore.instance
      .collection('users')
      .doc('mg1xi0ibayKsc8KnhR4u')
      .collection('expenditure');

  Future<List<Map<String, dynamic>>> getExpenditures() async {
    QuerySnapshot querySnapshot = await expenditures.get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> createExpenditure(ExpenditureModel expenditureModel) async {
    await expenditures.add(expenditureModel.toJson());
  }

  Future<void> updateExpenditure(String docId, String title, String amount,
      String category, String date) async {
    await expenditures.doc(docId).update({
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
    });
  }

  Future<void> deleteExpenditure(String docId) async {
    await expenditures.doc(docId).delete();
  }
}
