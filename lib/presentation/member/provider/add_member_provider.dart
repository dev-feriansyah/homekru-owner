import 'package:flutter/material.dart';
import 'package:homekru_owner/core/routes/app_navigator.dart';

enum LiveInStatus { liveIn, nonLiveIn }

enum CheckInOutFrequency { daily, weekly, custom }

class AddMemberProvider extends ChangeNotifier {
  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController setupProfileController = TextEditingController();

  // Live-in status selection
  LiveInStatus? _selectedLiveInStatus;

  // Helper settings
  CheckInOutFrequency? _checkInOutFrequency;
  bool _gpsBasedCheckIn = false;
  bool _entitledForDayOff = true;
  bool _deductionSettings = true;

  // Non live-in helper specific settings
  bool _eligibleForOvertime = false;
  bool _trackOvertimeBasedOnCheckout = false;
  String _downtimePreference = '';
  String _overtimeRate = '';
  List<String> _frequencyOptions = ['Daily', 'Weekly', 'Bi-weekly', 'Monthly'];
  // Form validation
  bool _isFormValid = false;

  // Loading state
  bool _isLoading = false;

  // Getters
  LiveInStatus? get selectedLiveInStatus => _selectedLiveInStatus;
  CheckInOutFrequency? get checkInOutFrequency => _checkInOutFrequency;
  bool get gpsBasedCheckIn => _gpsBasedCheckIn;
  bool get entitledForDayOff => _entitledForDayOff;
  bool get deductionSettings => _deductionSettings;
  bool get eligibleForOvertime => _eligibleForOvertime;
  bool get trackOvertimeBasedOnCheckout => _trackOvertimeBasedOnCheckout;
  String get downtimePreference => _downtimePreference;
  String get overtimeRate => _overtimeRate;
  bool get isFormValid => _isFormValid;
  bool get isLoading => _isLoading;
  List<String> get frequencyOptions => _frequencyOptions;

  // Set live-in status
  void setLiveInStatus(LiveInStatus? status) {
    _selectedLiveInStatus = status;
    _validateForm();
    notifyListeners();
  }

  // Set frequency options
  void setFrequencyOptions(List<String> options) {
    _frequencyOptions = options;
    notifyListeners();
  }

  // Set check-in/out frequency
  void setCheckInOutFrequency(CheckInOutFrequency? frequency) {
    _checkInOutFrequency = frequency;
    notifyListeners();
  }

  // Toggle GPS-based check-in
  void toggleGpsBasedCheckIn(bool value) {
    _gpsBasedCheckIn = value;
    notifyListeners();
  }

  // Toggle entitled for day off
  void toggleEntitledForDayOff(bool value) {
    _entitledForDayOff = value;
    // Clear frequency selection when day off is disabled
    if (!value) {
      _checkInOutFrequency = null;
    }
    notifyListeners();
  }

  // Toggle deduction settings
  void toggleDeductionSettings(bool value) {
    _deductionSettings = value;
    notifyListeners();
  }

  // Toggle eligible for overtime
  void toggleEligibleForOvertime(bool value) {
    _eligibleForOvertime = value;
    // Clear overtime-related settings when disabled
    if (!value) {
      _trackOvertimeBasedOnCheckout = false;
      _overtimeRate = '';
    }
    notifyListeners();
  }

  // Toggle track overtime based on checkout
  void toggleTrackOvertimeBasedOnCheckout(bool value) {
    _trackOvertimeBasedOnCheckout = value;
    notifyListeners();
  }

  // Set downtime preference
  void setDowntimePreference(String value) {
    _downtimePreference = value;
    notifyListeners();
  }

  // Set overtime rate
  void setOvertimeRate(String value) {
    _overtimeRate = value;
    notifyListeners();
  }

  // Set loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Validate form
  void _validateForm() {
    _isFormValid =
        nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        roleController.text.trim().isNotEmpty &&
        _selectedLiveInStatus != null;
  }

  // Add listener to text controllers for real-time validation
  void initializeControllers() {
    nameController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    roleController.addListener(_validateForm);
  }

  // Submit form
  Future<void> submitForm() async {
    if (!_isFormValid) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      clearForm();
      AppNavigator.pop();
      AppNavigator.pop();
    } catch (error) {
      // Handle error silently or use proper logging
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear form
  void clearForm() {
    nameController.clear();
    phoneController.clear();
    roleController.clear();
    setupProfileController.clear();
    _selectedLiveInStatus = null;
    _checkInOutFrequency = null;
    _gpsBasedCheckIn = false;
    _entitledForDayOff = false;
    _deductionSettings = false;
    _eligibleForOvertime = false;
    _trackOvertimeBasedOnCheckout = false;
    _downtimePreference = '';
    _overtimeRate = '';
    _isFormValid = false;
    notifyListeners();
  }

  // Get display text for live-in status
  String getLiveInStatusText(LiveInStatus status) {
    switch (status) {
      case LiveInStatus.liveIn:
        return 'Live-in Helper';
      case LiveInStatus.nonLiveIn:
        return 'Non Live-in Helper';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    roleController.dispose();
    setupProfileController.dispose();
    super.dispose();
  }
}
