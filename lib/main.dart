import 'package:flutter/material.dart';
import 'package:flutter_app_one/login_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'V-Shape',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginScreen(),
    );
  }
}

