class PopularBooks {
  String? rating;
  String? title;
  String? text;
  String? img;
  String? audio;

  PopularBooks({this.rating, this.title, this.text, this.img, this.audio});
  PopularBooks.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    title = json['title'];
    text = json['text'];
    img = json['img'];
    audio = json['audio'];
  }
}
