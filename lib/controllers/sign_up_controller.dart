import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica_login/screens/home.dart';
import 'package:practica_login/screens/profile.dart';

import '../models/usuario.dart';

class SignUpController extends GetxController{
  String email="";
  String password ="";
 String name = "";
 XFile? image;
 String profileImage="";

  handleName(String newName){
    name=newName;
    update();
  }
  handleEmail(String newEmail){
    email = newEmail;
    update();
  }

  handlePassword(String newPassword){
    password = newPassword;
    update();
  }

handleSignUp() async {
    if (email == '' || password == '' || name == '') {
      return;
    }
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        final user = saveUserinDatabase(credential.user!.uid);
        Get.offAll(() => ProfileScreen(
              usuario: user,
               id:credential.user!.uid
            ));
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code,
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  saveUserinDatabase(String id){
    final user = Usuario(name:name, email:email);
    
    final db = FirebaseFirestore.instance;
    db
    .collection("usuarios")
    .doc(id)
    .set(user.toFirestore())
    .onError((e,_)=> print("Error writting document: $e"));

    return user;
  }

 uploadLocalImage()async{
  final ImagePicker _picker = ImagePicker();
  image = (await _picker.pickImage(source: ImageSource.camera))!;

  update();
 }

 uploadImage(String id)async{
if(image!=null){
  final list = image!.name.split(".");
  String ext = list.last;
final storageRef = FirebaseStorage.instance.ref();
// Create a reference to 'images/mountains.jpg'
final mountainImagesRef = storageRef.child("imagesProfile/$id.$ext");
try{
  await mountainImagesRef.putFile(File(image!.path));
  profileImage = await mountainImagesRef.getDownloadURL();
}
catch(e){

}}
 }

}