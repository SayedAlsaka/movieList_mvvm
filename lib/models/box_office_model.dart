class BoxOfficeModel {
  List<Items>? items;
  String? errorMessage;

  BoxOfficeModel({this.items, this.errorMessage});

  BoxOfficeModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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

class Items {
  String? id;
  String? rank;
  String? title;
  String? image;
  String? weekend;
  String? gross;
  String? weeks;

  Items(
      {this.id,
        this.rank,
        this.title,
        this.image,
        this.weekend,
        this.gross,
        this.weeks});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    title = json['title'];
    image = json['image'];
    weekend = json['weekend'];
    gross = json['gross'];
    weeks = json['weeks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rank'] = this.rank;
    data['title'] = this.title;
    data['image'] = this.image;
    data['weekend'] = this.weekend;
    data['gross'] = this.gross;
    data['weeks'] = this.weeks;
    return data;
  }
}
