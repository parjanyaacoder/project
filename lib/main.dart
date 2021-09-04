import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference usersRef =FirebaseDatabase.instance.reference().child("users");
class MyApp extends StatelessWidget {
  static const String idScreen ="Main";
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute:LoginScreen.idScreen,
      // routes: {
      //   RegistrationScreen.idScreen:(context) => RegistrationScreen(),
      //   LoginScreen.idScreen:(context)=>LoginScreen(),
      //   mainscreen.idScreen:(context)=>RegistrationScreen(),
      // },
      home: LoginScreen(),
    );

  }
}





