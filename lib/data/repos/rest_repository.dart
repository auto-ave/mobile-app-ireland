import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/repos/repository.dart';

class RestRepository implements Repository {
  ApiMethods _apiMethodsImp;
  RestRepository({required ApiMethods apiMethodsImp})
      : _apiMethodsImp = apiMethodsImp;
  @override
  Future<Store> getStoreDetailBySlug({required String slug}) async {
    StoreEntity entity = await _apiMethodsImp.getStoreDetailBySlug(slug: slug);
    return Store.fromEntity(entity);
  }

  @override
  Future<List<StoreListModel>> getStoreListByCity(
      {required String city, required int offset}) async {
    List<StoreListEntity> entities =
        await _apiMethodsImp.getStoreListByCity(city: city, offset: offset);
    List<StoreListModel> stores =
        entities.map((e) => StoreListModel.fromEntity(e)).toList();
    return stores;
  }

  @override
  Future<List<Review>> getStoreReviewsBySlug(
      {required String slug, required int offset}) async {
    List<ReviewEntity> entities =
        await _apiMethodsImp.getStoreReviewsBySlug(slug: slug, offset: offset);
    List<Review> reviews = entities.map((e) => Review.fromEntity(e)).toList();
    return reviews;
  }

  @override
  Future<List<PriceTimeListModel>> getStoreServicesBySlugAndVehicleType(
      {required String slug,
      required int vehicleType,
      required int offset}) async {
    List<PriceTimeListEntity> entities =
        await _apiMethodsImp.getStoreServicesBySlugAndVehicleType(
            slug: slug, vehicleType: vehicleType, offset: offset);
    List<PriceTimeListModel> services =
        entities.map((e) => PriceTimeListModel.fromEntity(e)).toList();
    return services;
  }

  @override
  Future<CartModel> getCart() async {
    CartEntity entity = await _apiMethodsImp.getCart();
    return CartModel.fromEntity(entity);
  }

  @override
  Future<CartModel> postAddItemToCart({required int itemId}) async {
    CartEntity entity = await _apiMethodsImp.postAddItemToCart(itemId: itemId);
    return CartModel.fromEntity(entity);
  }

  @override
  Future<CartModel> postDeleteItemFromCart({required int itemId}) async {
    CartEntity entity =
        await _apiMethodsImp.postDeleteItemFromCart(itemId: itemId);
    return CartModel.fromEntity(entity);
  }

  @override
  Future<List<BookingListModel>> getYourBookings({required int offset}) async {
    List<BookingListEntity> entity =
        await _apiMethodsImp.getYourBookings(offset: offset);
    print(entity.toString() + "entity");
    List<BookingListModel> bookings =
        entity.map((e) => BookingListModel.fromEntity(e)).toList();
    return bookings;
  }

  @override
  Future<BookingDetailModel> getBookingDetail(
      {required String bookingId}) async {
    BookingDetailEntity e =
        await _apiMethodsImp.getBookingDetail(bookingId: bookingId);

    return BookingDetailModel.fromEntity(e);
  }

  @override
  Future<List<Slot>> createSlots(
      {required String date, required String cartId}) async {
    List<SlotEntity> entities =
        await _apiMethodsImp.createSlots(date: date, cartId: cartId);
    List<Slot> slots = entities.map<Slot>((e) => Slot.fromEntity(e)).toList();
    return slots;
  }

  @override
  Future<InitiatePaymentModel> initiatePaytmPayment(
      {required String date,
      required int bay,
      required String slotStart,
      required String slotEnd}) async {
    InitiatePaymentEntity e = await _apiMethodsImp.initiatePaytmPayment(
        date: date, bay: bay, slotStart: slotStart, slotEnd: slotEnd);
    return InitiatePaymentModel.fromEntity(e);
  }
}
