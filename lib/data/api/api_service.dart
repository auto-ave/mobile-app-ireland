import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:themotorwash/data/api/api_constants.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/booking.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/review.dart';

class ApiService implements ApiMethods {
  final ApiConstants _apiConstants;
  ApiService({required ApiConstants apiConstants})
      : _apiConstants = apiConstants;

  @override
  Future<StoreEntity> getStoreDetailBySlug({required String slug}) async {
    Dio client = _apiConstants.dioClient;
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
    Dio client = _apiConstants.dioClient;
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
    Dio client = _apiConstants.dioClient;
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
    Dio client = _apiConstants.dioClient;
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
    Dio client = _apiConstants.dioClient;
    String url = _apiConstants.getCartEndpoint();
    Response res = await client.get(url);
    dynamic cartData = jsonDecode(res.data);
    return CartEntity.fromJson(cartData);
  }

  @override
  Future<CartEntity> postAddItemToCart({required int itemId}) async {
    Dio client = _apiConstants.dioClient;
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
    Dio client = _apiConstants.dioClient;
    String url = _apiConstants.postDeleteItemFromCartEndpoint();
    Response res = await client.post(url, data: {'item': itemId});
    dynamic cartData = jsonDecode(res.data);
    return CartEntity.fromJson(cartData);
  }

  @override
  Future<List<BookingEntity>> getYourBookings({required int offset}) async {
    Dio client = _apiConstants.dioClient;
    String url = _apiConstants.getBookingListEndPoint(offset: offset);
    Response res = await client.get(url);
    // print(res.data.toString() + "hello");

    dynamic data = jsonDecode(res.data);

    print(data['results'].toString() + "hello");
    List<BookingEntity> bookings = data['results']
        .map<BookingEntity>((e) => BookingEntity.fromJson(e))
        .toList();

    return bookings;
  }
}
