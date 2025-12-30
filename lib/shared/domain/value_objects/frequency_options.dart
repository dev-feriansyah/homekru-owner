enum FrequencyOptions { daily, weekly, biWeekly, monthly }

extension FrequencyOptionsX on FrequencyOptions {
  String get label {
    switch (this) {
      case FrequencyOptions.daily:
        return 'Daily';
      case FrequencyOptions.weekly:
        return 'Weekly';
      case FrequencyOptions.biWeekly:
        return 'Bi-weekly';
      case FrequencyOptions.monthly:
        return 'Monthly';
    }
  }
}
