enum DateRange { today, thisWeek, thisMonth, lastMonth, custom }

extension DateRangeX on DateRange {
  String get label {
    switch (this) {
      case DateRange.today:
        return 'Today';
      case DateRange.thisWeek:
        return 'This Week';
      case DateRange.thisMonth:
        return 'This Month';
      case DateRange.lastMonth:
        return 'Last Month';
      case DateRange.custom:
        return 'Custom';
    }
  }
}
