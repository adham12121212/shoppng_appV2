class ProductModel {
  int? statusCode;
  Data? data;
  String? message;

  ProductModel({this.statusCode, this.data, this.message});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;
  Pagination? pagination;

  Data({this.products, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Products {
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

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? pages;

  Pagination({this.page, this.limit, this.total, this.pages});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['pages'] = this.pages;
    return data;
  }
}
