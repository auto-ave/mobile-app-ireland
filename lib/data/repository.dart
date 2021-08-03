import 'package:themotorwash/data/models/booking.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/store_list_model.dart';

abstract class Repository {
  Future<List<StoreListModel>> getStoreListByCity(
      {required String city, required int offset});
  Future<Store> getStoreDetailBySlug({required String slug});
  Future<List<Review>> getStoreReviewsBySlug(
      {required String slug, required int offset});
  Future<List<PriceTimeListModel>> getStoreServicesBySlugAndVehicleType(
      {required String slug, required int vehicleType, required int offset});

  Future<CartModel> postAddItemToCart({required int itemId});

  Future<CartModel> postDeleteItemFromCart({required int itemId});

  Future<CartModel> getCart();

  Future<List<BookingModel>> getYourBookings({required int offset});
}
