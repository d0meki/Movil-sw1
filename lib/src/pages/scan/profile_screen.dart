import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_evento/src/pages/scan/leerqr.dart';
import 'package:fire_base_evento/src/services/eventoservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:topicos_proy/src/Controllers/usuario_controller.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
        leading: IconButton(
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
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ),
      // backgroundColor: Colors.purple[800],
      body: Container(
        decoration: BoxDecoration(
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
            child: FutureBuilder(
          future: getDataProfile(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(snapshot.data['avatar']),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data['nombre'],
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueGrey[200],
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Source Sans Pro"),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 200,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InfoCard(text: snapshot.data['telefono'], icon: Icons.phone),
                  InfoCard(text: snapshot.data['email'], icon: Icons.email),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 1,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LeerQR(),
              ));
            },
            label: const Text('Invitacion Leer Qr'),
            icon: const Icon(Icons.qr_code),
            backgroundColor: Colors.black,
          ),
          const SizedBox(
            height: 5,
          ),
          FloatingActionButton.extended(
            heroTag: 2,
            onPressed: () {
              Navigator.pushNamed(context, "eventos");
            },
            label: const Text('Lista de Eventos'),
            icon: const Icon(Icons.remove_red_eye),
            backgroundColor: Colors.black,
          ),
          const SizedBox(
            height: 5,
          ),
          FloatingActionButton.extended(
            heroTag: 3,
            onPressed: () {
              Navigator.pushNamed(context, "mis_fotos");
            },
            label: const Text('Mis Fotos'),
            icon: const Icon(Icons.photo_camera_back_outlined),
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  const InfoCard({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: const TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}
