
import 'package:dio/dio.dart';

import 'hive_helper.dart';

class DioHelper {

 static late Dio _dio;

 static void init() {
      _dio = Dio(
         BaseOptions(
        baseUrl: 'http://10.0.2.2:3000/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${HiveHelper.getToken()}",
        },
      ),
    );
  }


 static Future<Response> getData(String path)async {
    final   result = await _dio.get(path);
    return result;
  }


 static Future<Response> postData(String path, {dynamic body,dynamic params})async {
    final result =await _dio.post(path,data: body,queryParameters: params);
    return result;
  }

  static Future<Response> deleteData(String path)async {
    final result =await  _dio.delete(path);
    return result;
  }


  static Future<Response> putData(String path, {dynamic body})async {
    final result =await _dio.put(path,data: body);
    return result;
  }

}