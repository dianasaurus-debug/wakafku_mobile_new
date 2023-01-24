
class Report {
  late String title;
  late String created_by;
  late String desc;
  late String created_at;
  late int id;


  Report({
    this.id=0,
    this.title="",
    this.created_by="",
    this.desc="",
    this.created_at = '',
  });

  Report.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        created_by = json['created_by'],
        desc = json['desc'],
        id = json['id'].runtimeType == String ? int.parse(json['id']) : json['id'],
        created_at = json['created_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
  };
}