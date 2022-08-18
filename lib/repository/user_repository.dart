import 'package:budget_app/models/user.dart' as CurrentUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<bool> addUser(User? user) async {
    CurrentUser.User currentUser = CurrentUser.User(user!.uid);
    final result =
        await collection.where('id', isEqualTo: currentUser.id).get();
    if (result.docs.isEmpty) {
      final addResult = await collection.add(currentUser.toJson());
      return true;
    }
    return true;
  }

  /*Future<DocumentReference> getUser(User user) {
    return collection.get();
  }*/
}
