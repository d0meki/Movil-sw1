import 'package:fire_base_evento/src/providers/pay_provide.dart';
import 'package:fire_base_evento/src/services/eventoservice.dart';
import 'package:fire_base_evento/widgets/card_item.dart';
import 'package:fire_base_evento/widgets/style_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Evento extends StatelessWidget {
  Evento({Key? key}) : super(key: key);

  EventoService evtService = new EventoService();

  @override
  Widget build(BuildContext context) {
    final payProvider = context.watch<PayProvider>();
    dynamic dataQR = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evento'),
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
      body: ListView(
        children: [
          FutureBuilder(
            future: evtService.getDataEvento(dataQR),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      CardItem(
                        Icons.title,
                        Color.fromARGB(255, 126, 122, 121),
                        text: StyleTextRich(
                          title: "Nombre: ",
                          subtitle: snapshot.data["nombre"],
                        ),
                      ),
                      CardItem(
                        Icons.place,
                        Color.fromARGB(255, 126, 122, 121),
                        text: StyleTextRich(
                          title: "Lugar: ",
                          subtitle: snapshot.data["lugar"],
                        ),
                      ),
                      CardItem(
                        Icons.date_range_outlined,
                        Color.fromARGB(255, 126, 122, 121),
                        text: StyleTextRich(
                          title: "Fecha: ",
                          subtitle: snapshot.data["fecha"],
                        ),
                      ),
                      ElevatedButton.icon(
                          icon: Icon(
                            Icons.folder,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            payProvider.setUidEvento(dataQR);
                            Navigator.pushNamed(context, "galeria",
                                arguments: snapshot.data["fotos"]);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white),
                          label: Text("Ver Fotos")),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
