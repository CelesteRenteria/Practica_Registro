import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              resizeToAvoidBottomInset: false, 

      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white,
              Colors.white,
               Color.fromARGB(255, 195, 194, 194)])),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: const Image(image: NetworkImage("https://i.pinimg.com/736x/25/0c/a0/250ca0295215879bd0d53e3a58fa1289.jpg"), width: 400)),
                  const 
                  SizedBox(height: 50,),
              const Text(
                "Descubre el trabajo\nde tus sueños aqui",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
              ),
              const 
                  SizedBox(height: 20,),
              const Text(
                  "Explora las mejores opciones laborales\nbasadas en tus intereses y estudios",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(170,60),
                        backgroundColor: const Color.fromARGB(255, 242, 242, 242),
                        
                        ),
                        onPressed: (){
                           Navigator.pushNamed(context, 'registro');
                        }, child: const Text("Registrate",style: TextStyle(color: Color.fromARGB(255, 37, 37, 37), fontSize: 15,fontFamily: 'Montserrat',))),

                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(170,60),
                         
                          
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, 'login');
                        }, child: const Text("Iniciar Sesión",style: 
                        TextStyle(color: Color.fromARGB(255, 37, 37, 37), fontSize: 15,fontFamily: 'Montserrat',)))
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }
}
