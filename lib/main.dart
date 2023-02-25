import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'registro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     routes: {
      'home':(context) => const HomeScreen(),
      'login':(context) => const LogInScreen(),
      'registro':(context) => const RegistroScreen()
     },
     debugShowCheckedModeBanner: false,
     initialRoute: 'home',
    );
  }
}
