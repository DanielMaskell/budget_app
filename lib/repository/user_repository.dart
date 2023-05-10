import 'package:budget_app/models/user.dart' as current_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final CollectionReference collection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<bool> addUser(User? user) async {
    current_user.User currentUser = current_user.User(user!.uid);
    final result = await collection.where('id', isEqualTo: currentUser.id).get();
    if (result.docs.isEmpty) {
      return true;
    }
    return true;
  }
}
