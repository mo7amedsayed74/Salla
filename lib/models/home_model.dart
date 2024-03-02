
class HomeModel {
  bool? status;
  DataModelFromHome? data;

  // named constructor
  HomeModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = jsonData['data'] != null ? DataModelFromHome.fromJson(jsonData['data']) : null;
  }
}

class DataModelFromHome{
  List<BannersModel>? banners = [];
  List<ProductsModel>? products = [];

  // named constructor
  DataModelFromHome.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((item) {
      banners!.add(BannersModel.fromJson(item));
    });
    json['products'].forEach((item) {
      products!.add(ProductsModel.fromJson(item));
    });
  }
}

class BannersModel {
  int? id;
  String? image;

  // named constructor
  BannersModel.fromJson(Map<String, dynamic> bannerJson) {
    id = bannerJson['id'];
    image = bannerJson['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  // named constructor
  ProductsModel.fromJson(Map<String, dynamic> productJson) {
    id = productJson['id'];
    price = productJson['price'];
    oldPrice = productJson['old_price'];
    discount = productJson['discount'];
    image = productJson['image'];
    name = productJson['name'];
    inFavorites = productJson['in_favorites'];
    inCart = productJson['in_cart'];
  }
}
