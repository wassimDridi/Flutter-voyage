import 'package:flutter/material.dart';
import '../notifier/them.dart';

class GlobalParams{
  static MonTheme themeActue1 = MonTheme();
  static List<Map<String, dynamic>> menus = [
    {
      "title": "Accueil",
      "icon": const Icon(Icons.home, color: Colors.brown),
      "route": "/home"
    },
    {
      "title": "Meteo",
      "icon": Icon(Icons.sunny, color: Colors.brown),
      "route": "/meteo"
    },
    {
      "title": "Gallerie",
      "icon": Icon(Icons.photo, color: Colors.brown),
      "route": "/gallerie"
    },
    {
      "title": "Pays",
      "icon": Icon(Icons.location_city, color: Colors.brown),
      "route": "/pays"
    },
    {
      "title": "Contact",
      "icon": Icon(Icons.contact_page, color: Colors.brown),
      "route": "/contact"
    },
    {
      "title": "Parametres",
      "icon": Icon(Icons.settings, color: Colors.brown),
      "route": "/parametres"
    },
    {
      "title": "Déconnexion",
      "icon": Icon(Icons.logout, color: Colors.brown),
      "route": "/authentification"
    },
  ];

    static List<Map<String, dynamic>>accueil=[

    { "icon":InkWell(
      child: Ink.image(
        height: 180,
        width: 180,
        image: AssetImage('assets/images/meteo.png',),),),"route":"/meteo"},
    {"icon":InkWell(
      child: Ink.image(
        height: 180,
        width: 180,
        image: AssetImage('assets/images/gallerie.jpg',),),),
      "route":"/gallerie"},
    {"icon":InkWell(
      child: Ink.image(
        height: 180,
        width: 180,
        image: AssetImage('assets/images/pays.png',),),),
      "route": "/pays"},
    {"title": "Contact", "icon":InkWell(
      child: Ink.image(
        height: 180,
        width: 180,
        image: AssetImage('assets/images/contact.png',),),),
      "route": "/contact"},
    {"title":"Paramètres", "icon":InkWell(
      child: Ink.image(
        height: 180,
        width: 180,
        image: AssetImage('assets/images/parametres.jpg',),),),
      "route":"/parametres"},
    {"title": "Deconnexion", "icon":InkWell(
      child: Ink.image(
        height: 180,
        width: 180,
        image: AssetImage('assets/images/deconnexion.jpg',),),),
      "route": "/authentification"},

  ];

}