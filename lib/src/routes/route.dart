import 'package:fire_base_evento/src/mesaje_page.dart';
import 'package:fire_base_evento/src/notificaciones.dart';
import 'package:fire_base_evento/src/pages/auth/logindos.dart';
import 'package:fire_base_evento/src/pages/event/evento.dart';
import 'package:fire_base_evento/src/pages/event/eventos.dart';
import 'package:fire_base_evento/src/pages/event/galeria.dart';
import 'package:fire_base_evento/src/pages/event/myphoto.dart';
import 'package:fire_base_evento/src/pages/pay/payment.dart';
import 'package:fire_base_evento/src/pages/scan/home.dart';
import 'package:fire_base_evento/src/pages/scan/leerqr.dart';
import 'package:fire_base_evento/src/pages/scan/profile_screen.dart';
import 'package:flutter/material.dart';


import '../pages/auth/login.dart';

class Routes {
 // static final initialRoute = 'alertPermission';
  static const initialRoute = 'login_page';
  static final Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const Login(),
    'login_page': (BuildContext context) => LoginPage(),
    'profile': (BuildContext context) => ProfileScreen(),
    'leerQr': (BuildContext context) => const LeerQR(),
    'home': (BuildContext context) => const Home(),
    'galeria': (BuildContext context) => GaleriaPage(),
    'evento': (BuildContext context) => Evento(),
    'eventos': (BuildContext context) => Eventos(),
    'notificaciones': (BuildContext context) => const Notificaciones(),
    'pagar': (BuildContext context) => Payment(),
    'mensaje':(BuildContext context) => const MensajePage(),
    'mis_fotos':(BuildContext context) => MyPhoto()
  };
  static final routesName = {
    'login': 'login',
    'login_page': 'login_page',
    'profile': 'profile',
    'home': 'home',
    'evento': 'evento',
    'events': 'eventos',
    'galeria': 'galeria',
    'leerQr': 'leerQr',
    'notificaciones': 'notificaciones',
    'pagar': 'pagar',
    'mensaje': 'mensaje',
    'mis_fotos': 'mis_fotos',
  };
}