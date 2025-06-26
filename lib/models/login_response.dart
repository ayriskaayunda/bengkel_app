import 'auth_data.dart'; // Import AuthData model

/// Represents the response structure for user login.
class LoginResponse {
  /// A message indicating the result of the login.
  final String? message;

  /// The authentication data, including token and user details.
  final AuthData? data;

  /// Constructor for the LoginResponse model.
  LoginResponse({this.message, this.data});

  /// Factory constructor to create a LoginResponse object from a JSON map.
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? AuthData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this LoginResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
