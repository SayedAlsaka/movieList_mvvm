class Trailer {
  String? videoId;
  String? title;
  String? description;
  String? duration;
  String? uploadDate;
  String? image;
  List<Videos>? videos;
  String? errorMessage;

  Trailer(
      {this.videoId,
        this.title,
        this.description,
        this.duration,
        this.uploadDate,
        this.image,
        this.videos,
        this.errorMessage});

  Trailer.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    uploadDate = json['uploadDate'];
    image = json['image'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['uploadDate'] = this.uploadDate;
    data['image'] = this.image;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class Videos {
  String? quality;
  String? mimeType;
  String? extension;
  String? url;

  Videos({this.quality, this.mimeType, this.extension, this.url});

  Videos.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    mimeType = json['mimeType'];
    extension = json['extension'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quality'] = this.quality;
    data['mimeType'] = this.mimeType;
    data['extension'] = this.extension;
    data['url'] = this.url;
    return data;
  }
}
