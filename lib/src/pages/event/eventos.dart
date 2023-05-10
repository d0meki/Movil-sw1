

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_evento/src/providers/pay_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Eventos extends StatelessWidget {
 Eventos({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> eventosStream =
      FirebaseFirestore.instance.collection("eventos").snapshots();
  @override
  Widget build(BuildContext context) {
    final payProvider = context.watch<PayProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Home',
            onPressed: () {
              Navigator.pushNamed(
                context,
                'profile',
              );
            },
          )
        ],
      ),
        body: Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: eventosStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> eventos =
                  document.data()! as Map<String, dynamic>;
              // List<String> uids = document.id;    
              return Card(
                child: ListTile(
                  title: Text('${eventos['nombre']}'),
                  subtitle: Text('${eventos['lugar']} ${eventos['fecha']}'),
                  trailing: const Icon(Icons.photo_size_select_large_rounded,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  onTap: () {
                    payProvider.setUidEvento(document.id);
                    Navigator.pushNamed(
                      context,
                      'galeria',
                      arguments: eventos['fotos'],
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    ));
  }
}
