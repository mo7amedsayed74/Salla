import 'package:dio/dio.dart';

class DioHelper{

  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String method,
    Map<String,dynamic>? query,
    String? lang = 'en',
    String? token = '',
})async{
    dio!.options.headers = {
      'lang': lang,
      'Content-Type':'application/json', // this header is const
      'Authorization': token,
    };
    return await dio!.get(
      method,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String method,
    required Map<String,dynamic> data,
    String? lang = 'en',
    String? token = '',
  })async{
    dio!.options.headers = {
      'lang': lang,
      'Content-Type':'application/json', // this header is const
      'Authorization': token,
    };
    return await dio!.post(
      method,
      data: data,
    );
  }


  static Future<Response> putData({
    required String method,
    required Map<String,dynamic> data,
    String? lang = 'en',
    String? token = '',
  })async{
    dio!.options.headers = {
      'lang': lang,
      'Content-Type':'application/json', // this header is const
      'Authorization': token,
    };
    return await dio!.put(
      method,
      data: data,
    );
  }


}