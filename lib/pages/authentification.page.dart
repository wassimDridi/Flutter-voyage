import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthentificationPage extends StatelessWidget {
  final TextEditingController txt_login = TextEditingController();
  final TextEditingController txt_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Authentification')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Utilisateur",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_password,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Mot de passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                _onAuthentifier(context);
              },
              child: Text('Connexion', style: TextStyle(fontSize: 22)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/inscription');
            },
            child: Text(
              "Nouvel utilisateur",
              style: TextStyle(fontSize: 22),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onAuthentifier(BuildContext context) async {
    try {
      // Authentification avec Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: txt_login.text.trim(),
        password: txt_password.text.trim(),
      );

      // Redirection vers la page d'accueil après une connexion réussie
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Gérer les erreurs de Firebase
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = "Utilisateur non trouvé.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Mot de passe incorrect.";
      } else {
        errorMessage = "Une erreur est survenue. Veuillez réessayer.";
      }

      final snackBar = SnackBar(content: Text(errorMessage));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
