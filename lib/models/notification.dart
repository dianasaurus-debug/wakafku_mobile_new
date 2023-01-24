
class NotificationModel {
  late String title;
  late String content;
  late String jenis;
  late int id;
  String? createdAt;

  NotificationModel({
    this.id = 0,
    this.title = "",
    this.content = "",
    this.jenis = '',
    this.createdAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        jenis = json['jenis'],
        id = json['id'],
        content = json['content'],
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content, 'created_at' : createdAt!};
}
