import 'package:themotorwash/data/models/booking.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/store_list_model.dart';

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

  Future<List<BookingEntity>> getYourBookings({required int offset});
}
