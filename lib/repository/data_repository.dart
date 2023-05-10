import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_app/models/payment.dart';

class DataRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('payments');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPayment(Payment payment) {
    return collection.add(payment.toJson());
  }

  void updatePayment(Payment payment) async {
    await collection.doc(payment.referenceId).update(payment.toJson());
  }

  void deletePayment(Payment payment) async {
    await collection.doc(payment.referenceId).delete();
  }
}
