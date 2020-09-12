
import 'package:flutter/material.dart';
import 'package:peliculas/models/actor_model.dart';

import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

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
                    Container(                      
                      color: Colors.transparent,
                      child: Container(
                        margin: EdgeInsets.only(right: 300, left: 20) ,
                        decoration: new BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: new BorderRadius.circular(20.0)
                        ),
                        padding: EdgeInsets.only(left: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Text('Actores',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0,
                                    color: Colors.white
                                  ),
                                  ),
                        ),
                      ),
                    ),
                    _crearCasting(pelicula),
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
      pinned: true,
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


  Widget _posterTitulo(BuildContext context, Pelicula pelicula ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage( pelicula.getPosterImg() ),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( pelicula.title, style: Theme.of(context).textTheme.subtitle1,),
                  Text( pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Icon( Icons.star_border),
                      Text( pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle2 ),
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

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getActores( pelicula.id.toString() ),
      builder: (context, AsyncSnapshot<List> snapshot) {

        if( snapshot.hasData ){
          return _crearActoresPageView( snapshot.data);
        }
        else{
          return Center( child: CircularProgressIndicator() );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        pageSnapping: false,
        scrollDirection: Axis.horizontal,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i])

      ),
    );
  }

  Widget _actorTarjeta( Actor actor){

    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: FadeInImage(
                height: 150,
                fadeInDuration: Duration(milliseconds: 150),
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage( actor.getFoto() )),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

  }

}
