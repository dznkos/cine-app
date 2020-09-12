import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{
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

    throw UnimplementedError();
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

    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultamos que vamos a mostrar

    return Container();

    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen cuando la persona escribe
    return Container();

    throw UnimplementedError();
  }

}