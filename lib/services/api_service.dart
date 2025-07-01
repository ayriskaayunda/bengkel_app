import 'dart:convert';

import 'package:bengkel_app/models/booking_servis_response.dart';
import 'package:bengkel_app/models/delete_servis_response.dart';
import 'package:bengkel_app/models/login_response.dart';
import 'package:bengkel_app/models/register_response.dart';
import 'package:bengkel_app/models/servis_history_response.dart';
import 'package:bengkel_app/models/servis_list_response.dart';
import 'package:bengkel_app/models/servis_response.dart';
import 'package:bengkel_app/models/servis_status_response.dart';
import 'package:bengkel_app/models/single_servis_status.dart';
import 'package:bengkel_app/services/token_manager.dart';
import 'package:http/http.dart' as http;

/// kelas servis untuk menangani semua interaksi API dengan backend bengkel
class ApiService {
  static const String _baseUrl = "https://appbengkel.mobileprojp.com";

  //  TokenManager untuk  menyimpan dan  mengambil token otentikasi secara lokal
  final TokenManager _tokenManager = TokenManager();

  /// Helper function to handle common API request logic and error reporting.
  /// menerima URL endpoint, metode HTTP, body request, dan mengembalikan
  /// The token is now automatically retrieved from TokenManager.
  Future<Map<String, dynamic>?> _sendRequest({
    // fungsi ini adalah helper utama yang mengirim permintaan HTTP ke server.
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
    bool requiresAuth =
        false, // New parameter to indicate if auth token is needed
  }) async {
    final uri = Uri.parse('$_baseUrl/api/$endpoint');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (requiresAuth) {
      final token = await _tokenManager.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      } else {
        print('Authentication required but no token found for $endpoint');
        // Optionally, you could throw an error or redirect to login
        return null;
      }
    }

    http.Response response;

    try {
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: headers);

          print(response.body);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case 'PUT':
          response = await http.put(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body) as Map<String, dynamic>;
        }
        return {};
      } else {
        print(
          'API Error for $endpoint: Status ${response.statusCode}, Body: ${response.body}',
        );
        return null;
      }
    } catch (e) {
      print('Network or parsing error for $endpoint: $e');
      return null;
    }
  }

  /// Registers a new user and saves the token upon success.
  /// Returns a [RegisterResponse] object on success, null on failure.
  Future<RegisterResponse?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final responseJson = await _sendRequest(
      endpoint: 'register',
      method: 'POST',
      body: {'name': name, 'email': email, 'password': password},
      requiresAuth: false,
    );

    if (responseJson != null) {
      final registerResponse = RegisterResponse.fromJson(responseJson);
      if (registerResponse.data?.token != null) {
        await _tokenManager.saveToken(registerResponse.data!.token!);
      }
      return registerResponse;
    }
    return null;
  }

  /// Logs in a user and saves the token upon success.
  /// Returns a [LoginResponse] object on success, null on failure.
  Future<LoginResponse?> login({
    required String email,
    required String password,
  }) async {
    final responseJson = await _sendRequest(
      endpoint: 'login',
      method: 'POST',
      body: {'email': email, 'password': password},
      requiresAuth: false,
    );

    if (responseJson != null) {
      final loginResponse = LoginResponse.fromJson(responseJson);
      if (loginResponse.data?.token != null) {
        await _tokenManager.saveToken(loginResponse.data!.token!);
      }
      return loginResponse;
    }
    return null;
  }

  /// Logs out the user by deleting the stored token.
  Future<void> logout() async {
    await _tokenManager.deleteToken();
    // You might also want to call a logout endpoint on your backend if available
  }

  /// Books a new service. Requires an authentication token.
  /// Returns a [BookingServisResponse] object on success, null on failure.
  Future<BookingServisResponse?> bookServis({
    required String bookingDate, // dengan Format: YYYY-MM-DD
    required String vehicleType,
    required String description,
  }) async {
    final responseJson = await _sendRequest(
      endpoint: 'booking-servis',
      method: 'POST',
      body: {
        'booking_date': bookingDate,
        'vehicle_type': vehicleType,
        'description': description,
      },
      requiresAuth: true,
    );

    if (responseJson != null) {
      return BookingServisResponse.fromJson(responseJson);
    }
    return null;
  }

  /// Creates a new general service entry. Requires an authentication token.
  /// Returns a [CreateServisResponse] object on success, null on failure.
  Future<CreateServisResponse?> createServis({
    required String vehicleType,
    required String complaint,
  }) async {
    final responseJson = await _sendRequest(
      endpoint: 'servis',
      method: 'POST',
      body: {'vehicle_type': vehicleType, 'complaint': complaint},
      requiresAuth: true,
    );

    if (responseJson != null) {
      return CreateServisResponse.fromJson(responseJson);
    }
    return null;
  }

  /// Fetches all service entries for the authenticated user. Requires an authentication token.
  /// Returns a [ServisListResponse] object on success, null on failure.
  Future<ServisListResponse?> getAllServis() async {
    final responseJson = await _sendRequest(
      endpoint: 'servis',
      method: 'GET',
      requiresAuth: true,
    );
    print(responseJson);

    if (responseJson != null) {
      return ServisListResponse.fromJson(responseJson);
    }
    return null;
  }

  /// Updates the status of a specific service entry. Requires an authentication token.
  /// Status can be "Menunggu", "Diproses", or "Selesai".
  /// Returns an [UpdateServisStatusResponse] object on success, null on failure.
  Future<UpdateServisStatusResponse?> updateServisStatus({
    required int servisId,
    required String status,
  }) async {
    final responseJson = await _sendRequest(
      endpoint: 'servis/$servisId/status',
      method: 'PUT',
      body: {'status': status},
      requiresAuth: true,
    );

    if (responseJson != null) {
      return UpdateServisStatusResponse.fromJson(responseJson);
    }
    return null;
  }

  /// Fetches the status of a specific service entry. Requires an authentication token.
  /// Returns a [SingleServisStatusResponse] object on success, null on failure.
  Future<SingleServisStatusResponse?> getServisStatus({
    required int servisId,
  }) async {
    final responseJson = await _sendRequest(
      endpoint: 'servis/$servisId/status',
      method: 'GET',
      requiresAuth: true,
    );

    if (responseJson != null) {
      return SingleServisStatusResponse.fromJson(responseJson);
    }
    return null;
  }

  /// Fetches the service history for the authenticated user. Requires an authentication token.
  /// Returns a [ServisHistoryResponse] object on success, null on failure.
  Future<ServisHistoryResponse?> getServisHistory() async {
    final responseJson = await _sendRequest(
      endpoint: 'riwayat-servis',
      method: 'GET',
      requiresAuth: true,
    );

    if (responseJson != null) {
      return ServisHistoryResponse.fromJson(responseJson);
    }
    return null;
  }

  /// Deletes a specific service entry. Requires an authentication token.
  /// Returns a [DeleteServisResponse] object on success, null on failure.
  Future<DeleteServisResponse?> deleteServis({required int servisId}) async {
    final responseJson = await _sendRequest(
      endpoint: 'servis/$servisId',
      method: 'DELETE',
      requiresAuth: true,
    );

    if (responseJson != null) {
      return DeleteServisResponse.fromJson(responseJson);
    }
    return null;
  }
}
