import 'package:dio/dio.dart';

class ApiConstants {
  BaseOptions options = new BaseOptions(
      baseUrl: "<URL>",
      responseType: ResponseType.plain,
      headers: {
        'Authorization':
            'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI4MTg5MDM2LCJqdGkiOiIwMjVjZjk4MjlhNDE0ODJiYjA4ODQ2MGZhZWU1Njk3ZiIsInVzZXJfaWQiOjF9.icyYWetBBg2oevd8gVUuSiMFzbu96lKCxpyafmaPcmg'
      });
  Dio get dioClient => Dio(options);
  final String baseUrl = "motorwash.herokuapp.com";
  final int pageLimit = 10;

  String getStoreListEndPoint() {
    return "$baseUrl/store/list";
  }

  String getStoreListByCityEndPoint(
      {required String city, required int offset}) {
    Map<String, dynamic> params = {
      'offset': offset.toString(),
      'limit': pageLimit.toString()
    };
    var uri = Uri.https(baseUrl, "/store/list/$city", params);
    return uri.toString();
  }

  String getStoreBySlugEndPoint({required String slug}) {
    var uri = Uri.https(baseUrl, "/store/$slug");
    return uri.toString();
  }

  String getStoreReviewBySlugEndPoint(
      {required String slug, required int offset}) {
    Map<String, dynamic> params = {
      'offset': offset.toString(),
      'limit': pageLimit.toString()
    };
    var uri = Uri.https(baseUrl, "/store/$slug/reviews", params);

    return uri.toString();
  }

  String getStoreServicesBySlugVehicleTypeEndPoint(
      {required String slug, required int vehicleType, required int offset}) {
    Map<String, dynamic> params = {
      'offset': offset.toString(),
      'limit': pageLimit.toString()
    };
    var uri = Uri.https(baseUrl, "/store/$slug/services", params);
    return uri.toString();
  }

  String postReviewEndPoint({required String slug}) {
    return "$baseUrl/store/$slug/reviews";
  }

  String getBookingListEndPoint({required int offset}) {
    Map<String, dynamic> params = {
      'offset': offset.toString(),
      'limit': pageLimit.toString()
    };
    var uri = Uri.https(baseUrl, "/booking/list/", params);
    return uri.toString();
  }

  String getPutPatchAccountEndPoint() {
    return "$baseUrl/account/";
  }

  String getCartEndpoint() {
    var uri = Uri.https(baseUrl, "/cart/getcart/");
    return uri.toString();
  }

  String postAddItemToCartEndpoint() {
    var uri = Uri.https(
      baseUrl,
      "/cart/additem/",
    );
    return uri.toString();
  }

  String postDeleteItemFromCartEndpoint() {
    var uri = Uri.https(baseUrl, "/cart/removeitem/");
    return uri.toString();
  }
}
