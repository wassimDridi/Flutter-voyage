
import 'package:first_project/config/global.params.dart';
import 'package:first_project/menu/drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  //const HomePage({super.key});
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('page Home')),
      body: Center(
          child: Wrap(
            children:  [
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
      ),
   
    );
  }

  Future <void> Deconnexion(BuildContext context) async{

      prefs = await SharedPreferences.getInstance();
      prefs.setBool("connecte", false);
      Navigator . pushNamedAndRemoveUntil (context, '/authentification', (route) =>
      false);
    }
  }

