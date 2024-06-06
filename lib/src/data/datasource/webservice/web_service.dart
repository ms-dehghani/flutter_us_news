import 'package:dio/dio.dart';
import 'package:flutter_us_news/src/configs.dart';
import 'package:flutter_us_news/src/data/constants/constants.dart';

class WebService {
  static WebService? _singleton;

  factory WebService(Dio dio) {
    _singleton ??= WebService._internal(dio);
    return _singleton!;
  }

  late Dio _dio;

  WebService._internal(Dio dio) {
    _dio = dio;
  }

  Future<dynamic> get(String url) async {
    var result = await _dio.get("$url&apiKey=${Configs.apiKey}");
    int statusCode = result.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      if ((result.data as Map).containsKey("status") &&
          (result.data as Map)["status"].toString() == "ok") {
        return Future.value(result.data);
      } else {
        return Future.error(Exception((result.data as Map)["code"]));
      }
    } else {
      return Future.error(Exception(Constants.invalidData));
    }
  }
}
