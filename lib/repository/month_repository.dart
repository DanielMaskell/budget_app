import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_app/models/month.dart';

class MonthReposity {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('months');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addMonth(Month month) {
    return collection.add(month.toJson());
  }

  void updateMonth(Month month) async {
    await collection.doc(month.referenceId).update(month.toJson());
  }

  void deleteMonth(Month month) async {
    await collection.doc(month.referenceId).delete();
  }
}
