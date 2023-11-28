import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_evento/src/pages/scan/leerqr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/eventoservice.dart';
import '../../services/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EventoService userService = new EventoService();

  Future<dynamic> getDataProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<String> items = sharedPreferences.getStringList('acces_token')!;
    String uid = items[1];
    DocumentSnapshot documentSnapshot =
        await userService.usuario.doc(uid).get();
    return documentSnapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
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
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'login_page', (Route<dynamic> route) => false);
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          final List<String> items =
                              sharedPreferences.getStringList('acces_token')!;
                          items.removeAt(1);
                          sharedPreferences.setStringList('acces_token', items);
                        },
                        icon: const Icon(
                          AntDesign.logout,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'My\nProfile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,
                    child: FutureBuilder(
                      future: getDataProfile(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<dynamic> snapshot,
                      ) {
                        double innerHeight = 393.9742;
                        double innerWidth = 379.4285;
                        if (snapshot.hasData) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: innerHeight * 0.52,
                                  width: innerWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 80,
                                      ),
                                      Text(
                                        snapshot.data["nombre"],
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(39, 105, 171, 1),
                                          fontFamily: 'Nunito',
                                          fontSize: 37,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Correo',
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontFamily: 'Nunito',
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data['email'],
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      39, 105, 171, 1),
                                                  fontFamily: 'Nunito',
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 110,
                                right: 20,
                                child: Icon(
                                  AntDesign.setting,
                                  color: Colors.grey[700],
                                  size: 30,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    child: Image.network(
                                      snapshot.data['avatar'],
                                      width: innerWidth * 0.45,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'My Orders',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          const Divider(
                            thickness: 2.5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            width: width * 0.75,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, "eventos");
                                },
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue),
                                label: const Text("Eventos")),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            width: width * 0.75,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.qr_code_scanner_rounded,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LeerQR(),
                                  ));
                                },
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue),
                                label: const Text("Leer QR")),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
