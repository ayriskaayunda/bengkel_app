import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _tokenKey =
      'auth_token'; // kelas ini tidak di mengggunakan extends karna hanya sebagai utility
  // tokenkey untuk untuk  menyimpan token ke dalam sharedPreferences

  // ini untuk menyimpan token login pengguna ke dalam perangkat dan user tidak perlu login ulang setiap buka app
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    print('Token saved: $token');
  }

  /// ini untuk mengambil token yang sudah di simpan sebelumnya
  ///
  /// Returns the token string if found, otherwise returns null.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print('Token retrieved: $token');
    return token;
  }

  /// Deletes the authentication token from SharedPreferences.
  /// ini untuk menghapus token dari perangkat
  /// digunakan saat logout
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    print('Token deleted.');
  }
}
// save token digunakan untuk menyimpan token ke memori lokal setelah login
// get token di gunakan untuk mengambil token dari memori lokal untuk dipakai saat request ke API
//delete token untuk digunakan menghapus token saat logout atau expired