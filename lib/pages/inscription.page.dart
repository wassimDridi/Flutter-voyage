
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatelessWidget {
  late SharedPreferences prefs;


  TextEditingController txt_login =new TextEditingController();
  TextEditingController txt_password =new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('page inscription')),
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
                  borderSide: BorderSide(width: 1)
                )
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
                  hintText: "mot de passe",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1)
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                _onInscrire(context);
              },
              child: Text('Inscription', style: TextStyle(fontSize: 22),),
            ),
          ),
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/authentification');

          }, child: Text("jai deja un compte",
          style: TextStyle(fontSize: 22),))


        ],
      )
    );
  }

 Future <void> _onInscrire(BuildContext context) async {
      // prefs 3lach aamalna instance 
     prefs = await SharedPreferences.getInstance();
     if (!txt_login. text. isEmpty && !txt_password. text. isEmpty) {
       prefs.setString("login", txt_login. text) ;
       prefs.setString("password", txt_password. text) ;
       prefs.setBool("connecte", true);
       Navigator. pop (context);
       Navigator. pushNamed (context, '/home');



 }else {
       const snackBar = SnackBar(
         content: Text ('Id ou mot de passe vides'),
       );
       ScaffoldMessenger. of(context).showSnackBar (snackBar);
     }
}}
