// lib/models/register_response.dart
import 'auth_data.dart'; // Import AuthData model

/// Represents the response structure for user registration.
class RegisterResponse {
  /// A message indicating the result of the registration.
  final String? message;

  /// The authentication data, including token and user details.
  final AuthData? data;

  /// Constructor for the RegisterResponse model.
  RegisterResponse({this.message, this.data});

  /// Factory constructor to create a RegisterResponse object from a JSON map.
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? AuthData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this RegisterResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
