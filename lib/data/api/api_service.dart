import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:themotorwash/data/api/api_constants.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/review.dart';

class ApiService implements ApiMethods {
  final ApiConstants _apiConstants;
  ApiService({required ApiConstants apiConstants})
      : _apiConstants = apiConstants;

  @override
  Future<StoreEntity> getStoreDetailBySlug({required String slug}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getStoreBySlugEndPoint(slug: slug);

    Response res = await client.get(url);
    dynamic data = jsonDecode(res.data);
    print(data);

    StoreEntity store = StoreEntity.fromJson(data);
    print(store);
    return store;
  }

  @override
  Future<List<StoreListEntity>> getStoreListByCity(
      {required String city, required int offset}) async {
    Dio client = _apiConstants.dioClient();
    String url =
        _apiConstants.getStoreListByCityEndPoint(city: city, offset: offset);

    Response res = await client.get(url);

    // log(res.data.toString());
    Map<dynamic, dynamic> data = jsonDecode(res.data);
    List<StoreListEntity> stores = data['results']
        .map<StoreListEntity>((e) => StoreListEntity.fromJson(e))
        .toList();
    return stores;
  }

  @override
  Future<List<ReviewEntity>> getStoreReviewsBySlug(
      {required String slug, required int offset}) async {
    Dio client = _apiConstants.dioClient();
    String url =
        _apiConstants.getStoreReviewBySlugEndPoint(slug: slug, offset: offset);

    Response res = await client.get(url);
    dynamic data = jsonDecode(res.data);
    print(data.toString());
    List<ReviewEntity> reviews = data['results']
        .map<ReviewEntity>((e) => ReviewEntity.fromJson(e))
        .toList();
    return reviews;
  }

  @override
  Future<List<PriceTimeListEntity>> getStoreServicesBySlugAndVehicleType(
      {required String slug,
      required int vehicleType,
      required int offset}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getStoreServicesBySlugVehicleTypeEndPoint(
        slug: slug, vehicleType: vehicleType, offset: offset);
    Response res = await client.get(url);
    print(res.data.toString() + "hello");

    dynamic data = jsonDecode(res.data);

    // print(data.toString() + "hello");
    List<PriceTimeListEntity> services = data['results']
        .map<PriceTimeListEntity>((e) => PriceTimeListEntity.fromJson(e))
        .toList();

    return services;
  }

  @override
  Future<CartEntity> getCart() async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getCartEndpoint();
    Response res = await client.get(url);
    dynamic cartData = jsonDecode(res.data);
    return CartEntity.fromJson(cartData);
  }

  @override
  Future<CartEntity> postAddItemToCart({required int itemId}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postAddItemToCartEndpoint();

    Response res = await client.post(
      url,
      data: {'item': itemId},
    );
    print(res.toString() + "helloooo");
    dynamic cartData = jsonDecode(res.data);

    return CartEntity.fromJson(cartData);
  }

  @override
  Future<CartEntity> postDeleteItemFromCart({required int itemId}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postDeleteItemFromCartEndpoint();
    Response res = await client.post(url, data: {'item': itemId});
    dynamic cartData = jsonDecode(res.data);
    return CartEntity.fromJson(cartData);
  }

  @override
  Future<List<BookingListEntity>> getYourBookings({required int offset}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getBookingListEndPoint(offset: offset);
    Response res = await client.get(url);
    // print(res.data.toString() + "hello");

    dynamic data = jsonDecode(res.data);

    print(data['results'].toString() + "hello");
    List<BookingListEntity> bookings = data['results']
        .map<BookingListEntity>((e) => BookingListEntity.fromJson(e))
        .toList();

    return bookings;
  }

  @override
  Future<AuthTokensEntity> checkOTP(
      {required String otp, required String phoneNumber}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postCheckOTPEndpoint();

    Response res =
        await client.post(url, data: {'otp': otp, 'phone': phoneNumber});

    if (res.statusCode == 400) {
      return AuthTokensEntity(refreshToken: '', accessToken: '');
    } else {
      dynamic data = jsonDecode(res.data);
      return AuthTokensEntity.fromJson(data);
    }
  }

  @override
  Future<SendOTPResponse> sendOTP({required String phoneNumber}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postSendOTPEndpoint();
    Response res = await client.post(url, data: {'phone': phoneNumber});

    if (res.statusCode == 200) {
      return SendOTPResponse(isOTPSent: true);
    } else {
      return SendOTPResponse(isOTPSent: false, message: res.statusMessage);
    }
  }

  Future refreshToken() async {}

  @override
  Future<BookingDetailEntity> getBookingDetail(
      {required String bookingId}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getBookingDetailsEndpoint(bookingId: bookingId);
    Response res = await client.get(url);
    dynamic data = jsonDecode(res.data);
    print(res.data.toString() + "booking");

    BookingDetailEntity entity = BookingDetailEntity.fromJson(data);

    return entity;
  }

  @override
  Future<List<SlotEntity>> createSlots(
      {required String date, required String cartId}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postGetSlotsByCartDateEndpoint();
    Response res = await client.post(url, data: {'cart': cartId, 'date': date});
    List<dynamic> data = jsonDecode(res.data);

    List<SlotEntity> slots =
        data.map<SlotEntity>((e) => SlotEntity.fromJson(e)).toList();
    return slots;
  }

  @override
  Future<InitiatePaymentEntity> initiatePaytmPayment(
      {required String date,
      required int bay,
      required String slotStart,
      required String slotEnd}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postInitiatePaytmPaymentEndpoint();
    Response res = await client.post(url, data: {
      'date': date,
      'bay': bay,
      'slot_start': slotStart,
      'slot_end': slotEnd
    });
    dynamic data = jsonDecode(res.data);
    return InitiatePaymentEntity.fromJson(data);
  }

  @override
  Future<PaytmPaymentResponseEntity> checkPaytmPaymentStatus(
      {required PaytmPaymentResponseEntity paymentResponseEntity}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postCheckPaytmPaymentStatusEndpoint();
    Response res = await client.post(url, data: paymentResponseEntity.toJson());
    dynamic data = jsonDecode(res.data);
    return PaytmPaymentResponseEntity.fromJson(data);
  }
}
