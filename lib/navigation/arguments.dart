import 'package:themotorwash/data/models/booking_detail.dart';

class StoreDetailArguments {
  final String storeSlug;
  StoreDetailArguments({required this.storeSlug});
}

class StoreListArguments {
  final String city;
  final String title;
  StoreListArguments({
    required this.city,
    required this.title,
  });
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
  SlotSelectScreenArguments({required this.cartTotal, required this.cardId});
}

class VerifyPhoneScreenArguments {
  final String phoneNumber;
  VerifyPhoneScreenArguments({
    required this.phoneNumber,
  });
}

class OrderReviewScreenArguments {
  final DateTime dateSelected;
  OrderReviewScreenArguments({
    required this.dateSelected,
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
