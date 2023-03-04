import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_login/screens/home.dart';

class ProfileController extends GetxController{

  String name="";
  String email ="";
  bool validEmail=false;

handleName(String newValue){
name = newValue;
update();
}

handleEmail(String newValue){
  email = newValue;
   if (email.isEmail) {
      validEmail=true;
    } else {
      validEmail=false;
    }
  update();
}
  handleEliminate(String id,String? imageName) async {
    User user = await FirebaseAuth.instance.currentUser!;
    final db = FirebaseFirestore.instance;

    if(imageName != null){
      final storageRef = FirebaseStorage.instance.ref();
   final desertRef = storageRef.child("$imageName");await desertRef.delete();}
   
      user.delete();
      db.collection("usuarios").doc(id).delete().then(
      (doc) => Get.snackbar('Cuenta eliminada!', "",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5)),
    
      onError: (e) => Get.snackbar('Error al eliminar el usuario', "$e",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5))
    );
    Get.offAll(()=>const HomeScreen());
    
    
    
      
    
    
    
    
  }

  handleUpdateName(String id){
    final db = FirebaseFirestore.instance;
    
      final reference = db.collection("usuarios").doc(id);
      reference.update({"name": name}).then(
    (value) => Get.snackbar('Registro Actualizado!', "",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5)),
    onError: (e) => Get.snackbar('Error al actualizar registro', "$e",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5)));
    
  }
  handleUpdateEmail(String id) async {
    if(validEmail==false){
      email="";
      update();
      Get.snackbar('Correo invalido', "",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
      return;
    }
    User user = await FirebaseAuth.instance.currentUser!;
    final db = FirebaseFirestore.instance;
   
      user.updateEmail(email);
    
    final reference = db.collection("usuarios").doc(id);
    reference.update({"email": email}).then(
    (value) => Get.snackbar('Registro Actualizado!', "",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5)),
    onError: (e) => Get.snackbar('Error al actualizar registro', "$e",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5)));
    
  }
  
}