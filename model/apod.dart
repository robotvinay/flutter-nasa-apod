class APOD {
  String title;
  DateTime date;
  String page;
  String copyright;
  String description;
  String thumbnailUrl;
  String imageThumbnail;
  String urlImage;
  String hdurl;
  String mediaType;

  APOD();

  // User(int id, String name, String username, String email) {
  //   this.id = id;
  //   this.name = name;
  //   this.username = username;
  //   this.email = email;
  // }

  APOD.fromJson(Map json)
      : title = json['title'],
        date = json['date'],
        page = json['username'],
        copyright = json['copyright'],
        description = json['description'],
        thumbnailUrl = json['thumbnail_url'],
        imageThumbnail = json['image_thumbnail'],
        urlImage = json['url_image'],
        hdurl = json['hdurl'],
        mediaType = json['media_type'];
}
