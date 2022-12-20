class Program {
  late String title = '';
  late String desc = '';
  late String address_detail = '';
  late String latitude = '';
  late String longitude = '';
  late String cover = '';
  late String terkumpul = '';
  late double distance = 0;
  late int id;

  Program({this.id = 0,
    this.title = '',
    this.desc = '',
    this.address_detail = '',
    this.latitude = '',
    this.longitude = '',
    this.cover = '',
    this.distance = 0,
    this.terkumpul = ''});

  Program.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        desc = json['desc'],
        address_detail = json['address_detail'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        distance = json['distance'] != null? json['distance'] : 0,
        cover = json['cover'],
        terkumpul = json['terkumpul'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title': title,
    'desc': desc,
    'address_detail': address_detail,
    'latitude' : latitude,
    'longitude': longitude,
    'cover': cover,
    'terkumpul': terkumpul
  };
}