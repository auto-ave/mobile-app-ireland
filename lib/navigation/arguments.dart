import 'package:themotorwash/blocs/offer_apply/bloc/offer_apply_bloc.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/multi_day_slot.dart';
import 'package:themotorwash/data/models/multi_day_slot_detail.dart';
import 'package:themotorwash/data/models/slot.dart';

class StoreDetailArguments {
  final String storeSlug;
  StoreDetailArguments({required this.storeSlug});
}

class StoreListArguments {
  final String city;
  final String title;
  final String? serviceTag;
  StoreListArguments(
      {required this.city, required this.title, this.serviceTag});
}

class BookingSummaryScreenArguments {
  final bool isTransactionSuccesful;
  final String bookingId;
  BookingSummaryScreenArguments(
      {required this.bookingId, required this.isTransactionSuccesful});
}

class SlotSelectScreenArguments {
  final String cartTotal;
  final String cardId;
  final bool isMultiDay;
  SlotSelectScreenArguments(
      {required this.cartTotal,
      required this.cardId,
      required this.isMultiDay});
}

class VerifyPhoneScreenArguments {
  final String phoneNumber;
  VerifyPhoneScreenArguments({
    required this.phoneNumber,
  });
}

class OrderReviewScreenArguments {
  final DateTime dateSelected;
  final bool isMultiDay;
  OrderReviewScreenArguments({
    required this.dateSelected,
    required this.isMultiDay,
  });
}

class BookingDetailScreenArguments {
  final BookingStatus status;
  final String bookingId;
  BookingDetailScreenArguments({
    required this.status,
    required this.bookingId,
  });
}

class ProfileScreenArguments {
  final bool showSkip;
  ProfileScreenArguments({
    required this.showSkip,
  });
}

class FeedbackScreenArguments {
  final bool isFeedback;
  final String? orderNumber;
  FeedbackScreenArguments({
    required this.isFeedback,
    this.orderNumber,
  });
}

class PaymentChoiceScreenArguments {
  final Slot? slot;
  final MultiDaySlot? multiDaySlot;
  final DateTime dateSelected;
  PaymentChoiceScreenArguments(
      {this.slot, required this.dateSelected, this.multiDaySlot});
}

class CancelOrderScreenArguments {
  final String bookingId;
  CancelOrderScreenArguments({
    required this.bookingId,
  });
}

class YourBookingsScreenArguments {
  final bool fromBookingSummary;
  YourBookingsScreenArguments({
    required this.fromBookingSummary,
  });
}

class StoreGalleryViewArguments {
  final List<String> images;
  StoreGalleryViewArguments({
    required this.images,
  });
}

class OfferSelectionScreenArgs {
  final OfferApplyBloc offerApplyBloc;
  OfferSelectionScreenArgs({
    required this.offerApplyBloc,
  });
}

class MultiDaySlotSelectScreenArgs {
  final String cartTotal;
  final String cartId;
  MultiDaySlotSelectScreenArgs({
    required this.cartTotal,
    required this.cartId,
  });
}
