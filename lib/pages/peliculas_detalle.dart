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
              delegate: new SliverChildListDelegate(
                  [
                    SizedBox( height: 10.0,),
                    _posterTitulo(context, pelicula),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                    _descripcion(pelicula),
                  ]
              )
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

  Widget _posterTitulo(BuildContext context, Pelicula pelicula ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage( pelicula.getPosterImg() ),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( pelicula.title, style: Theme.of(context).textTheme.title,),
                  Text( pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Icon( Icons.star_border),
                      Text( pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subhead ),
                    ],
                  )
                ],
              )
          ),

        ],
      )
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 55.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
    
  }

}
