class WishlistModel {
  int? statusCode;
  Data? data;
  String? message;

  WishlistModel({this.statusCode, this.data, this.message});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Items>? items;
  double? total;

  Data({this.items, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Items {
  int? id;
  int? userId;
  int? productId;
  int? quantity;
  String? addedAt;
  Product? product;

  Items(
      {this.id,
        this.userId,
        this.productId,
        this.quantity,
        this.addedAt,
        this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    quantity = json['quantity'];
    addedAt = json['addedAt'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['addedAt'] = this.addedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  int? categoryId;
  String? image;
  int? stock;
  double? rating;
  int? reviews;
  String? brand;
  String? createdAt;

  Product(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.categoryId,
        this.image,
        this.stock,
        this.rating,
        this.reviews,
        this.brand,
        this.createdAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['categoryId'];
    image = json['image'];
    stock = json['stock'];
    rating = json['rating'];
    reviews = json['reviews'];
    brand = json['brand'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['categoryId'] = this.categoryId;
    data['image'] = this.image;
    data['stock'] = this.stock;
    data['rating'] = this.rating;
    data['reviews'] = this.reviews;
    data['brand'] = this.brand;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
