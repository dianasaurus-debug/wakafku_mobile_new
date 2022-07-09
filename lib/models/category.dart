class Category {
  final String name;
  final String desc;
  final String label;
  final String image;

  final int id;


  Category(this.name,this.id, this.label, this.image,this.desc);

  Category.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        label = json['label'],
        image = json['image'],
        desc = json['desc'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': name,
  };
}