import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_task/models/usermodel.dart';


class DatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<UserModel?> getUser(String userId) async {
    DocumentSnapshot doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  static Future<void> updateUser(UserModel user) async {
    await _db.collection('users').doc(user.userId).set(user.toJson());
  }
}
