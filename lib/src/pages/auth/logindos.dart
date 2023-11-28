import 'package:fire_base_evento/src/services/authservice.dart';
import 'package:fire_base_evento/src/services/eventoservice.dart';
import 'package:fire_base_evento/widgets/my_button.dart';
import 'package:fire_base_evento/widgets/my_textfield.dart';
import 'package:fire_base_evento/widgets/square_tile.dart';
import 'package:fire_base_evento/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
//services
  final AuthService _authService = AuthService();
  final EventoService userService = new EventoService();
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink,
              Colors.purple,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                /* const Icon(
                  Icons.photo_camera,
                  size: 100,
                  color: Colors.black,
                ), */
                // SquareTile(imagePath: 'images/photo.png'),
                Image.asset(
                  'images/photo.png',
                  width: 120.0,
                ),
                const SizedBox(height: 50),

                // welcome back, you've been missed!
                /* Text(
                  'Castle Event Lens!',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                  ),
                ), */
                Text(
                  'Castle Event Lens!',
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nisebuschgardens',
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: () async {
                    print("login");
                     User? user = await _authService.loginUsingEmailPassword(
                        //loginUsingEmailPassword
                        email: usernameController.text,
                        password: passwordController.text,
                        context: context);
                    if (user != null) {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      final List<String> items =
                          sharedPreferences.getStringList('acces_token')!;
                      items.add(user.uid);
                      await sharedPreferences.setStringList('acces_token', items);
                      //APROVECHO PARA EDITAR EL TOKENTELEFONICO
                      final updateSnapshot = await userService.usuario
                          .doc(items[1])
                          .update({'phoneToken': items[0]})
                          .then((value) => print("User Updated"))
                          .catchError(
                              (error) => print("Failed to update user: $error"));
                      Navigator.pushNamed(context, "profile");
                    } else {
                      Widgets.alertSnackbar(context, "Datos incorrectos");
                    }
                  },
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'O continua con',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'images/apple.png')
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No eres Miembro?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Registrate Ahora',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
