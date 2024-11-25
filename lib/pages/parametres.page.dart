import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../config/global.params.dart';

class ParametersPage extends StatefulWidget {
  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  String mode = "Jour"; // Valeur par défaut
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref(); // Référence à la base Firebase

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mode',
             // style: Theme.of(context).textTheme.headline3,
            ),
            Column(
              children: [
                ListTile(
                  title: Text('Jour'),
                  leading: Radio<String>(
                    value: "Jour",
                    groupValue: mode,
                    onChanged: (value) {
                      setState(() {
                        mode = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Nuit'),
                  leading: Radio<String>(
                    value: "Nuit",
                    groupValue: mode,
                    onChanged: (value) {
                      setState(() {
                        mode = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await saveModeToFirebase();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                child: Text(
                  'Enregistrer',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveModeToFirebase() async {
    try {
      GlobalParams.themeActue1.setMode(mode);
      await databaseReference.child('mode').set(mode);
      print('Mode changé : $mode');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mode enregistré avec succès !')),
      );
    } catch (e) {
      print('Erreur lors de l\'enregistrement : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'enregistrement !')),
      );
    }
  }
}

