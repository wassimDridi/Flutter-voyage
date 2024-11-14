import 'package:first_project/pages/meteo-details.page.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Meteo extends StatelessWidget {  
  
  TextEditingController txt_ville =new TextEditingController();
  @override
  Widget build(BuildContext context) {
 return Scaffold(
        appBar: AppBar(title: Text('Page Authentification')),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_ville,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: "Ville",
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
                  _onGetMeteoDetails(context);
                },
                child: Text('Chercher', style: TextStyle(fontSize: 22),),
              ),
            ),
            
          ],
        )
    );
  
  }

  Future <void> _onGetMeteoDetails(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    if (!txt_ville. text. isEmpty ) {
      String v = txt_ville. text ;
      Navigator.push(context,
       MaterialPageRoute(builder: (context)=> MeteoDetailsPage(v)));
      txt_ville. text = "" ;

  }else{
      const snackBar = SnackBar(
        content: Text ('Ville vides'),
      );
      ScaffoldMessenger. of(context).showSnackBar (snackBar);
    }
}
}
