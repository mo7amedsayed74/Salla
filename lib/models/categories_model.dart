
class CategoriesModel {
  bool? status;
  CategoriesDataModel? categoriesData;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoriesData = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModelFromCategories>? data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((item) {
      data!.add(DataModelFromCategories.fromJson(item));
    });
  }
}

class DataModelFromCategories {
  int? id;
  String? name;
  String? image;

  // named constructor
  DataModelFromCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
