class YoutubeModel {
  String? imDbId;
  String? title;
  String? fullTitle;
  String? type;
  String? year;
  String? videoId;
  String? videoUrl;
  String? errorMessage;

  YoutubeModel(
      {this.imDbId,
        this.title,
        this.fullTitle,
        this.type,
        this.year,
        this.videoId,
        this.videoUrl,
        this.errorMessage});

  YoutubeModel.fromJson(Map<String, dynamic> json) {
    imDbId = json['imDbId'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    type = json['type'];
    year = json['year'];
    videoId = json['videoId'];
    videoUrl = json['videoUrl'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imDbId'] = this.imDbId;
    data['title'] = this.title;
    data['fullTitle'] = this.fullTitle;
    data['type'] = this.type;
    data['year'] = this.year;
    data['videoId'] = this.videoId;
    data['videoUrl'] = this.videoUrl;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}
