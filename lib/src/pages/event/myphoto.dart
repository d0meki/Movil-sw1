import 'package:fire_base_evento/src/pages/event/detallephoto.dart';
import 'package:fire_base_evento/src/services/eventoservice.dart';
import 'package:flutter/material.dart';
class MyPhoto extends StatelessWidget {
  MyPhoto({super.key});
  EventoService eventoService = EventoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 120, 123, 124),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Mi Galeria de fotos',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: FutureBuilder(
                  future: eventoService.getDatauserLoged(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> dataUser =
                          snapshot.data as Map<String, dynamic>;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return RawMaterialButton(
                            onPressed: () {
                              print("mostrar detalle de la foto");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    imageUrl: dataUser['fotos'][index],
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'logo$index',
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(dataUser['fotos'][index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: dataUser['fotos'].length,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageDetails {
  final String imagePath;
  final String price;
  final String photographer;
  final String title;
  final String details;
  ImageDetails({
    required this.imagePath,
    required this.price,
    required this.photographer,
    required this.title,
    required this.details,
  });
}
