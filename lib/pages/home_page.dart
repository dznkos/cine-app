import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

import 'package:peliculas/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  List<Pelicula> listPeliculas = new List<Pelicula>();

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas de Estreno'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () { },
          )
        ],
      ),
      
      body: Container(
          padding: EdgeInsets.all(25.0) ,
          child: Column(
            children: [
              _swipeTarjetas(),
            ],
          )
      ),
    );
  }

  Widget _swipeTarjetas() {

    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context,AsyncSnapshot<List> snapshot) {

          if ( snapshot.hasData ){
            return CardSwiper( peliculas: snapshot.data );
          }else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }


        },
    );

  }
}
