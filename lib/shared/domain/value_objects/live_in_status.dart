enum LiveInStatus { liveIn, nonLiveIn }

extension LiveInStatusX on LiveInStatus {
  String get label {
    switch (this) {
      case LiveInStatus.liveIn:
        return 'Live-in';
      case LiveInStatus.nonLiveIn:
        return 'Non Live-in';
    }
  }
}
