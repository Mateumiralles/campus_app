import 'package:campus_app/citm.dart';
import 'package:campus_app/screens/login_screen.dart';
import 'package:campus_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key,  required this.index}) : super(key: key);
  final int index;

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Desactivar el teclat al tocar
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                        labelStyle: const TextStyle(fontSize: 16),
                        labelText: "Introdueix l'usuari",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "No has introduit l'usuari";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(fontSize: 16),
                    labelText: "Introdueix la contrasenya",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "No has introduit la contrasenya";
                  }
                  return null;
                },
              ),
                ],
              ),
            ),
            
            Expanded(
              child: Center(
                child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Session session = Session();
                        session.setCredentials(
                            index: widget.index,
                            user: userController.text,
                            pass: passwordController.text);
                        if (widget.index == 0) {
                          Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return  const LoginScreen(numText: 2,text: "Inicia sessió amb les credencials d'Atenea");
                      }));
                        } else if (widget.index == 1) {}
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      primary: Colors.blue,
                      side: const BorderSide(width: 2, color: Colors.blue),
                    ),
                    child: const Text(
                      'CONTINUAR',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
