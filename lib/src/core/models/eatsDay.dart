class EatsDay {
  List<String> officerIds;
  String productId;
  String price;
  String date;

  EatsDay({this.officerIds, this.productId, this.price, this.date});

  EatsDay.fromJson(Map<String, dynamic> json) {

    officerIds = new List<String>();
    json['officerIds'].forEach((v) {
      officerIds.add(v);
    });

    productId = json['productId'];
    price = json['price'];
    date = json['date'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['officerIds'] = this.officerIds.map((v) => v).toList();
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['date'] = this.date;
    return data;
  }
}
