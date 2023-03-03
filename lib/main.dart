import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/registro.dart';

void main() {
  //Siempre estas dos lineas al usar firebase
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     routes: {
      'home':(context) => const HomeScreen(),
      'login':(context) =>  LogInScreen(),
      'registro':(context) => const RegistroScreen()
     },
     debugShowCheckedModeBanner: false,
     initialRoute: 'home',
    );
  }
}
