class MenuItem {
  String? sId;
  String? name;
  double? price;
  String? category;
  String? description;
  String? imageUrl;
  int? iV;

  MenuItem(
      {this.sId,
      this.name,
      this.price,
      this.category,
      this.description,
      this.imageUrl,
      this.iV});

  MenuItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category'] = this.category;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['__v'] = this.iV;
    return data;
  }
}
