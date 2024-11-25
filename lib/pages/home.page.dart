import 'package:first_project/config/global.params.dart';
import 'package:first_project/menu/drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Récupère l'utilisateur connecté

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _deconnexion(context); // Appelle la méthode pour déconnecter
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affiche l'email de l'utilisateur connecté
            Text(
              "Utilisateur : ${user?.email ?? "Non identifié"}",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...(GlobalParams.accueil as List).map((item) {
                  return InkWell(
                    child: item['icon'],
                    onTap: () {
                      Navigator.pushNamed(context, item['route']);
                    },
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Méthode pour déconnecter l'utilisateur
  Future<void> _deconnexion(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Déconnecte l'utilisateur via Firebase
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/authentification',
        (route) => false, // Supprime toutes les routes précédentes
      );
    } catch (e) {
      // Affiche un message en cas d'erreur
      final snackBar = SnackBar(content: Text('Erreur lors de la déconnexion : $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
