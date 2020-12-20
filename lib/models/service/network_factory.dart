import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/utils/const.dart';
import 'package:vn_dental/utils/log.dart';
import 'package:vn_dental/utils/utils.dart';

class NetworkFactory {
  BuildContext context;
  Dio _dio;
  SharedPreferences _sharedPreferences;

  // constructor
  NetworkFactory(this.context, {bool isGoogleMap: false}) {
    _dio = Dio(BaseOptions(
        baseUrl: isGoogleMap ? Const.HOST_GOOGLE_MAP_URL : Const.HOST_URL,
        receiveTimeout: 2 * 60 * 1000,
        connectTimeout: 2 * 60 * 1000,
        contentType: "application/json"));
    _setupLoggingInterceptor(context);
  }

  Future<Object> login1(String email, String password) async {
    FormData formData = new FormData.fromMap({
      "email": email.trim(),
      "password": password,
    });
    return await requestApi(_dio.post("api/v1/auth/login", data: formData));
  }

  Future<Object> login(
      String phone, String password, String deviceToken) async {
    FormData formData = new FormData.fromMap({
      "phone_number": phone.trim(),
      "password": password,
      "device_token": deviceToken
    });
    return await requestApi(_dio.post("api/v1/member/login", data: formData));
  }

  Future<Object> signUp(
      String name,
      String phone,
      String email,
      String password,
      String passwordConfirmation,
      bool term,
      String deviceToken) async {
    FormData formData = new FormData.fromMap({
      "phone_number": phone.trim(),
      "full_name": name,
      "email": email.trim(),
      "password": password,
      "password_confirmation": passwordConfirmation,
      "terms": term == true ? 1 : 0,
      "device_token": deviceToken
    });
    return await requestApi(
        _dio.post("api/v1/member/register", data: formData));
  }

  // Future<Object> changePassword(ChangePasswordRequestEntity request) async {
  //   return await requestApi(
  //       _dio.post("api/v1/member/change_password", data: request.toJson()));
  // }

  Future<Object> forgotPassword(String email) async {
    FormData formData = new FormData.fromMap({
      "email": email.trim(),
    });
    return await requestApi(
        _dio.post("api/v1/member/forgot_password", data: formData));
  }

  Future<Object> getProfile() async {
    return await requestApi(_dio.get("api/v1/member/profile"));
  }

  Future<Object> refreshToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String refreshToken = _sharedPreferences.getString(Const.REFRESH_TOKEN);
    return await requestApi(_dio
        .post("api/v1/refresh-token", data: {"refresh-token": refreshToken}));
  }

  Future<Object> subscribe(
      {String name, @required String email, List<dynamic> listCategory}) async {
    return await requestApi(_dio.post("api/v1/member/subscribe-news-letter",
        data: {"email": email, "name": name, "category_ids": listCategory}));
  }

  Future<Object> getAddress() async {
    return await requestApi(_dio.get("api/v1/member/address"));
  }

  Future<Object> getDistrict() async {
    return await requestApi(
        _dio.get("https://thongtindoanhnghiep.co/api/city/3/district"));
  }

  Future<Object> getCity() async {
    return await requestApi(_dio.get("api/v1/member/cities"));
  }

  Future<Object> getWard(int district) async {
    return await requestApi(
        _dio.get("https://thongtindoanhnghiep.co/api/district/$district/ward"));
  }

  Future<Object> getFacebookResponse(String token) async {
    return await requestApi(_dio.get(
        "https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),email&access_token=$token"));
  }

  Future<Object> getDistrict1(String city) async {
    return await requestApi(_dio.get(
        "mobile/users/address/get-district-list?address_city=${Uri.encodeFull(city)}"));
  }

  Future<Object> getHome() async {
    return await requestApi(_dio.get("api/v1/member/home"));
  }

  Future<Object> getDetailTask(int taskId) async {
    return await requestApi(
        _dio.post("api/v1/task/detail", data: {"orderId": taskId}));
  }

  Future<Object> getMyOrder({String start, String end}) async {
    return await requestApi(
        _dio.post("api/v1/member/order", data: {"start": start, "end": end}));
  }

  Future<Object> getDetailOrder(int orderId) async {
    return await requestApi(_dio.get("api/v1/member/order/$orderId"));
  }

  Future<Object> getListProduct() async {
    return await requestApi(_dio.get("api/v1/e-commerce/shop/products-list"));
  }

