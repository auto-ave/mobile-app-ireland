class StoreDetailArguments {
  final String storeSlug;
  StoreDetailArguments({required this.storeSlug});
}

class StoreListArguments {
  final String city;
  StoreListArguments({required this.city});
}

class BookingSummaryScreenArguments {
  final String bookingId;
  BookingSummaryScreenArguments({
    required this.bookingId,
  });
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
