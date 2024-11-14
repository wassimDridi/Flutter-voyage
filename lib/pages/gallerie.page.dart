import 'package:first_project/pages/gallerie-details.page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gallerie extends StatelessWidget {  
  TextEditingController txt_gallerie = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Galerie')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_gallerie,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.photo_library),
                  hintText: "Galerie",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1),
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                _onGetGallerieDetails(context);
              },
              child: Text('Ouvrir Galerie', style: TextStyle(fontSize: 22)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onGetGallerieDetails(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    if (!txt_gallerie.text.isEmpty) {
      String gallerie = txt_gallerie.text;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GallerieDetailsPage(gallerie)),
      );
      txt_gallerie.text = "";
    } else {
      const snackBar = SnackBar(
        content: Text('Galerie vide'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
