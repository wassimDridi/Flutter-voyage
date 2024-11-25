import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InscriptionPage extends StatelessWidget {
  TextEditingController txt_login = TextEditingController();
  TextEditingController txt_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Inscription')),
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
                prefixIcon: Icon(Icons.password),
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
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                _onInscrire(context);
              },
              child: Text(
                'Inscription',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/authentification');
            },
            child: Text(
              "J'ai déjà un compte",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    if (txt_login.text.trim().isNotEmpty &&
        txt_password.text.trim().isNotEmpty) {
      try {
        // Utiliser FirebaseAuth pour créer un nouvel utilisateur
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txt_login.text.trim(),
          password: txt_password.text.trim(),
        );

        // Redirection vers la page d'accueil après succès
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        SnackBar snackBar;

        if (e.code == 'weak-password') {
          snackBar = SnackBar(
            content: Text('Mot de passe trop faible'),
          );
        } else if (e.code == 'email-already-in-use') {
          snackBar = SnackBar(
            content: Text('Cet email est déjà utilisé'),
          );
        } else if (e.code == 'invalid-email') {
          snackBar = SnackBar(
            content: Text('Format de l\'email invalide'),
          );
        } else {
          snackBar = SnackBar(
            content: Text('Erreur: ${e.message}'),
          );
        }

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        content: Text('Email ou mot de passe vides'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
