import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/location_model.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/service.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/models/vehicle_type.dart';

abstract class Repository {
  Future<List<StoreListModel>> getStoreListByLocation(
      {required LocationModel locationModel, required int offset});
  Future<Store> getStoreDetailBySlug({required String slug});
  Future<List<Review>> getStoreReviewsBySlug(
      {required String slug, required int offset});
  Future<List<PriceTimeListModel>> getStoreServicesBySlugAndVehicleType(
      {required String slug, required String vehicleType, required int offset});

  Future<CartModel> postAddItemToCart({required int itemId});

  Future<CartModel> postDeleteItemFromCart({required int itemId});

  Future<CartModel> getCart();

  Future<List<BookingListModel>> getYourBookings({required int offset});
  Future<BookingDetailModel> getBookingDetail({required String bookingId});
  Future<List<Slot>> createSlots(
      {required String date, required String cartId});

  Future<List<VehicleTypeModel>> getVehicleTypeList();

  Future<List<StoreListModel>> searchStores(
      {required String query,
      required LocationModel locationModel,
      required int offset});

  Future<List<ServiceModel>> searchServices(
      {required String query, required int offset});

  Future<Review> getReview({required String bookingId});
  Future<Review> addReview({required ReviewEntity review});
}
