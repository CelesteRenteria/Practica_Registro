import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:practica_login/screens/home.dart';

class ProfileController extends GetxController{

  String name="";
  String email ="";

handleName(String newValue){
name = newValue;
update();
}

handleEmail(String newValue){
  email = newValue;
  update();
}
  handleEliminate(String id) async {
    User user = await FirebaseAuth.instance.currentUser!;
    user.delete();
    final db = FirebaseFirestore.instance;
    db.collection("usuarios").doc(id).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
    
    Get.offAll(()=>const HomeScreen());
  }

  handleUpdateName(String id){
    final db = FirebaseFirestore.instance;
    final reference = db.collection("usuarios").doc(id);
    reference.update({"name": name}).then(
    (value) => print("DocumentSnapshot successfully updated!"),
    onError: (e) => print("Error updating document $e"));
  }
  handleUpdateEmail(String id) async {
    User user = await FirebaseAuth.instance.currentUser!;
    user.updateEmail(email);
    final db = FirebaseFirestore.instance;
    final reference = db.collection("usuarios").doc(id);
    reference.update({"email": email}).then(
    (value) => print("DocumentSnapshot successfully updated!"),
    onError: (e) => print("Error updating document $e"));
  }
  
}