import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class LogInScreen extends StatefulWidget {
    LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
  
}

class _LogInScreenState extends State<LogInScreen> {
  final controller = Get.put(SignInController());
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        resizeToAvoidBottomInset: false, 

      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.white,
              Colors.white,
              Color.fromARGB(255, 195, 194, 194)
            ])),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Hola, de nuevo!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Bienvenido, te extrañamos!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      onChanged: (value) {
                        controller.handleEmail(value);
                         debugPrint(value);
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        controller.handlePassword(value);
                      
                      },
                       obscureText: true,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.visibility_off),
                          labelText: "Contraseña",
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Olvidaste tu contraseña?",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )),
                    ),
                    Row(children: [
                      Checkbox(
                        activeColor:  const Color.fromARGB(255, 240, 103, 103),
                        value: isSelected, onChanged: (newValue){
                   setState(() {
                      isSelected = newValue!;
                   });
                  }),
                   Text("Recuerdame",style: TextStyle(fontSize: 12, color: Colors.grey[700]!,fontWeight: FontWeight.bold))
                    ],),
                    const SizedBox(height: 20),
                    GetBuilder<SignInController>(
                      builder: (context) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: const Size(400, 60),
                              backgroundColor: const Color.fromARGB(255, 240, 103, 103),
                            ),
                            onPressed: () {
                              controller.handleSignIn();
                              debugPrint("Press");
                            },
                            child: const Text("Iniciar Sesión",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600)));
                      }
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text("Continuar con",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 97, 97))),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(50, 40),
                           side: const BorderSide(
                                  color: Colors.white,
                                  width: 1
                                )
                        ),
                        onPressed: (){}, 
                        child: const Padding(
                          padding: EdgeInsets.all(1),
                          child: Icon(Icons.facebook, color: Colors.blue, size: 35,),
                        )),
                         OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(50, 40),
                           side: const BorderSide(
                                  color: Colors.white,
                                  width: 1
                                )
                        ),
                        onPressed: (){}, 
                        child:  Padding(
                          padding: const EdgeInsets.all(1),
                          child: Icon(Icons.apple, color: Colors.grey[800]!, size: 35,),
                        )),
                         OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(50, 40),
                           side: const BorderSide(
                                  color: Colors.white,
                                  width: 1
                                )
                        ),
                        onPressed: (){}, 
                        child:  Padding(
                          padding: const EdgeInsets.all(1),
                          child: Icon(Icons.snapchat, color: Colors.yellow[800]!, size: 35,),
                        ))
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text("No eres miembro aún?"),
                      TextButton(onPressed: (){
                         Navigator.pushNamed(context, 'registro');
                      }, child: const Text("Registrate ahora"))  
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
