class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList){

    if ( jsonList == null ) return;
    jsonList.forEach(( p )
    {
      final actor = Actor.fromJsonMap( p );
      actores.add(actor);
    });
  }
}


class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
      this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> json) {
    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];
  }

  getFoto() {
    if ( profilePath == null) {
      return 'https://bizraise.pro/wp-content/uploads/2014/09/no-avatar-300x300.png';
    }
    else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}