import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  // final CollectionReference expenditure =
  //     FirebaseFirestore.instance.collection('expenditure');

  // Future<void> createUserDocument(User user) async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   await firestore.collection('users').doc(user.uid).set({
  //     'email': user.email,
  //     'name': user.displayName,
  //     'photo': user.photoURL,
  //   });
  // }
  CollectionReference expenditures = FirebaseFirestore.instance
      .collection('users')
      .doc('mg1xi0ibayKsc8KnhR4u')
      .collection('expenditure');

  Future<void> createExpenditure() async {
    await expenditures.doc("abc").set({
      "note": "test",
      "amount": 3000,
      "payment": {"name": "Cash", "id": 1, "name_vn": "la ue"},
      "category": {"id": 1, "name": "Eat and Drink", "name_vn": "datoung"},
      "type": {"id": 1, "name": "Expense", "name_vn": "Chi phí"},
      "created_date": "Timestamp(seconds=1722599955, nanoseconds=280000000)",
      "updated_date": "Timestamp(seconds=1722599973, nanoseconds=927000000)"
    });
  }

  Future<List<Map<String, dynamic>>> getExpenditures() async {
    QuerySnapshot querySnapshot = await expenditures.get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
  // Future<void> getExpenditure() async {
  //   final DocumentSnapshot document =
  //       await expenditure.doc('ODcpguUHUitkP2sXBrre').get();
  //   print(document.data());
  // }

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
