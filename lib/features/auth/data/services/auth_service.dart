import 'package:homekru_owner/core/network/api_client.dart';
import 'package:homekru_owner/features/auth/data/models/login_request.dart';
import 'package:homekru_owner/features/auth/data/models/login_response.dart';
import 'package:homekru_owner/features/auth/data/models/signup_request.dart';
import 'package:homekru_owner/features/auth/data/models/user_model.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    return await _apiClient.post<LoginResponse>(
      '/auth/login',
      data: request.toJson(),
      requiresAuth: false,
      fromJson: (data) => LoginResponse.fromJson(data),
    );
  }

  Future<LoginResponse> signup(SignupRequest request) async {
    return await _apiClient.post<LoginResponse>(
      '/auth/signup',
      data: request.toJson(),
      requiresAuth: false,
      fromJson: (data) => LoginResponse.fromJson(data),
    );
  }

  Future<void> logout() async {
    await _apiClient.post(
      '/auth/logout',
      requiresAuth: true,
    );
  }

  Future<UserModel> getCurrentUser() async {
    return await _apiClient.get<UserModel>(
      '/auth/me',
      requiresAuth: true,
      fromJson: (data) => UserModel.fromJson(data),
    );
  }
}
