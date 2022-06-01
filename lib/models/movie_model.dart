class MovieModel {
  List<MovieItemsModel>? movie;
  String? errorMessage;
  MovieModel.fromJson(Map<String, dynamic> json) {
    movie = List.from(json['items'])
        .map((e) => MovieItemsModel.fromJson(e))
        .cast<MovieItemsModel>()
        .toList();
    errorMessage = json['errorMessage'];
  }
}
class MovieItemsModel {
  late String id;
  late String rank;
  late String title;
  late String fullTitle;
  late String year;
  late String image;
  late String crew;
  late String iMDPRating;
  late String iMDPRatingCount;

  MovieItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    year = json['year'];
    image = json['image'];
    crew = json['crew'];
    iMDPRating = json['imDbRating'];
    iMDPRatingCount = json['imDbRatingCount'];
  }
}
