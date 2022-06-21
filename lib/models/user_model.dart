class UserModel
{
 String? id;
 String? image;
 String? name;
 String? email;
 String? bio;
 String? location;
 List<dynamic>? bookMarks;

 UserModel(
      {this.id,
      this.image,
      this.name,
      this.email,
      this.bio,
      this.location,
      this.bookMarks});

 UserModel.fromJson(Map<String,dynamic>json)
 {
id=json['id'];
image=json['image'];
name=json['name'];
email=json['email'];
bio=json['bio'];
location=json['location'];
bookMarks = json['bookMarks'];

 }

Map<String,dynamic> toMap()
{
return
    {
      'id':id,
      'image':image,
      'name':name,
      'email':email,
      'bio':bio,
      'location':location,
      'bookMarks':bookMarks,
    };
}

}