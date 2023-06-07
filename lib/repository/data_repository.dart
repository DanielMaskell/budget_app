// import 'package:budget_app/models/payment_hive.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:budget_app/models/payment.dart';

// class DataRepository {
//   final CollectionReference collection = FirebaseFirestore.instance.collection('payments');

//   Stream<QuerySnapshot> getStream() {
//     return collection.snapshots();
//   }

//   Future<DocumentReference> addPayment(PaymentHive payment) {
//     return collection.add(payment.toJson());
//   }

//   void updatePayment(PaymentHive payment) async {
//     await collection.doc(payment.referenceId).update(payment.toJson());
//   }

//   void deletePayment(PaymentHive payment) async {
//     await collection.doc(payment.referenceId).delete();
//   }
// }
