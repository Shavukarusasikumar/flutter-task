import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_task/viewmodels/user_viewmodel.dart';
import 'package:flutter_task/views/increment_view.dart';
import 'package:flutter_task/views/login_view.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<UserViewModel>(
          builder: (context, userViewModel, _) {
            return userViewModel.isLoggedIn ? IncrementScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}
