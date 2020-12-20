import 'package:dio/dio.dart';
import 'package:vn_dental/utils/const.dart';

var dio = Dio(BaseOptions(
    baseUrl: Const.HOST_URL,
    receiveTimeout: 60 * 1000 * 2,
    connectTimeout: 60 * 1000 * 2,
    headers: {"Content-Type": "application/json"},
    contentType: "application/json"));

var dioMap = Dio(BaseOptions(
  baseUrl: Const.HOST_GOOGLE_MAP_URL,
  receiveTimeout: 60 * 1000 * 2,
  connectTimeout: 60 * 1000 * 2,
));
