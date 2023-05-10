import 'package:fire_base_evento/src/providers/push_notifications_provider.dart';
import 'package:flutter/material.dart';

class Notificaciones extends StatefulWidget {
  const Notificaciones({Key? key}) : super(key: key);

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

//

class _NotificacionesState extends State<Notificaciones> {
  @override
  void initState() {
    super.initState();
    final pushProvider = PushNotificationProvider();
    pushProvider.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push Local',
      home: Scaffold(
        body: Center(
          child: Container(
            child: Text('Hola mundo'),
          ),
        ),
      ),
    );
  }
}
