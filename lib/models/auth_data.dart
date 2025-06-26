import 'user.dart'; // Import the User model

/// Represents authentication data including a token and user information.
class AuthData {
  /// The authentication token.
  final String? token;

  /// The user associated with this authentication.
  final User? user;

  /// Constructor for the AuthData model.
  AuthData({this.token, this.user});

  /// Factory constructor to create an AuthData object from a JSON map.
  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'] as String?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this AuthData object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user?.toJson()};
  }
}
