class ComingSoonModel {
  List<ItemsC>? items;
  String? errorMessage;

  ComingSoonModel({this.items, this.errorMessage});

  ComingSoonModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ItemsC>[];
      json['items'].forEach((v) {
        items!.add(new ItemsC.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class ItemsC {
  String? id;
  String? title;
  String? fullTitle;
  String? year;
  String? releaseState;
  String? image;
  String? runtimeMins;
  String? runtimeStr;
  String? plot;
  String? contentRating;
  String? imDbRating;
  String? imDbRatingCount;
  String? metacriticRating;
  String? genres;
  List<GenreList>? genreList;
  String? directors;
  List<DirectorList>? directorList;
  String? stars;
  // List<StarList>? starList;

  ItemsC({
    this.id,
    this.title,
    this.fullTitle,
    this.year,
    this.releaseState,
    this.image,
    this.runtimeMins,
    this.runtimeStr,
    this.plot,
    this.contentRating,
    this.imDbRating,
    this.imDbRatingCount,
    this.metacriticRating,
    this.genres,
    this.genreList,
    this.directors,
    this.directorList,
    this.stars,
  });

  ItemsC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    year = json['year'];
    releaseState = json['releaseState'];
    image = json['image'];
    runtimeMins = json['runtimeMins'];
    runtimeStr = json['runtimeStr'];
    plot = json['plot'];
    contentRating = json['contentRating'];
    imDbRating = json['imDbRating'];
    imDbRatingCount = json['imDbRatingCount'];
    metacriticRating = json['metacriticRating'];
    genres = json['genres'];
    if (json['genreList'] != null) {
      genreList = <GenreList>[];
      json['genreList'].forEach((v) {
        genreList!.add(new GenreList.fromJson(v));
      });
    }
    directors = json['directors'];
    if (json['directorList'] != null) {
      directorList = <DirectorList>[];
      json['directorList'].forEach((v) {
        directorList!.add(new DirectorList.fromJson(v));
      });
    }
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['fullTitle'] = this.fullTitle;
    data['year'] = this.year;
    data['releaseState'] = this.releaseState;
    data['image'] = this.image;
    data['runtimeMins'] = this.runtimeMins;
    data['runtimeStr'] = this.runtimeStr;
    data['plot'] = this.plot;
    data['contentRating'] = this.contentRating;
    data['imDbRating'] = this.imDbRating;
    data['imDbRatingCount'] = this.imDbRatingCount;
    data['metacriticRating'] = this.metacriticRating;
    data['genres'] = this.genres;
    if (this.genreList != null) {
      data['genreList'] = this.genreList!.map((v) => v.toJson()).toList();
    }
    data['directors'] = this.directors;
    if (this.directorList != null) {
      data['directorList'] = this.directorList!.map((v) => v.toJson()).toList();
    }
    data['stars'] = this.stars;

    return data;
  }
}

class GenreList {
  String? key;
  String? value;

  GenreList({this.key, this.value});

  GenreList.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class DirectorList {
  String? id;
  String? name;

  DirectorList({this.id, this.name});

  DirectorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
