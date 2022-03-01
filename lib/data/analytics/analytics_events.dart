abstract class AnalyticsEvent {
  String eventName();
}

class DynamicLinkOpen extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Dynamic Link Open';
  }
}

class SearchClick extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Search Click';
  }
}

class SearchServiceClick extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Search Service Click';
  }
}

class SearchStoreClick extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Search Store Click';
  }
}

class BannerClick extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Banner Click';
  }
}

class LogOutAnalytics extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Logout';
  }
}

class LoggedInAnalytics extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Login';
  }
}

class SkipLoginAnalytics extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Skip Login';
  }
}

class ExploreServiceTileClick extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Explore Service Tile Click';
  }
}

class ExploreStoreTileClick extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Explore Store Tile Click';
  }
}

class SkipLocationAnalytics extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Skip Location';
  }
}

class BookingSuccessEvent extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Booking Success';
  }
}

class BookingFailedEvent extends AnalyticsEvent {
  @override
  String eventName() {
    return 'Booking Failed';
  }
}
