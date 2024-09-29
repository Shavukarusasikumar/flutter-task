import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task/models/usermodel.dart';
import 'database_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login existing user
  static Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } catch (e) {
      print('Login failed: $e');
      return null;
    }
  }

  // Signup new user and create Firestore entry
  static Future<String?> signup(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;

      // Create a new Firestore document for the user
      UserModel newUser = UserModel(userId: userId, name: name, value: 0);
      await DatabaseService.updateUser(newUser);

      return userId;
    } catch (e) {
      print('Signup failed: $e');
      return null;
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }
}
