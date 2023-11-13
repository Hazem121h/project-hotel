import 'package:dio/dio.dart';
class DioHelper {
  static  Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://www.hotelsgo.co/',
        receiveDataWhenStatusError: true,headers: {'Content-Type':'application/json'}));
  }

  static Future<Response> getData({required String url,String? token}) async {
    dio?.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',

    };
    return await dio!.get(url);
  }

  static  Future<Response> postData(
      {required String url, required Map<String, dynamic> data,String? token}) async {
    dio?.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',

    };
    return await dio!.post(url,data:data );
  }
  static  Future<Response> uplodeData(
      {required String url, required Map data,String? token}) async {
    dio?.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',

    };
    return await dio!.post(url,data:data );
  }

}


  