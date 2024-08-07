import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:expenditure_management/utils/global.dart';

class FireStoreService {
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference expenditures = FirebaseFirestore.instance
      .collection('users')
      .doc(Global.uid)
      .collection('expenditure');

  Future<List<Map<String, dynamic>>> getExpenditures() async {
    QuerySnapshot querySnapshot =
        await expenditures.orderBy('updated_date', descending: true).get();

    return querySnapshot.docs.map((doc) {
      return {
        'docId': doc.id.toString(),
        'expm': doc.data() as Map<String, dynamic>
      };
    }).toList();
  }

  Future<void> createExpenditure(ExpenditureModel expenditureModel) async {
    await expenditures.add(expenditureModel.toJson());
  }

  Future<void> updateExpenditure(
      String docId, ExpenditureModel expenditureModel) async {
    await expenditures.doc(docId).update(expenditureModel.toJson());
  }

  Future<void> deleteExpenditure(String docId) async {
    await expenditures.doc(docId).delete();
  }

  Future<void> deleteAllUserData(String docId) async {
    await user.doc(docId).delete();
  }

  Future<void> deleteAll() async {
    expenditures.get().then((snapshot) {
      for (DocumentSnapshot expm in snapshot.docs) {
        expm.reference.delete();
      }
    });
  }
}
