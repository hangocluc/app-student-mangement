import '../../common/app_shared_preferences/app_shared_preferences.dart';

class ApiHeader {
  final AppSharedPreferences preferences;
  static const Map<String, dynamic> defaultHeader = {
    "Content-type": "application/json"
  };
  static const ACCESS_TOKEN_KEY = "ACCESS_TOKEN_KEY";
  static const REFRESH_TOKEN_KEY = "REFRESH_TOKEN_KEY";
  static const REFRESH_TOKEN_EXPIRED_TIME_KEY =
      "REFRESH_TOKEN_EXPIRED_TIME_KEY";

  ApiHeader({required this.preferences});

  String? getAccessToken() {
    final accessToken = preferences.getString(ACCESS_TOKEN_KEY);
    return accessToken;
  }

  String? getRefreshToken() {
    final refreshToken = preferences.getString(REFRESH_TOKEN_KEY);
    return refreshToken;
  }

  int? getRefreshTokenExpiredTime() {
    final expiredTime = preferences.getInt(REFRESH_TOKEN_EXPIRED_TIME_KEY);
    return expiredTime;
  }

  Future<void> setAccessToken(String value) async {
    await preferences.setString(ACCESS_TOKEN_KEY, value);
  }

  Future<void> setRefreshToken(String value) async {
    await preferences.setString(REFRESH_TOKEN_KEY, value);
  }

  Future<void> setTokenExpiredTime(int value) async {
    await preferences.setInt(REFRESH_TOKEN_EXPIRED_TIME_KEY, value);
  }

  Map<String, dynamic> getAccessTokenHeader() {
    final accessToken = getAccessToken();
    if (getAccessToken() == null) {
      return {};
    }
    return {"Authorization": "Bearer $accessToken"};
  }

  Future<void> clearToken() async {
    await preferences.clear();
  }
}
