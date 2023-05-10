import 'package:flutter/material.dart';

class MensajePage extends StatelessWidget {
  const MensajePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mensaje page'),
      ),
      body: Center(
        child: Text(arg.toString()),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (() {
            Navigator.pushNamed(context, "evento",arguments: arg.toString());
          }),
          label: const Text('Ir'),
          icon: const Icon(Icons.rocket_launch_rounded)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
