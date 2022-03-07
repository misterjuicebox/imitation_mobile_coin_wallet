class AlbumsModel {
  final int userId;
  final int id;
  final String title;

  // String get title => title;

  AlbumsModel(this.userId, this.id, this.title);

  AlbumsModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
      };
}
