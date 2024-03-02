class FavoritesModel {
  bool? status;
  String? message;
  FavoritesDataModel? favoritesDataModel;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    favoritesDataModel = FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel {
  int? currentPage;
  List<DataModelFromFavorites>? data = [];

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((item) {
      data!.add(DataModelFromFavorites.fromJson(item));
    });
  }
}

class DataModelFromFavorites {
  int? productid;
  Product? product;
  // named constructor
  DataModelFromFavorites.fromJson(Map<String, dynamic> json) {
    productid = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? productid;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    productid = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
