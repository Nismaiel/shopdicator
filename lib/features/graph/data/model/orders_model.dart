class OrdersModel {
  late String id;
  late bool isActive;
  late double price;
  late String company;
  late String picture;
  late String buyer;
  late List<String> tags;
  late String status;
  late DateTime registered;
  late bool isReturned;

  OrdersModel(
      {required this.id,
      required this.isActive,
      required this.price,
      required this.company,
      required this.picture,
      required this.buyer,
      required this.tags,
      required this.status,required this.isReturned,
      required this.registered});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    String refactoredPrice = json['price']!.replaceAll(RegExp(r'[^\d.]'), '');
    price = double.tryParse(refactoredPrice) ?? 0;
    company = json['company'];
    picture = json['picture'];
    buyer = json['buyer'];
    tags = json['tags'].cast<String>();
    status = json['status'];
    isReturned = json['status']=="RETURNED";
    registered = DateTime.parse(json['registered']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isActive'] = isActive;
    data['price'] = price;
    data['company'] = company;
    data['picture'] = picture;
    data['buyer'] = buyer;
    data['tags'] = tags;
    data['status'] = status;
    data['registered'] = registered;
    return data;
  }
}
