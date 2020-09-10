import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

import 'package:peliculas/widgets/card_swiper_widget.dart';
import 'package:peliculas/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  List<Pelicula> listPeliculas = new List<Pelicula>();

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

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
          padding: EdgeInsets.all(10.0) ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _swipeTarjetas(),
              _footer(context),
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

  Widget _footer(BuildContext context){

    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Populares', style: Theme.of(context).textTheme.subtitle2)),
            SizedBox( height: 5.0,),

            StreamBuilder(
                stream: peliculasProvider.popularesStream,
                builder: (context,AsyncSnapshot<List> snapshot) {
                  if ( snapshot.hasData ){
                    return MovieHorizontal(
                        peliculas: snapshot.data,
                        siguientePagina: peliculasProvider.getPopulares,
                    );
                  }else{
                    return Center(
                        child: CircularProgressIndicator()
                    );
                  }
                },)
          ],
        ),
    );

  }

}
