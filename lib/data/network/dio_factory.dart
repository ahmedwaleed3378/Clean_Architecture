import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:advanced_course/app/app_preferences.dart';
import 'package:advanced_course/app/constants.dart';

const String appJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultlanguange = 'language';

class DioFactory {
 final  AppPreferences _appPreferences;
  DioFactory(
     this._appPreferences,
  );
  
  Future<Dio> getDio() async {
  String language= await  _appPreferences.getAppLang();
    Dio dio = Dio();
    Map<String, String> headers = {
      contentType: appJson,
      accept: appJson,
      authorization: 'Send Token',
      defaultlanguange: language, //todo
    };
    dio.options = BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: headers,
        connectTimeout: const Duration(minutes:1),
        receiveTimeout: const Duration(minutes:1),
        sendTimeout: const Duration(minutes:1));

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
