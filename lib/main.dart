import 'package:first_project/pages/contact.page.dart';
import 'package:first_project/pages/gallerie.page.dart';
import 'package:first_project/pages/meteo.page.dart';
import 'package:first_project/pages/parametres.page.dart';
import 'package:first_project/pages/pays.page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/authentification.page.dart';

import 'pages/home.page.dart';
import 'pages/inscription.page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final routes = {
  '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/meteo': (context) => Meteo(),
    '/gallerie': (context) => Gallerie(),
    '/pays': (context) => Pays(),
    '/contact': (context) => Contact(),
    '/parametres': (context) => Parametres(),
    '/authentification': (context) => AuthentificationPage(),

  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    home: FutureBuilder(
    future: SharedPreferences. getInstance(),
    builder: (context, snapshot)
    {
    if (snapshot. hasData) {
    bool conn = snapshot.data ?. getBool ('connecte') ?? false;
    if (conn)
    return HomePage () ;
    }

    return AuthentificationPage();
    })
    );
  }
}

