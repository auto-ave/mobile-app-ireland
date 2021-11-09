import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:themotorwash/data/api/api_constants.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/city.dart';
import 'package:themotorwash/data/models/fcm_topic.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';
import 'package:themotorwash/data/models/service.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/user_profile.dart';
import 'package:themotorwash/data/models/vehicle_brand.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
import 'package:themotorwash/data/models/vehicle_wheel.dart';

class ApiService implements ApiMethods {
  static final getItInstanceName = 'ApiService';
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
  Future<List<StoreListEntity>> getStoreListByLocation(
      {required String city,
      required double lat,
      required double long,
      required int offset}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getStoreListByLocationEndPoint(
        city: city, lat: lat, long: long, offset: offset);

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
    print(data.toString() + "hell");
    List<ReviewEntity> reviews = data['results']
        .map<ReviewEntity>((e) => ReviewEntity.fromJson(e))
        .toList();
    return reviews;
  }

  @override
  Future<List<PriceTimeListEntity>> getStoreServicesBySlugAndVehicleType(
      {required String slug,
      required String vehicleType,
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
  Future<CartEntity> postAddItemToCart(
      {required int itemId, required String vehicleModel}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postAddItemToCartEndpoint();

    Response res = await client.post(
      url,
      data: {'item': itemId, 'vehicle_model': vehicleModel},
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
      {required String otp,
      required String phoneNumber,
      required String token}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postCheckOTPEndpoint();

    Response res = await client
        .post(url, data: {'otp': otp, 'phone': phoneNumber, 'token': token});

    print("CHECK OTP " + token);

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
    // var logger = Logger();
    // logger.d("hello" + res.data.toString().substring(400) + "booking");

    BookingDetailEntity entity = BookingDetailEntity.fromJson(data);

    return entity;
  }

  @override
  Future<List<SlotEntity>> createSlots(
      {required String date, required String cartId}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postGetSlotsByCartDateEndpoint();
    Response res = await client.post(url, data: {'date': date});
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
    print({
      'date': date,
      'bay': bay,
      'slot_start': slotStart,
      'slot_end': slotEnd
    }.toString());
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
    print(res.toString() + "response");
    dynamic data = jsonDecode(res.data);
    return PaytmPaymentResponseEntity.fromJson(data);
  }

  @override
  Future<List<VehicleModelEntity>> getVehicleTypeList() async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getVehicleTypeListEndpoint();
    Response res = await client.get(url);
    dynamic data = jsonDecode(res.data);
    List<VehicleModelEntity> entities = data['results']
        .map<VehicleModelEntity>((e) => VehicleModelEntity.fromJson(e))
        .toList();

    return entities;
  }

  @override
  Future<List<ServiceEntity>> searchServices(
      {required String query, required int offset, int? pageLimit}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getServicesBySearchQueryEndPoint(
        query: query, offset: offset, pageLim: pageLimit);
    Response res = await client.get(url);

    dynamic data = jsonDecode(res.data);

    // print(data.toString() + "hello");
    List<ServiceEntity> services = data['results']
        .map<ServiceEntity>((e) => ServiceEntity.fromJson(e))
        .toList();

    return services;
  }

  @override
  Future<List<StoreListEntity>> searchStores(
      {required String query,
      required String city,
      required double lat,
      required double long,
      required int offset}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getStoresBySearchQueryAndLocationEndPoint(
        query: query, city: city, lat: lat, long: long, offset: offset);

    Response res = await client.get(url);

    print(res.data.toString() + 'hell');
    Map<dynamic, dynamic> data = jsonDecode(res.data);
    List<StoreListEntity> stores = data['results']
        .map<StoreListEntity>((e) => StoreListEntity.fromJson(e))
        .toList();
    return stores;
  }

  @override
  Future<ReviewEntity> addReview({required ReviewEntity review}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.postReviewEndPoint();
    print("helloreview");

    print("helloreview" + review.toJson().toString());

    Response res = await client.post(url, data: review.toJson());
    print(res.data.toString() + "hello");
    dynamic data = jsonDecode(res.data);
    ReviewEntity reviewEntity = ReviewEntity.fromJson(data);
    return reviewEntity;
  }

  @override
  Future<ReviewEntity> getReview({required String bookingId}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getReviewEndPoint(bookingId: bookingId);
    Response res = await client.get(url);
    dynamic data = jsonDecode(res.data);
    ReviewEntity review = ReviewEntity.fromJson(data);
    return review;
  }

  @override
  Future<UserProfileEntity> getAccountDetails() async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getPutPatchAccountEndPoint();

    Response res = await client.get(url);

    dynamic data = jsonDecode(res.data);

    UserProfileEntity entity = UserProfileEntity.fromJson(data);
    return entity;
  }

  @override
  Future<UserProfileEntity> patchAccountDetails(
      {required UserProfileEntity userProfileEntity}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getPutPatchAccountEndPoint();

    Response res = await client.patch(url, data: userProfileEntity.toJson());

    dynamic data = jsonDecode(res.data);

    UserProfileEntity entity = UserProfileEntity.fromJson(data);
    return entity;
  }

  @override
  Future<void> addFcmToken({required String token}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.addFcmTokenEndpoint();
    Response res = await client.post(url, data: {'token': token});
  }

  @override
  Future<void> subscribeFcmTopics({required List<String> topics}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.subscribeFcmTopicsEndpoint();
    Response res = await client.post(url, data: {'topics': topics});
  }

  @override
  Future<List<FcmTopicEntity>> getFcmTopics() async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getFcmTopicsEndpoint();
    Response res = await client.get(url);
    List<dynamic> data = jsonDecode(res.data);

    List<FcmTopicEntity> topics =
        data.map<FcmTopicEntity>((e) => FcmTopicEntity.fromJson(e)).toList();
    return topics;
  }

