import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_hrlweibo/public.dart';

class DioManager {
  static DioManager _instance;

  static DioManager getInstance() {
    if (_instance == null) {
      _instance = DioManager();
    }
    return _instance;
  }

  Dio dio = new Dio();

  DioManager() {
    dio.options.baseUrl = Constant.baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(LogInterceptor(responseBody: false)); //是否开启请求日志
  }

//get请求
  get(String url, FormData params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, 'get', params, errorCallBack);
  }

  //post请求
  post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, "post", params, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method, FormData params, Function errorCallBack]) async {
    Response response;
    try {
      if (method == 'get') {
        if (params != null) {
          response = await dio.get(url,
              queryParameters: Map.fromEntries(params.fields));
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.fields.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 201);
      }
      // debug模式才打印
      if (Constant.ISDEBUG) {
        print('请求异常: ' + error.toString());
      }
      _error(errorCallBack, error.message);
      return '';
    }
    if (Constant.ISDEBUG) {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("\n================== 请求数据 ==========================");
        print("url = ${options.uri.toString()}");
        print("headers = ${options.headers}");
        print("params = ${options.data}");
      }, onResponse: (Response response) {
        print("\n================== 响应数据 ==========================");
        print("code = ${response.statusCode}");
        print("data = ${response.data}");
        print("\n");
      }, onError: (DioError e) {
        print("\n================== 错误响应数据 ======================");
        print("type = ${e.type}");
        print("message = ${e.message}");
        print("\n");
      }));
    }

    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['status'] != 200) {
      _error(errorCallBack, dataMap['msg'].toString());
    } else if (successCallBack != null) {
      successCallBack(dataMap);
    }
  }

  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}
