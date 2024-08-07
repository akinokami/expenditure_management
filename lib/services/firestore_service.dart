import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:expenditure_management/services/google_api.dart';
import 'package:expenditure_management/utils/global.dart';
import 'package:get_storage/get_storage.dart';

class FireStoreService {
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference expenditures = FirebaseFirestore.instance
      .collection('users')
      .doc(Global.uid)
      .collection('expenditure');

  // Future<List<Map<String, Map<String, dynamic>>>> getExpenditures() async {
  //   QuerySnapshot querySnapshot =
  //       await expenditures.orderBy('updated_date', descending: true).get();
  //   print(querySnapshot);

  //   return querySnapshot.docs.map((doc) {
  //     // Global.docIdList.add(doc.id.toString());
  //     return {doc.id: doc.data() as Map<String, dynamic>};
  //   }).toList();
  // }

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
}
