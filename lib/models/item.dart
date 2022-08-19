class Item {
  final String itemcode;

  Item({
    required this.itemcode,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemcode: json['itemcode'],
    );
  }
}