import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String name;
  final String email;

  Usuario({
    required this.name,
    required this.email,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Usuario(
      name: data?['name'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      // ignore: unnecessary_null_comparison
      if (name != null) "name": name,
      // ignore: unnecessary_null_comparison
      if (email != null) "email": email,
    };
  }
}
