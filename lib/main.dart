import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:receipts/screens/welcome.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Receipts App',
      theme: ThemeData(
       
        primarySwatch: Colors.yellow,
      ),
      home: const Welcome(),
    );
  }
}

