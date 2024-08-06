import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:expenditure_management/utils/global.dart';

class FireStoreService {
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference expenditures = FirebaseFirestore.instance
      .collection('users')
      .doc('mg1xi0ibayKsc8sdfdf')
      .collection('expenditure');

  Future<List<Map<String, dynamic>>> getExpenditures() async {
    QuerySnapshot querySnapshot = await expenditures.get();
    print(querySnapshot);

    return querySnapshot.docs.map((doc) {
      Global.docIdList.add(doc.id.toString());
      return doc.data() as Map<String, dynamic>;
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
