enum NotificationSetting { on, off }

extension NotificationSettingX on NotificationSetting {
  String get label {
    switch (this) {
      case NotificationSetting.on:
        return 'On';
      case NotificationSetting.off:
        return 'Off';
    }
  }

  bool get isEnabled => this == NotificationSetting.on;
}
