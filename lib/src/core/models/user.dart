class User {
  String id;
  String name;
  String email;
  String password;
  String photo;
  String phone;
  String money_founder;
  int admin;
  String price;
  bool check;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.photo,
    this.phone,
    this.money_founder,
    this.admin,
    this.price,
    this.check,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    photo = json['photo'];
    phone = json['phone'];
    money_founder = json['money_founder'];
    admin = json['admin'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    data['money_founder'] = this.money_founder;
    data['admin'] = this.admin;
    data['price'] = this.price;
    return data;
  }
}