  @override
  Future<void> logout({required String token}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getLogoutEndpoint();
    Response res = await client.post(url, data: {'token': token});
  }

  @override
  Future<List<CityEntity>> getListOfCities() async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getCityListEndpoint();
    Response res = await client.get(url);
    dynamic data = jsonDecode(res.data);
    List<dynamic> cityData = data['cities'];

    List<CityEntity> entities =
        cityData.map<CityEntity>((e) => CityEntity.fromJson(e)).toList();

    return entities;
  }

  @override
  Future<void> sendFeedback(
      {required String email,
      required String phoneNumber,
      required String message}) async {
    Dio client = _apiConstants.dioClient();
    String url = _apiConstants.getFeedbackEndpoint();
    Response res = await client.post(url,
        data: {'phone': phoneNumber, 'email': email, 'message': message});
  }

  @override
  Future<List<VehicleWheelEntity>> getVehicleWheelList() async {
    String url = _apiConstants.getVehicleWheelListEndpoint();
    Dio client = _apiConstants.dioClient();
    Response res = await client.get(url);

    Map<dynamic, dynamic> data = jsonDecode(res.data);
    List<VehicleWheelEntity> vehicleWheels = data['results']
        .map<VehicleWheelEntity>((e) => VehicleWheelEntity.fromJson(e))
        .toList();
    return vehicleWheels;
  }

  @override
  Future<List<VehicleBrandEntity>> getVehicleBrandlList(
      {required String wheelCode}) async {
    String url =
        _apiConstants.getVehicleBrandListEndpoint(wheelCode: wheelCode);
    Dio client = _apiConstants.dioClient();
    Response res = await client.get(url);

    Map<dynamic, dynamic> data = jsonDecode(res.data);
    List<VehicleBrandEntity> vehicleBrands = data['results']
        .map<VehicleBrandEntity>((e) => VehicleBrandEntity.fromJson(e))
        .toList();
    return vehicleBrands;
  }

  @override
  Future<List<VehicleModelEntity>> getVehicleModelList(
      {required String brand}) async {
    String url = _apiConstants.getVehicleModelListEndpoint(brand: brand);
    Dio client = _apiConstants.dioClient();
    Response res = await client.get(url);

    Map<dynamic, dynamic> data = jsonDecode(res.data);
    List<VehicleModelEntity> vehicleModels = data['results']
        .map<VehicleModelEntity>((e) => VehicleModelEntity.fromJson(e))
        .toList();
    return vehicleModels;
  }
}
