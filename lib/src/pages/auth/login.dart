import 'package:fire_base_evento/src/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_base_evento/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/eventoservice.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();
  final  EventoService userService = new EventoService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(155, 4, 73, 247),
              Color.fromARGB(255, 103, 156, 231),
              Color.fromARGB(255, 191, 234, 234),
            ]),
            image: DecorationImage(
                image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2013/07/13/11/26/film-158157_960_720.png',
                ),
                alignment: Alignment.topCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(29),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Bienvenido de nuevo",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ]),
            ),
            const SizedBox(
              height: 100,
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(252, 27, 61, 255),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromARGB(
                                            255, 238, 238, 238)))),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.mail,
                                    color: Colors.blue,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Color.fromARGB(255, 238, 238, 238),
                            ))),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.blue,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "¿Has olvidado tu contraseña?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: RawMaterialButton(
                        fillColor: const Color.fromARGB(155, 4, 73, 247),
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () async {
                          User? user =
                              await _authService.loginUsingEmailPassword(
                                  //loginUsingEmailPassword
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);
                          if (user != null) {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            final List<String> items =
                                sharedPreferences.getStringList('acces_token')!;
                            items.add(user.uid);
                            await sharedPreferences.setStringList(
                                'acces_token', items);
                            //APROVECHO PARA EDITAR EL TOKENTELEFONICO
                            final updateSnapshot = await userService.usuario
                                .doc(items[1])
                                .update({'phoneToken': items[0]})
                                .then((value) => print("User Updated"))
                                .catchError((error) =>
                                    print("Failed to update user: $error"));
                            Navigator.pushNamed(context, "home");
                          } else {
                            Widgets.alertSnackbar(context, "Datos incorrectos");
                          }
                        },
                        child: const Center(
                            child: Text(
                          "Ingresar",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                            // isLoading ? Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            //       CircularProgressIndicator(color: Colors.white,),
                            //       SizedBox(width: 24,),
                            //       Text("Espere por favor...")
                            //     ],):

                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: RawMaterialButton(
                          fillColor: const Color.fromARGB(155, 4, 73, 247),
                          elevation: 0.0,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () =>
                              {Navigator.pushNamed(context, 'home')},
                          child: const Center(
                              child: Text(
                            "Registrarse",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
