// lib/services/token_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

/// A utility class for managing the authentication token in SharedPreferences.
class TokenManager {
  static const String _tokenKey = 'auth_token';

  /// Saves the provided token to SharedPreferences.
  ///
  /// [token]: The authentication token to be saved.
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    print('Token saved: $token'); // For debugging
  }

  /// Retrieves the authentication token from SharedPreferences.
  ///
  /// Returns the token string if found, otherwise returns null.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print('Token retrieved: $token'); // For debugging
    return token;
  }

  /// Deletes the authentication token from SharedPreferences.
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    print('Token deleted.'); // For debugging
  }
}
