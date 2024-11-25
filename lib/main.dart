import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:first_project/pages/contact.page.dart';
import 'package:first_project/pages/gallerie.page.dart';
import 'package:first_project/pages/meteo.page.dart';
import 'package:first_project/pages/parametres.page.dart';
import 'package:first_project/pages/pays.page.dart';
import 'pages/authentification.page.dart';
import 'pages/home.page.dart';
import 'pages/inscription.page.dart';
import '../config/global.params.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Charger le mode depuis Firebase
  String initialMode = await onGetMode();

  // Définir le mode initial dans GlobalParams
  GlobalParams.themeActue1.setMode(initialMode);

  runApp(MyApp());
}

Future<String> onGetMode() async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  try {
    final snapshot = await ref.child('mode').get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return "Jour"; // Valeur par défaut
    }
  } catch (e) {
    print("Erreur lors de la récupération du mode : $e");
    return "Jour"; // Valeur par défaut en cas d'erreur
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeData currentTheme;

  @override
  void initState() {
    super.initState();
    currentTheme = GlobalParams.themeActue1.getTheme();

    // Écouter les changements du thème
    GlobalParams.themeActue1.addListener(() {
      setState(() {
        currentTheme = GlobalParams.themeActue1.getTheme();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/home': (context) => HomePage(),
      '/inscription': (context) => InscriptionPage(),
      '/meteo': (context) => Meteo(),
      '/gallerie': (context) => Gallerie(),
      '/pays': (context) => Pays(),
      '/contact': (context) => ContactPage(),
      '/parametres': (context) => ParametersPage(),
      '/authentification': (context) => AuthentificationPage(),
    };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: StreamBuilder<User?>(
        // Surveille les changements d'état de connexion
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement si nécessaire
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            // Si un utilisateur est connecté, afficher la page d'accueil
            return HomePage();
          } else {
            // Sinon, afficher la page d'authentification
            return AuthentificationPage();
          }
        },
      ),
    );
  }
}
