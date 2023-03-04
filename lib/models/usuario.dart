import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String name;
  final String email;
  final String imageProfile;
  final String phoneNumber;
  final String gender;

  Usuario({
    required this.imageProfile,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Usuario(
      
      name: data?['name'],
      email: data?['email'],
      imageProfile: data?['imageProfile'],
      phoneNumber: data?['phoneNumber'],
      gender: data?['gender'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      // ignore: unnecessary_null_comparison
      if (name != null) "name": name,
      // ignore: unnecessary_null_comparison
      if (email != null) "email": email,
      // ignore: unnecessary_null_comparison
      if (imageProfile != null) "imageProfile": imageProfile,
      // ignore: unnecessary_null_comparison
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      // ignore: unnecessary_null_comparison
      if (gender != null) "gender": gender,
    };
  }
}
