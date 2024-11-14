import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GallerieDetailsPage extends StatefulWidget {
  String gallerie = "";
  GallerieDetailsPage(this.gallerie);

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  var galleryData;
  int currentPage = 1;
  int size = 10;
  int totalPages = 0;
  ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.gallerie);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading &&
          currentPage < totalPages) {
        currentPage++;
        getGalleryData(widget.gallerie);
      }
    });
  }

  void getGalleryData(String gallerie) {
    if (isLoading) return;

    setState(() {
      isLoading = true; // Indicateur de chargement en cours
    });

    String url =
        "https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=${gallerie}&page=${currentPage}&per_page=${size}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.galleryData = json.decode(resp.body);
        if (galleryData['hits'] != null) {
          hits.addAll(galleryData['hits']);
          totalPages = (galleryData['totalHits'] / size).ceil();
        } else {
          totalPages = 0;
        }
        isLoading = false; // Chargement terminé
      });
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      print("Erreur: $err");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: totalPages == 0
            ? Text('Pas de résultats')
            : Text("${widget.gallerie}, Page ${currentPage} / ${totalPages}"),
      ),
      body: (galleryData == null && !isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: hits.length + (isLoading ? 1 : 0), // Ajout du loader
              itemBuilder: (context, index) {
                if (index == hits.length) {
                  return Center(child: CircularProgressIndicator()); // Loader en bas
                }
                return Column(
                  children: [
                    Card(
                      color: Colors.blue,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          hits[index]['tags'],
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        child: Image.network(
                          hits[index]['largeImageURL'], // URL de l'image
                          fit: BoxFit.fitWidth, // Adapter l'image à la largeur
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }

  // Libérer les ressources et le scroll controller
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

