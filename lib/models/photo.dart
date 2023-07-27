class Photo {
  int id;
  int albumId;
  String title;
  String url;
  String thumbnailUrl;

  Photo(
      {required this.id,
      required this.albumId,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      albumId: json['albumId'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnail'] as String
    );
  }
}
