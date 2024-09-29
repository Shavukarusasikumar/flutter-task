import 'package:flutter/material.dart';
import 'package:flutter_task/models/usermodel.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _currentUser;
  bool get isLoggedIn => _currentUser != null;

  int get userValue => _currentUser?.value ?? 0;

  // login function
  Future<bool> login(String email, String password) async {
    try {
      final userId = await AuthService.login(email, password);
      if (userId != null) {
        _currentUser = await DatabaseService.getUser(userId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // signup function
  Future<bool> signup(String name, String email, String password) async {
    try {
      final userId = await AuthService.signup(email, password, name);
      if (userId != null) {
        _currentUser = await DatabaseService.getUser(userId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  //incrementing function
  Future<void> incrementValue() async {
    if (_currentUser != null) {
      _currentUser!.value += 1;
      await DatabaseService.updateUser(_currentUser!);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await AuthService.logout();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print('Logout error: $e');
    }
  }
}