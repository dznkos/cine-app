import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  final peliculasProvider = new PeliculasProvider();

  String seleccion = '';

  final peliculas = [
    'Avengers',
    'Conjuro 2',
    'Hulk',
    'Spiderman',
    'Transformers',
    'Iron Man 1',
    'Iron Man 2',
    'Iron Man 3',
    'Iron Man 4',
  ];

  final peliculasRecientes = [
    'Wall-e',
    'Shazam',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar

    return IconButton(
      onPressed: () {
        close(context, null );
      },
      icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation),
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultamos que vamos a mostrar

    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if ( query.isEmpty ){

      return Container();
    }

    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if ( snapshot.hasData ){
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map( (pelicula) {
                return ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: NetworkImage( pelicula.getPosterImg()),
                      width: 50.0,
                      fit: BoxFit.contain,
                  ),
                  title: Text( pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList()
            );

          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );

  }

  /*@override
  Widget buildSuggestions(BuildContext context) {

    final listaSugerida = ( query.isEmpty )
        ? peliculasRecientes
        : peliculas.where((e) => e.toLowerCase().startsWith( query.toLowerCase())
    ).toList();

    // son las sugerencias que aparecen cuando la persona escribe
    return
      ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon( Icons.movie ),
            title: Text( listaSugerida[i]),
            onTap: () {
              seleccion = listaSugerida[i];
              showResults(context);
            },
          );
        },
      );

  }*/

}