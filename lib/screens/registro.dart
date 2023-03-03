
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
  
}
enum RadioOptions{
  uno,dos,tres
}
class _RegistroScreenState extends State<RegistroScreen> {
  List<String> itemsDropDown = ["Mujer", "Hombre", "Prefiero no decirlo","Otro"];
  String valueDropDown = "Mujer";
  TextStyle styleSubTitle = const TextStyle(color: Colors.grey,fontSize: 16,fontWeight:FontWeight.bold);
  TextStyle styleTitle = const TextStyle(fontSize: 40,fontFamily: 'Montserrat', fontWeight: FontWeight.bold);
   TextStyle styleHint = const TextStyle(color: Colors.grey,fontSize: 12,fontWeight:FontWeight.bold);
  String userName = "";
  String email = "";
  String password = "";
  String phone = "";
  DateTime? birthDate;
  String fecha = "";
  String gender = "";
  int choice = 0;
  final controller = Get.put(SignUpController());
  RadioOptions valueRadio = RadioOptions.uno;

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
          child: ListView(children: [
            Column(
              
              children: [
                 Text(
                  "Registro",
                  textAlign: TextAlign.center,
                  style: styleTitle,
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Ya eres miembro?"),
                TextButton(onPressed: (){
                   Navigator.pushNamed(context, 'login');
                }, child: const Text("Iniciar Sesión"))  
                ],
              ),
              // GetBuilder<SignUpController>(
              //   builder: (context) {
              //     return GestureDetector(
              //           onTap:(){
              //             controller.uploadLocalImage();
              //           },
              //           child: controller.image == null?
              //           const Image(image:NetworkImage("https://cdn-icons-png.flaticon.com/512/149/149071.png"))
              //           : Image(image: NetworkImage(controller.profileImage),)
              //         );
              //   }
              // ),
                CustonTextFormField(
                  
                  labelTxt: 'Nombre de usuario', preIcon: const Icon(Icons.person_outlined), onChanged: (value) {
                  //El set state actualiza el estado
                 controller.handleName(value);
                } ,),
                const SizedBox(height: 10),
                CustonTextFormField(labelTxt: 'Correo eléctronico', preIcon: const Icon(Icons.email), onChanged: (value) {
                  //El set state actualiza el estado
                 controller.handleEmail(value);
                } ,),
                const SizedBox(height: 10),
                CustomTextFormFieldPassword(onChanged:(value) {
                  //El set state actualiza el estado
                 controller.handlePassword(value);
                } ),
                const SizedBox(height: 10),
                CustonTextFormField(
                  format:  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  labelTxt: 'Télefono', preIcon: const Icon(Icons.phone), onChanged: (value) {
                  //El set state actualiza el estado
                 setState(() {
                    phone = value; 
                 });
                } ,),
                const SizedBox(height: 10),
               Row(
                 children: [
                   Align(
                    alignment: Alignment.centerLeft,
                     child: TextButton.icon(
                      label: Text("Fecha de nacimiento",style: styleHint,) ,
                      icon:  Icon(Icons.calendar_month_outlined, color: Colors.grey[700],),
                          //Como mostrar el valor de la fecha
                          onPressed: () async{
                            birthDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 36500)), lastDate: DateTime.now()
                            );
                            setState(() {
                              fecha = "${birthDate!.day}/${birthDate!.month}/${birthDate!.year}";
                            });
                          },),
                   ),
                   (birthDate==null) ?  Text("    ---",style: styleHint) :
                   Text("    $fecha",style: styleHint)
                 ],
               ), 
              const SizedBox(height: 10),
              Align(
                 alignment: Alignment.centerLeft,
                 child:   Text("Genero",
                 style: styleSubTitle),),
             const SizedBox(height: 10),             
DropdownButton(
  elevation: 5,
  isExpanded: true,
  dropdownColor: Colors.white,
  style: TextStyle(
                          color: Colors.grey[800]!,
                          fontSize: 14,
                          fontWeight: FontWeight.bold), 
                //valor por defecto que se muestre
                value: valueDropDown,
                //Recorre la lista, y en base en cada valor regresa algo
                items: itemsDropDown.map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item))).toList(), 
                onChanged: (value){
                  setState(() {
                    valueDropDown = value!;
                  });
                }),
                 const SizedBox(height: 10),   
              
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size(400, 60),
                      backgroundColor: const Color.fromARGB(255, 240, 103, 103),
                    ),
                    onPressed: () {
                      controller.handleSignUp();
              
                    },
                    child: const Text("Registrate",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600))),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomTextFormFieldPassword extends StatefulWidget {
  final Function(String)? onChanged;
  const CustomTextFormFieldPassword({
    
    super.key, this.onChanged,
  });

  @override
  State<CustomTextFormFieldPassword> createState() => _CustomTextFormFieldPasswordState();
}

class _CustomTextFormFieldPasswordState extends State<CustomTextFormFieldPassword> {
  @override
  Widget build(BuildContext context) {
    bool show = true;
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: show,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
          suffixIcon: 
          (show==true) ?
          IconButton(icon: const Icon(Icons.visibility_off), onPressed: (){
            setState(() {
              show = false;
            });
          },) : IconButton(icon: const Icon(Icons.visibility), onPressed: (){
            setState(() {
              show = true;
            });
          },)
          ,
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
    );
  }
}

class CustonTextFormField extends StatelessWidget {
  final String labelTxt;
 final Function(String)? onChanged;
 final Icon preIcon;
 final TextInputFormatter? format;
  const CustonTextFormField({
    super.key, required this.labelTxt, this.onChanged, required this.preIcon, this.format,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [format ?? FilteringTextInputFormatter.singleLineFormatter],
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: preIcon,
          labelText: labelTxt,
          labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: const BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(15))),
    );
  }
}
