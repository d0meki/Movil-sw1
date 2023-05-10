import 'package:fire_base_evento/src/providers/pay_provide.dart';
import 'package:fire_base_evento/src/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/push_notifications_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final pushProvider = PushNotificationProvider();
    pushProvider.initNotification();
    pushProvider.mensaje.listen((data) {
        print('Argumentos del push');
        print(data);
        navigatorKey.currentState?.pushNamed('mensaje',arguments: data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => PayProvider())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData.dark(),
        // darkTheme: ThemeData.dark(),
        initialRoute: Routes.initialRoute,
        routes: Routes.routes,
      ),
    );
  }
}
