import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:peliculas/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
    return CardSwiper(
      peliculas: [1,2,3,4,5],
    );
  }
}
