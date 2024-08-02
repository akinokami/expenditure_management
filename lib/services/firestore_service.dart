import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference expenditure =
      FirebaseFirestore.instance.collection('expenditure');

  // Future<void> createUserDocument(User user) async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   await firestore.collection('users').doc(user.uid).set({
  //     'email': user.email,
  //     'name': user.displayName,
  //     'photo': user.photoURL,
  //   });
  // }

  Future<void> createExpenditureDocument(User user, String title, String amount,
      String category, String date) async {
    await expenditure.doc(user.uid).set({
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
    });
  }

  Future<void> getExpenditureDocument(User user) async {
    final DocumentSnapshot document = await expenditure.doc(user.uid).get();
    print(document.data());
  }
}
