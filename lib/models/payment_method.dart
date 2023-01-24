
class PaymentMethod {
  late String name;
  late String logo;
  late String label;
  late String kind;
  late int id;


  PaymentMethod({
    this.id=0,
    this.name="",
    this.logo="",
    this.label="",
    this.kind = '',
  });

  PaymentMethod.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        label = json['label'],
        kind = json['kind'],
        id = json['id'].runtimeType == String ? int.parse(json['id']) : json['id'],
        logo = json['logo'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': name,
    'logo': logo
  };
}