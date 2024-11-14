import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaysDetails extends StatefulWidget {
  final String pays;

  PaysDetails({required this.pays});

  @override
  _PaysDetailsState createState() => _PaysDetailsState();
}

class _PaysDetailsState extends State<PaysDetails> {
  Map<String, dynamic>? paysData; // Stocker les détails du pays dans une map

  @override
  void initState() {
    super.initState();
    getPaysData(widget.pays);
  }

  Future<void> getPaysData(String pays) async {
    final url = Uri.parse('https://restcountries.com/v2/name/$pays');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          paysData = data[0]; // Récupérer le premier résultat
        });
        print("Réponse JSON reçue : $data");
      } else {
        print("Erreur lors de la requête : ${response.statusCode}");
      }
    } catch (e) {
      print("Exception lors de la requête : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails du Pays')),
      body: paysData != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  // Drapeau
                  Image.network(
                    paysData!['flags']['png'],
                    height: 100,
                    width: 150,
                  ),
                  SizedBox(height: 20),
                  // Capitale
                  Text(
                    'Capitale : ${paysData!['capital']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // Superficie
                  Text(
                    'Superficie : ${paysData!['area']?.toString() ?? 'N/A'} km²',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // Population
                  Text(
                    'Population : ${paysData!['population']?.toString() ?? 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // Pays limitrophes
                  Text(
                    'Pays limitrophes : ${paysData!['borders'] != null ? paysData!['borders'].join(', ') : 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // Devise
                  Text(
                    'Devise : ${paysData!['currencies'] != null ? paysData!['currencies'][0]['nativeName'] + ' (${paysData!['currencies'][0]['symbol']})' : 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // Continent
                  Text(
                    'Continent : ${paysData!['region']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  // Organisations sous-régionales
                  Text(
                    'Organisations : ${paysData!['regionalBlocs'] != null ? paysData!['regionalBlocs'].map((bloc) => bloc['name']).join(', ') : 'N/A'}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
