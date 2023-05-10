import 'package:fire_base_evento/src/providers/pay_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GaleriaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final payProvider = context.watch<PayProvider>();
    dynamic fotos = ModalRoute.of(context)!.settings.arguments;
    // print(fotos);
    return Scaffold(
      appBar: AppBar(
        title: const Text('galeria'),
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
      backgroundColor: Color.fromARGB(255, 120, 123, 124),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Fotos 1USD  c/u",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Icon(Icons.shopping_cart_checkout, size: 40)),
                  Expanded(
                      child: Text(
                    payProvider.fotos.length.toString(),
                    style: TextStyle(fontSize: 30),
                  )),
                  // Expanded(child: GestureDetector(
                  //   child: Container(
                  //     color: Colors.amber,
                  //     child: Row(children: [
                  //       Text('Pagar',style: TextStyle(fontSize: 14),),
                  //       Icon(Icons.wallet_rounded)
                  //     ],),
                  //   ),
                  //   onTap: () {
                  //     print("Pagar");
                  //   },
                  // )),
                  Expanded(
                      child: Text(
                    'Agregue al carrito con un tap en la foto',
                    style: TextStyle(fontSize: 16),
                  )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      onPressed: null,
                      child: Hero(
                        tag: 'logo$index',
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(fotos[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            print(fotos[index]);
                            payProvider.setFotos(fotos[index]);
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: fotos.length,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 1,
        onPressed: () {
         Navigator.pushNamed(context, "pagar");
        },
        label: const Text('Pagar'),
        icon: const Icon(Icons.wallet_rounded),
        backgroundColor: Colors.blueGrey,
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
