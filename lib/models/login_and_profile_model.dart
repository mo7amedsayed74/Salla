
class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data = jsonData['data'] != null ? UserData.fromJson(jsonData['data']) : null;
  }
}

/*
"data": {
        "id": 58882,
        "name": "Mohamed Sayed",
        "email": "mohammedsayed7414@gmail.com",
        "phone": "01153262796",
        "image": "https://student.valuxapps.com/storage/uploads/users/whnKSl3OSP_1695261183.jpeg",
        "points": 0,
        "credit": 0,
        "token": "91LoejcXBhTbhRKy7UWG590kixgf9qAz7Yqeyp8RtSiRjhUECTW9K1lZAxDEHla3Qnw7eG"
    }
*/
class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.image,
  //   this.points,
  //   this.credit,
  //   this.token,
  // });

  // named constructor
  UserData.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    points = data['points'];
    credit = data['credit'];
    token = data['token'];
  } // في الكونستراكتور العادي هديله كل فاريبل لوحده لاكن في ال named هديله الماب على بعضها
}
