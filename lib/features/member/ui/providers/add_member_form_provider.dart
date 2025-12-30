import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_member_form_provider.g.dart';

@riverpod
class AddMemberForm extends _$AddMemberForm {
  @override
  AddMemberFormState build() {
    return const AddMemberFormState();
  }

  // Basic info
  void setName(String value) {
    state = state.copyWith(name: value.trim());
  }

  void setPhone(String value) {
    state = state.copyWith(phone: value.trim());
  }

  void setRole(String value) {
    state = state.copyWith(role: value.trim());
  }

  // Live-in
  void setLiveInStatus(LiveInStatus? status) {
    state = state.copyWith(liveInStatus: status);
  }

  // Day off
  void toggleEntitledForDayOff(bool value) {
    state = state.copyWith(
      entitledForDayOff: value,
      checkInOutFrequency: value ? state.checkInOutFrequency : null,
    );
  }

  void setCheckInOutFrequency(CheckInOutFrequency? frequency) {
    state = state.copyWith(checkInOutFrequency: frequency);
  }

  // GPS
  void toggleGpsBasedCheckIn(bool value) {
    state = state.copyWith(gpsBasedCheckIn: value);
  }

  // Overtime
  void toggleEligibleForOvertime(bool value) {
    state = state.copyWith(
      eligibleForOvertime: value,
      trackOvertimeBasedOnCheckout: false,
      overtimeRate: '',
    );
  }

  void toggleTrackOvertimeBasedOnCheckout(bool value) {
    state = state.copyWith(trackOvertimeBasedOnCheckout: value);
  }

  void setOvertimeRate(String value) {
    state = state.copyWith(overtimeRate: value);
  }

  void setDowntimePreference(String value) {
    state = state.copyWith(downtimePreference: value);
  }

  void toggleDeductionSettings(bool value) {
    state = state.copyWith(deductionSettings: value);
  }

  void setDeductionRate(String value) {
    state = state.copyWith(deductionRate: value);
  }

  // Submit
  Future<void> submit() async {
    if (!state.isFormValid) return;

    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      // call API
    } finally {
      state = const AddMemberFormState(); // reset after success
    }
  }
}

enum LiveInStatus { liveIn, nonLiveIn }

enum CheckInOutFrequency { daily, weekly, custom }

class AddMemberFormState {
  final String name;
  final String phone;
  final String role;

  final LiveInStatus? liveInStatus;
  final CheckInOutFrequency? checkInOutFrequency;

  final bool gpsBasedCheckIn;
  final bool entitledForDayOff;
  final bool deductionSettings;

  final bool eligibleForOvertime;
  final bool trackOvertimeBasedOnCheckout;
  final String downtimePreference;
  final String overtimeRate;
  final String deductionRate;

  final bool isLoading;

  const AddMemberFormState({
    this.name = '',
    this.phone = '',
    this.role = '',
    this.liveInStatus,
    this.checkInOutFrequency,
    this.gpsBasedCheckIn = false,
    this.entitledForDayOff = true,
    this.deductionSettings = true,
    this.eligibleForOvertime = false,
    this.trackOvertimeBasedOnCheckout = false,
    this.downtimePreference = '',
    this.overtimeRate = '',
    this.deductionRate = '',
    this.isLoading = false,
  });

  bool get isFormValid =>
      name.isNotEmpty &&
      phone.isNotEmpty &&
      role.isNotEmpty &&
      liveInStatus != null;

  AddMemberFormState copyWith({
    String? name,
    String? phone,
    String? role,
    LiveInStatus? liveInStatus,
    CheckInOutFrequency? checkInOutFrequency,
    bool? gpsBasedCheckIn,
    bool? entitledForDayOff,
    bool? deductionSettings,
    bool? eligibleForOvertime,
    bool? trackOvertimeBasedOnCheckout,
    String? downtimePreference,
    String? overtimeRate,
    String? deductionRate,
    bool? isLoading,
  }) {
    return AddMemberFormState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      liveInStatus: liveInStatus ?? this.liveInStatus,
      checkInOutFrequency: checkInOutFrequency ?? this.checkInOutFrequency,
      gpsBasedCheckIn: gpsBasedCheckIn ?? this.gpsBasedCheckIn,
      entitledForDayOff: entitledForDayOff ?? this.entitledForDayOff,
      deductionSettings: deductionSettings ?? this.deductionSettings,
      eligibleForOvertime: eligibleForOvertime ?? this.eligibleForOvertime,
      trackOvertimeBasedOnCheckout:
          trackOvertimeBasedOnCheckout ?? this.trackOvertimeBasedOnCheckout,
      downtimePreference: downtimePreference ?? this.downtimePreference,
      overtimeRate: overtimeRate ?? this.overtimeRate,
      deductionRate: deductionRate ?? this.deductionRate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
