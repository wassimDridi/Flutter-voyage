import 'package:first_project/config/global.params.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.blue]),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profil.jpg'),
              ),
            ),
          ),
          ...(GlobalParams.menus as List).map((item) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    '${item["title"]}',
                    style: TextStyle(fontSize: 22),
                  ),
                  leading: item['icon'],
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.blue,
                  ),
                  onTap: () async {
                    if ('${item['title']}' != "Deconnexion") {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "${item['route']}");
                    } else {
                      await _deconnexion(context); // Appelle la méthode de déconnexion Firebase
                    }
                  },
                ),
              ],
            );
          }),
          Divider(
            height: 4,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  /// Méthode pour déconnecter l'utilisateur via Firebase
  Future<void> _deconnexion(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Déconnecte l'utilisateur
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/authentification",
        (Route) => false,
      ); // Redirige vers la page d'authentification
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Erreur lors de la déconnexion : $e'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
