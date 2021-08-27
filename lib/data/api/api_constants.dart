import 'package:dio/dio.dart';

import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/data/api/log_interceptor.dart';
import 'package:themotorwash/data/local/local_data_service.dart';

class ApiConstants {
  final GlobalAuthBloc _globalAuthBloc;
  ApiConstants({
    required GlobalAuthBloc globalAuthBloc,
  }) : _globalAuthBloc = globalAuthBloc;

  Dio dioClient() {
    var state = _globalAuthBloc.state;
    Map<String, dynamic>? headers;
    if (state is Authenticated) {
      headers = {'Authorization': 'JWT ${state.tokens.accessToken}'};
    }
    BaseOptions options = new BaseOptions(
        // baseUrl: "<URL>",
        responseType: ResponseType.plain,
        headers: headers);
    Dio client = Dio(options);
    client.interceptors.add(Logging());

    return client;
  }

  final String baseUrl = "motorwash.herokuapp.com";
  final int pageLimit = 3;

  String getStoreListEndPoint() {
    return "$baseUrl/store/list";
  }

  String getStoreListByLocationEndPoint(
      {required String city,
      required double lat,
      required double long,
      required int offset}) {
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
      {required String slug,
      required String vehicleType,
      required int offset}) {
    Map<String, dynamic> params = {
      'offset': offset.toString(),
      'limit': pageLimit.toString(),
      'vehicle_type': vehicleType.toString()
    };
    var uri = Uri.https(baseUrl, "/store/$slug/services", params);
    return uri.toString();
  }

  String postReviewEndPoint() {
    var uri = Uri.https(baseUrl, "/review/");
    return uri.toString();
  }

  String getReviewEndPoint({required String bookingId}) {
    var uri = Uri.https(baseUrl, "/review/$bookingId");
    return uri.toString();
  }

  String getBookingListEndPoint({required int offset}) {
    Map<String, dynamic> params = {
      'offset': offset.toString(),
      'limit': pageLimit.toString()
    };
    var uri = Uri.https(baseUrl, "/booking/list/consumer", params);
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

  String postCheckOTPEndpoint() {
    var uri = Uri.https(baseUrl, "/consumer/login/checkOTP/");
    return uri.toString();
  }

  String postSendOTPEndpoint() {
    var uri = Uri.https(baseUrl, "/consumer/login/sendOTP/");
    return uri.toString();
  }

  String getBookingDetailsEndpoint({required String bookingId}) {
    var uri = Uri.https(baseUrl, "/booking/$bookingId");
    return uri.toString();
  }

  String postGetSlotsByCartDateEndpoint() {
    var uri = Uri.https(baseUrl, "/slots/create");
    return uri.toString();
  }

  String postInitiatePaytmPaymentEndpoint() {
    var uri = Uri.https(baseUrl, "/payment/initiate/");
    return uri.toString();
  }

  String postCheckPaytmPaymentStatusEndpoint() {
    var uri = Uri.https(baseUrl, "/payment/callback/");
    return uri.toString();
  }

  String getVehicleTypeListEndpoint() {
    var uri = Uri.https(baseUrl, "/vehicle_type/list/");
    return uri.toString();
  }

  String getServicesBySearchQueryEndPoint(
      {required String query, required int offset}) {
    Map<String, dynamic> params = {
      'search': query,
      'offset': offset.toString(),
      'limit': pageLimit.toString()
    };
    var uri = Uri.https(baseUrl, "/service/list/", params);
    return uri.toString();
  }

  String getStoresBySearchQueryAndLocationEndPoint(
      {required String query,
      required String city,
      required double lat,
      required double long,
      required int offset}) {
    Map<String, dynamic> params = {
      'query': query.toString(),
      'offset': offset.toString(),
      'limit': pageLimit.toString(),
      'latitude': lat.toString(),
      'longitude': long.toString()
    };
    var uri = Uri.https(baseUrl, "/store/list/$city", params);
    return uri.toString();
  }
}
