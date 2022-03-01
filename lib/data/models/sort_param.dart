abstract class SortParam {
  String toParam();
  String toTitle();
}

class PriceLowToHigh extends SortParam {
  @override
  String toParam() {
    return 'price_l2h';
  }

  @override
  String toTitle() {
    // TODO: implement toTitle
    return 'Price: Low to High';
  }
}

class PriceHighToLow extends SortParam {
  @override
  String toParam() {
    return 'price_h2l';
  }

  @override
  String toTitle() {
    // TODO: implement toTitle
    return 'Price: High to Low';
  }
}

class Distance extends SortParam {
  @override
  String toParam() {
    return 'distance';
  }

  @override
  String toTitle() {
    // TODO: implement toTitle
    return 'Distance';
  }
}
