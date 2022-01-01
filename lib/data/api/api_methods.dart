import 'package:dio/dio.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/data/models/cancel_booking_data.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/city.dart';
import 'package:themotorwash/data/models/fcm_topic.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/payment_choice.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';
import 'package:themotorwash/data/models/service.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';
import 'package:themotorwash/data/models/user_profile.dart';
import 'package:themotorwash/data/models/vehicle_brand.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
import 'package:themotorwash/data/models/vehicle_wheel.dart';

abstract class ApiMethods {
  CancelToken get getSlotsCancelToken;
  set getSlotsCancelToken(CancelToken createSlotsCancelToken);
  Future<List<StoreListEntity>> getStoreListByLocation(
      {required String city,
      required double lat,
      required double long,
      required int offset});
  Future<StoreEntity> getStoreDetailBySlug({required String slug});
  Future<List<ReviewEntity>> getStoreReviewsBySlug(
      {required String slug, required int offset});
  Future<List<PriceTimeListEntity>> getStoreServicesBySlugAndVehicleType(
      {required String slug, required String vehicleType, required int offset});

  Future<CartEntity> postAddItemToCart(
      {required int itemId, required String vehicleModel});

  Future<CartEntity> postDeleteItemFromCart({required int itemId});

  Future<CartEntity> getCart();

  Future<List<BookingListEntity>> getYourBookings({required int offset});

  Future<BookingDetailEntity> getBookingDetail({required String bookingId});

  Future<AuthTokensEntity> checkOTP(
      {required String otp,
      required String phoneNumber,
      required String token});
  Future<SendOTPResponse> sendOTP({required String phoneNumber});

  Future<List<SlotEntity>> createSlots(
      {required String date, required String cartId});

  Future<InitiatePaymentEntity> initiatePaytmPayment(
      {required String date,
      required int bay,
      required String slotStart,
      required String slotEnd});
  Future<PaytmPaymentResponseEntity> checkPaytmPaymentStatus(
      {required PaytmPaymentResponseEntity paymentResponseEntity});
  Future<List<VehicleModelEntity>> getVehicleTypeList();
  Future<List<StoreListEntity>> searchStores(
      {required String query,
      required String city,
      required double lat,
      required double long,
      required int offset});

  Future<List<ServiceEntity>> searchServices(
      {required String query, required int offset, int? pageLimit});

  Future<ReviewEntity> addReview({required ReviewEntity review});
  Future<ReviewEntity> getReview({required String bookingId});

  Future<UserProfileEntity> getAccountDetails();
  Future<UserProfileEntity> patchAccountDetails(
      {required UserProfileEntity userProfileEntity});

  Future<void> subscribeFcmTopics({required List<String> topics});

  Future<void> addFcmToken({required String token});

  Future<List<FcmTopicEntity>> getFcmTopics();
  Future<void> logout({required String token});
  Future<List<CityEntity>> getListOfCities();

  Future<void> sendFeedback(
      {required String email,
      required String phoneNumber,
      required String message});
  Future<List<VehicleWheelEntity>> getVehicleWheelList();
  Future<List<VehicleBrandEntity>> getVehicleBrandlList(
      {required String wheelCode});

  Future<List<VehicleModelEntity>> getVehicleModelList({required String brand});
  Future<List<PaymentChoiceEntity>> getPaymentChoices();
  Future<CancelBookingDataEntity> getCancelBookingData(
      {required String bookingId});
  Future<void> cancelBooking(
      {required String bookingId, required String reason});
}
