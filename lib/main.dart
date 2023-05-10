import 'package:fire_base_evento/firebase_options.dart';
import 'package:fire_base_evento/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp( const MyApp());
}

