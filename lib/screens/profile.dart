
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../models/usuario.dart';

class ProfileScreen extends StatelessWidget {
  final Usuario usuario;
  final String id;
  final String? imageName;
  final controller = Get.put(ProfileController());

   ProfileScreen({super.key, required this.usuario, required this.id, this.imageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              resizeToAvoidBottomInset: false, 

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 240, 103, 103),
        onPressed: () {
          controller.handleEliminate(id,imageName);
        },
        child: const Icon(Icons.delete),
      ),
      appBar: AppBar(
        backgroundColor:               const Color.fromARGB(255, 195, 194, 194)
,
        title:  Text(
          'Perfil',
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
             CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 73,
                backgroundImage: NetworkImage(
                    usuario.imageProfile),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            GetBuilder<ProfileController>(
              builder: (context) {
                return CustomListtileName(
                    title: 'Nombre',
                    subtitle: usuario.name,
                    icon: Icons.account_circle_rounded, id: id,);
              }
            ),
            GetBuilder<ProfileController>(
              builder: (context) {
                return CustomListtileEmail(
                    title: 'Email', subtitle: usuario.email, icon: Icons.email, id: id,);
              }
            )
          ],
        ),
      ),
    );
  }
}

class CustomListtileName extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
      final controller = Get.put(ProfileController());

   CustomListtileName({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Color.fromARGB(255, 240, 103, 103)),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Editar Nombre'),
                      content:  TextField(
                        onChanged: (value){
                          controller.handleName(value);
                        },
                                            ),
                      actions: [
                        
                        TextButton(
                            onPressed: () {
                               controller.handleName("");
                                                        Navigator.of(context, rootNavigator: true).pop();

                            }, child: const Text('Cancelar',style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight:FontWeight.bold),)),
                      TextButton(onPressed: () {
                          controller.handleUpdateName(id);
                           Navigator.of(context, rootNavigator: true).pop();
                        }, child: const Text('Aceptar',style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight:FontWeight.bold))),
                        ],
                    ));
          },
        ),
        title: Text(title),
        subtitle: Text(controller.name=="" ? subtitle : controller.name),
        leading: Icon(icon));
  }
}

class CustomListtileEmail extends StatelessWidget {
  final String title;
  final String id;
  final String subtitle;
  final IconData icon;
    final controller = Get.put(ProfileController());

   CustomListtileEmail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.edit,color: Color.fromARGB(255, 240, 103, 103)),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Editar Email'),
                      content:  TextField(
                        onChanged: (value){
                          controller.handleEmail(value);
                        },
                      ),
                      actions: [
                        
                        TextButton(
                            onPressed: () {
                              controller.handleEmail("");
                                                        Navigator.of(context, rootNavigator: true).pop();

                            }, child: const Text('Cancelar',style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight:FontWeight.bold))),
                      TextButton(onPressed: () {controller.handleUpdateEmail(id);
                                                    Navigator.of(context, rootNavigator: true).pop();

                        }, child: const Text('Aceptar',style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight:FontWeight.bold),)),],
                    ));
          },
        ),
        title: Text(title),
        subtitle: Text(controller.email=="" ? subtitle : controller.email),
        leading: Icon(icon));
  }
}
