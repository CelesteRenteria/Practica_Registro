import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_login/screens/home.dart';
import 'package:practica_login/screens/profile.dart';

import '../models/usuario.dart';

class SignInController extends GetxController{
  String email="";
  String password ="";
 

  handleEmail(String newEmail){
    email = newEmail;
    update();
  }

  handlePassword(String newPassword){
    password = newPassword;
    update();
  }

  handleSignIn() async {
    if (email == '' || password == '') {
      return;
    }
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.toLowerCase(), password: password);
      if (credential.user != null) {
        Usuario? usuario = await getUser(credential.user!.uid);
        if (usuario != null) {
          Get.offAll(() => ProfileScreen(usuario: usuario, id:credential.user!.uid));
        }
      }
      // Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.dialog(AlertDialog(
        backgroundColor: Colors.red,
        title: const Text(
          'Error',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(e.code, style: const TextStyle(color: Colors.white)),
      ));
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

   Future<Usuario?> getUser(String id) async {
    Usuario usuario;
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("usuarios").doc(id);
    usuario = await docRef.get().then(
      (DocumentSnapshot<Map<String, dynamic>> doc) {
        return Usuario.fromFirestore(doc);
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return usuario;
  }
}