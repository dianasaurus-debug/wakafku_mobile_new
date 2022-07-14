

class PaymentInstruction {
  late String title;
  late String desc;
  late int id;


  PaymentInstruction({
    this.id=0,
    this.title="",
    this.desc="",
  });

  PaymentInstruction.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['desc'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'desc' : desc,
    'title': title,
  };
}