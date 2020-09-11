import 'package:flutter/material.dart';

import 'package:peliculas/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar( pelicula ),
          new SliverList(
              delegate: new SliverChildListDelegate(_buildList(32))
          ),
        ],
      ),
    );
  }

  Widget _crearAppbar( Pelicula pelicula){

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 300.0,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
                     centerTitle: true,
                      title: Text(
                        pelicula.title,
                        style: TextStyle( color: Colors.white, fontSize: 16.0),
                      ),
                      background: FadeInImage(
                        placeholder: AssetImage('assets/loading.gif'),
                        image: NetworkImage( pelicula.getBackgroundImg() ),
                        fadeInDuration: Duration( milliseconds: 150),
                        fit: BoxFit.cover,
                      ),
      ),
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(padding: new EdgeInsets.all(20.0),
          child: new Text(
              'Item ${i.toString()}',
              style: new TextStyle(fontSize: 25.0)
          )
      ));
    }

    return listItems;
  }

}
