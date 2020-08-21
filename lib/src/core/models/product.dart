class Product {
  String id;
  String name;
  String price;
  String sundries;

  Product({this.id, this.name, this.price,this.sundries});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    sundries = json['sundries'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['sundries'] = this.sundries;

    return data;
}
}
