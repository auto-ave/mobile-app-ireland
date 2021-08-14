import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';

abstract class ApiMethods {
  Future<List<StoreListEntity>> getStoreListByCity(
      {required String city, required int offset});
  Future<StoreEntity> getStoreDetailBySlug({required String slug});
  Future<List<ReviewEntity>> getStoreReviewsBySlug(
      {required String slug, required int offset});
  Future<List<PriceTimeListEntity>> getStoreServicesBySlugAndVehicleType(
      {required String slug, required int vehicleType, required int offset});

  Future<CartEntity> postAddItemToCart({required int itemId});

  Future<CartEntity> postDeleteItemFromCart({required int itemId});

  Future<CartEntity> getCart();

  Future<List<BookingListEntity>> getYourBookings({required int offset});

  Future<BookingDetailEntity> getBookingDetail({required String bookingId});

  Future<AuthTokensEntity> checkOTP(
      {required String otp, required String phoneNumber});
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
}
