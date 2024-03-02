class SearchModel {
  bool? status;
  SearchDataModel? searchDataModel;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    searchDataModel = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  int? currentPage;
  List<Product>? data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((item) {
      data!.add(Product.fromJson(item));
    });
  }
}

class Product {
  int? productid;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<dynamic> images = [];
  bool?inFavorite;
  bool?inCart;

  Product.fromJson(Map<String, dynamic> json) {
    productid = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
