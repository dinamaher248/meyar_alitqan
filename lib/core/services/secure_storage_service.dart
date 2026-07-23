import 'package:injectable/injectable.dart';
import '../cache/shared_preferences.dart';

@singleton
class SecureStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';

  Future<void> saveAuthData({
    required String accessToken,
    String? refreshToken,
    required String userId,
  }) async {
    await SharedPrefHelper.setString(_accessTokenKey, accessToken);

    if (refreshToken != null && refreshToken.isNotEmpty) {
      await SharedPrefHelper.setString(_refreshTokenKey, refreshToken);
    }

    await SharedPrefHelper.setString(_userIdKey, userId);
  }


  Future<String?> getAccessToken() async {
    return SharedPrefHelper.getString(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return SharedPrefHelper.getString(_refreshTokenKey);
  }

  Future<String?> getUserId() async {
    return SharedPrefHelper.getString(_userIdKey);
  }

  Future<void> clear() async {
    await SharedPrefHelper.clear();
  }
}
