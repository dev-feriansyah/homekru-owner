import 'package:flutter/foundation.dart';
import 'package:homekru_owner/core/flavors/flavors.dart';

class ApiConfig {
  ApiConfig._();

  static String get baseUrl {
    switch (AppFlavor.appFlavor) {
      case Flavor.dev:
        return 'https://api-dev.homekru.com';
      case Flavor.prod:
        return 'https://api.homekru.com';
    }
  }

  static Duration get connectTimeout => const Duration(seconds: 30);

  static Duration get receiveTimeout => const Duration(seconds: 30);

  static bool get enableApiLogging => kDebugMode;

  static String get apiVersion => 'v1';

  static String get fullBaseUrl => '$baseUrl/api/$apiVersion';
}
