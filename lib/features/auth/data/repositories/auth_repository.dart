import 'package:homekru_owner/core/network/exceptions/api_exception.dart';
import 'package:homekru_owner/core/storage/auth_storage.dart';
import 'package:homekru_owner/features/auth/data/models/login_request.dart';
import 'package:homekru_owner/features/auth/data/models/signup_request.dart';
import 'package:homekru_owner/features/auth/data/models/user_model.dart';
import 'package:homekru_owner/features/auth/data/services/auth_service.dart';
import 'package:homekru_owner/shared/utils/logger.dart';

class AuthRepository {
  final AuthService _authService;
  final AuthStorage _authStorage;

  AuthRepository(this._authService, this._authStorage);

  Future<UserModel> login(String email, String password) async {
    try {
      if (email.isEmpty) {
        throw ApiException('Email cannot be empty');
      }
      if (password.isEmpty) {
        throw ApiException('Password cannot be empty');
      }

      final request = LoginRequest(email: email, password: password);
      final response = await _authService.login(request);

      await _authStorage.saveToken(response.accessToken);
      if (response.refreshToken != null) {
        await _authStorage.saveRefreshToken(response.refreshToken!);
      }

      return response.user;
    } on ApiException catch (e) {
      Log.e('Login failed', error: e, tag: 'AuthRepository');
      rethrow;
    }
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    String? phone,
  }) async {
    try {
      if (name.isEmpty) {
        throw ApiException('Name cannot be empty');
      }
      if (email.isEmpty) {
        throw ApiException('Email cannot be empty');
      }
      if (password.isEmpty) {
        throw ApiException('Password cannot be empty');
      }
      if (password != confirmPassword) {
        throw ApiException('Passwords do not match');
      }

      final request = SignupRequest(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
      );

      final response = await _authService.signup(request);

      await _authStorage.saveToken(response.accessToken);
      if (response.refreshToken != null) {
        await _authStorage.saveRefreshToken(response.refreshToken!);
      }

      return response.user;
    } on ApiException catch (e) {
      Log.e('Signup failed', error: e, tag: 'AuthRepository');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      await _authStorage.deleteToken();
      await _authStorage.deleteRefreshToken();
    } on ApiException catch (e) {
      Log.e('Logout failed', error: e, tag: 'AuthRepository');
      await _authStorage.deleteToken();
      await _authStorage.deleteRefreshToken();
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final hasToken = await _authStorage.hasToken();
      if (!hasToken) {
        return null;
      }

      return await _authService.getCurrentUser();
    } on ApiException catch (e) {
      Log.e('Get current user failed', error: e, tag: 'AuthRepository');
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    return await _authStorage.hasToken();
  }
}
