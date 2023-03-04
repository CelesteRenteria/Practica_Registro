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
 String phoneNumber = "";
 String gender = "";
 XFile? image;
 String profileImage="";
 bool validEmail=false;
 bool validPhone =false;
 String imageName="";

  handleName(String newName){
    name=newName;
    update();
  }
  handleEmail(String newEmail){
    email = newEmail; 
    if (email.isEmail) {
      validEmail=true;
    } else {
      validEmail=false;
    }
    update();
  }
  

  handlePassword(String newPassword){
    password = newPassword;
    update();
  }

  handlePhoneNumber(String newPhoneN){
    phoneNumber = newPhoneN;
    if (phoneNumber.isPhoneNumber) {
      validPhone=true;
    } else {
      validPhone=false;
    }
    update();
  }

  handleGender(String newGender){
    gender = newGender;
    update();
  }

handleSignUp() async {
    if (email == '' || password == '' || name == '' || gender==''||phoneNumber==''||image==null) {
      Get.snackbar('Algún campo esta vacio', "",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
      return;
    }
    if(validEmail==false){
        Get.snackbar('Correo invalido', "",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
      return;}
    if(validPhone==false){
       Get.snackbar('Número de teléfono invalido', "",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
      return;
    }
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await uploadImage(credential.user!.uid);
        final user = saveUserinDatabase(credential.user!.uid);
        
        Get.offAll(() => ProfileScreen(
              usuario: user,
               id:credential.user!.uid,
               imageName: imageName,
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

 Usuario saveUserinDatabase(String id){
    final user = Usuario(name:name, email:email, imageProfile: profileImage, gender: gender, phoneNumber: phoneNumber);
    
    final db = FirebaseFirestore.instance;
    db
    .collection("usuarios")
    .doc(id)
    .set(user.toFirestore())
    .onError((e,_)=> print("Error writting document: $e"));

    return user;
  }

  uploadLocalImage() async {
    final ImagePicker picker = ImagePicker(); // Capture a photo
    image = await picker.pickImage(source: ImageSource.camera);
    update();
  }


  Future<String> uploadImage(
    String id,
  ) async {
    if (image != null) {
      final lista = image!.name.split('.');
      String ext = lista.last;
      final storageRef = FirebaseStorage.instance.ref();
      final mountainImagesRef = storageRef.child("imagesProfile/$id.$ext");
      imageName ="imagesProfile/$id.$ext";
      try {
        await mountainImagesRef.putFile(File(image!.path));
        profileImage = await mountainImagesRef.getDownloadURL();
        return profileImage;
      } catch (e) {
        // ...
      }
    }
    throw Exception('No tienes una imagen');
  }

}