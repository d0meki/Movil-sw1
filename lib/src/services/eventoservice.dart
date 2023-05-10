import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventoService {
  EventoService();
  final CollectionReference _eventos =
      FirebaseFirestore.instance.collection('eventos');
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('usuarios');
  CollectionReference get evento => _eventos;
  CollectionReference get usuario => _user;

  Future<dynamic> getDataEvento(uid) async {
    DocumentSnapshot documentSnapshot = await _eventos.doc(uid).get();
    //print(documentSnapshot.data());
    return documentSnapshot.data();
  }

  Future<dynamic> getDatauser(uid) async {
    DocumentSnapshot documentSnapshot = await _user.doc(uid).get();
    return documentSnapshot.data();
  }

  Future<dynamic> getDatauserLoged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<String> items = sharedPreferences.getStringList('acces_token')!;
    String uid = items[1];
    DocumentSnapshot documentSnapshot = await _user.doc(uid).get();
    return documentSnapshot.data();
  }

  Future<dynamic> setVenta(List<String> fotos, String uidEvento) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<String> items = sharedPreferences.getStringList('acces_token')!;

    String uid = items[1];
    DocumentSnapshot usuarioSnapshop = await _user.doc(uid).get();
    Map<String, dynamic> usuario =
        usuarioSnapshop.data() as Map<String, dynamic>;

    List<Map<String, dynamic>> ventas = [
      {
        "precio": fotos.length,
        "cliente": usuario['nombre'],
        "cantidad": fotos.length,
        "fecha": DateTime.now().toString()
      }
    ];

    DocumentSnapshot eventoSnapshot = await _eventos.doc(uidEvento).get();
    if (eventoSnapshot.exists) {
      Map<String, dynamic> evento =
          eventoSnapshot.data()! as Map<String, dynamic>;
      DocumentSnapshot photographoSnapshot =
          await _user.doc(evento['fotografo']).get();

      Map<String, dynamic> photographo =
          photographoSnapshot.data()! as Map<String, dynamic>;

      for (var element in photographo['ventas']) {
        ventas.add(element);
      }
      Map<String, dynamic> data = {"ventas": ventas};
      await photographoSnapshot.reference.update(data).then(
        (value) {
          print("editado con exito");
        },
      );
      for (var fotoUrl in usuario['fotos']) {
        fotos.add(fotoUrl);
      }
      Map<String, dynamic> datito = {"fotos": fotos};
      await usuarioSnapshop.reference.update(datito).then((value) {
        print("editado con exito 2");
      });
    }
  }

//     Future<void> updateUser(uid) {
//     return _user
//     .doc(uid)
//     .update({'company': 'Stokes and Sons'})
//     .then((value) => print("User Updated"))
//     .catchError((error) => print("Failed to update user: $error"));
// }
}