//  Future<Object> getProductDetail(int productId) async {
//    return await requestApi(
//        _dio.get("api/v1/e-commerce/shop/single-product/$productId"));
//  }

  Future<Object> getProductDetail(String productId) async {
    return await requestApi(
        _dio.get("api/v1/member/product/detail/$productId"));
  }

  Future<Object> getSubCategory(String subCategoryId) async {
    return await requestApi(_dio.get("api/v1/member/category/$subCategoryId"));
  }

  Future<Object> getCategory() async {
    return await requestApi(_dio.get("api/v1/member/category"));
  }

  Future<Object> getSubscribeCategory() async {
    return await requestApi(_dio.get("api/v1/member/subscribe/categories"));
  }

  Future<Object> deleteAddress(int key) async {
    return await requestApi(
        _dio.post("api/v1/member/address/delete", data: {"key": key}));
  }

  Future<Object> getCountUnReadNotification() async {
    return await requestApi(
        _dio.get("api/v1/member/notification/count_unread"));
  }

  Future<Object> getListNotification({int pageNumber}) async {
    return await requestApi(_dio.get(
        "api/v1/member/notification/list?page=$pageNumber&perPage=${Const.MAX_COUNT_ITEM}"));
  }

  Future<Object> getFaq() async {
    return await requestApi(_dio.get("api/v1/member/faqs"));
  }

  Future<Object> getListNews({int pageNumber}) async {
    return await requestApi(_dio.get("api/v1/member/news?page=$pageNumber"));
  }

  Future<Object> getCategoryNews({String slug, int pageNumber}) async {
    return await requestApi(
        _dio.get("api/v1/member/news/categories/$slug?page=$pageNumber"));
  }

  Future<Object> getSale({int pageNumber}) async {
    return await requestApi(_dio.get("api/v1/member/sales?page=$pageNumber"));
  }

  // Google search place

  Future<Object> searchPlace(String text,
      {String fromAdd, String toAdd}) async {
    text = text.replaceAll(" ", "+");
    return await requestApi(_dio.get(
        '/place/autocomplete/json?input=${text.trim()}&location=$fromAdd,$toAdd&key=${Const.PLACE_KEY}&components=country:vn&language=vi_VN'));
  }

  Future<Object> searchProduct(String text) async {
    return await requestApi(
        _dio.get("api/v1/member/product/search?text=$text"));
  }

  Future<Object> getDirection(String origin, String destination) async {
    origin = origin.replaceAll(" ", "+");
    destination = destination.replaceAll(" ", "+");
    return await requestApi(_dio.get(
        'directions/json?origin=$origin&destination=$destination&key=${Const.PLACE_KEY}&mode=driving&language=vi'));
  }

  // base handle network

  Future<Object> requestApi(Future<Response> request) async {
    try {
      Response response = await request;
      var data = response.data;
      if (data is List) return data;
      if (data is String) return data;
      if (data["status"] == null) return data;
      if (data["status"] == 200 ||
          data["status"] == "OK" ||
          data["status"] == "success")
        return data;
      else
        return data["message"];
    } catch (error, stacktrace) {
      logger.d("Exception occured: $error stackTrace: $stacktrace");
      return _handleError(error);
    }
  }

  String _handleError(dynamic error) {
    String errorDescription = "";
    if (error is DioError) {
      logger.e(error?.response?.toString() ?? "");
      switch (error.type) {
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = S.of(context).request_send_timeout;
          break;
        case DioErrorType.CANCEL:
          errorDescription = S.of(context).request_cancelled;
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = S.of(context).request_connect_timeout;
          break;
        case DioErrorType.DEFAULT:
          errorDescription = S.of(context).request_fail_due_internet;
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = S.of(context).request_receive_timeout;
          break;
        case DioErrorType.RESPONSE:
          String errorStr = error?.response?.toString();
          try {
            errorStr = error?.response?.data["message"];
          } catch (e) {
            logger.e(e.toString());
          }
          if (Utils.isEmpty(errorStr)) {
            errorDescription = S.of(context).request_error_code(
                error?.response?.statusCode?.toString() ?? "");
            if (error?.response?.statusCode == 401)
              try {
                // ignore: close_sinks
                // AuthenticationBloc authBloc =
                //     BlocProvider.of<AuthenticationBloc>(context);
                // authBloc.add(LoggedOut());
              } catch (e) {
                logger.e(e.toString());
              }
          } else {
            errorDescription = errorStr;
          }

          break;
        default:
          errorDescription = S.of(context).error;
      }
    } else {
      errorDescription = S.of(context).error;
    }
    return errorDescription;
  }

  void _setupLoggingInterceptor(BuildContext context) {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      _sharedPreferences = await SharedPreferences.getInstance();
      String token = _sharedPreferences.getString(Const.TOKEN);
      if (token != null) logger.d('--------------------token $token');
      if (!Utils.isEmpty(token))
        options.headers.addAll({"Authorization": "$token"});
      // Do something before request is sent
      if (options != null) {
        logger.d("--> ${options.method} ${options.path}");
        logger.d("Request body: ${options.data}");
      }
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) {
      // Do something with response data
      if (response != null) {
        logger.d(
            "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
        logger.d(response.data);
      }
      return response; // continue
    }, onError: (DioError error) async {
      // Do something with response error
      logger.d("DioError: ${error?.message}");
      if (error.response?.statusCode == 401) {
        try {
          // ignore: close_sinks
          // AuthenticationBloc authBloc =
          //     BlocProvider.of<AuthenticationBloc>(context);
          // authBloc.add(LoggedOut());
        } catch (e) {
          logger.e(e.toString());
        }
//        Dio tokenDio = Dio();
//        tokenDio.options = _dio.options;
//        _dio.lock();
//        _dio.interceptors.requestLock.lock();
//        _dio.interceptors.responseLock.lock();
//        RequestOptions options = error.response.request;
//        // update token and repeat
//        // Lock to block the incoming request until the token updated
//        String refreshToken = _sharedPreferences.getString(Const.REFRESH_TOKEN);
//        try {
//          return tokenDio.post("api/v1/refresh-token",
//              data: {"refresh_token": refreshToken}).then((response) {
//            logger.d("Refresh token success");
//            String token = response.data['data']['token'];
//            String refreshToken = response.data['data']['refresh_token'];
//            _sharedPreferences.setString(Const.TOKEN, token);
//            _sharedPreferences.setString(Const.REFRESH_TOKEN, refreshToken);
//          }).catchError((e) {
//            logger.e(e.toString());
//          }).whenComplete(() {
//            _dio.unlock();
//            _dio.interceptors.requestLock.unlock();
//            _dio.interceptors.responseLock.unlock();
//          }).then((e) {
//            //repeat
//            return _dio.request(options.path,
//                options: options, queryParameters: options.queryParameters);
//          });
//        } catch (e) {
//          logger.e(e.toString());
//        }
      } else {
        _handleError(error);
      }
      return error; //continue
    }));
  }
}
