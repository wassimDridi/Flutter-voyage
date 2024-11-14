import 'package:first_project/pages/pays-details.page.dart';
import 'package:flutter/material.dart';


class Pays extends StatelessWidget {
  TextEditingController txt_pays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Pays')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: txt_pays,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.flag),
                hintText: "Nom du pays",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                _onGetPaysDetails(context);
              },
              child: Text('Chercher', style: TextStyle(fontSize: 22)),
            ),
          ],
        ),
      ),
    );
  }

  void _onGetPaysDetails(BuildContext context) {
    if (txt_pays.text.isNotEmpty) {
      String pays = txt_pays.text;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaysDetails(pays: pays)),
      );
      txt_pays.clear();
    } else {
      final snackBar = SnackBar(content: Text('Veuillez entrer un nom de pays.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
