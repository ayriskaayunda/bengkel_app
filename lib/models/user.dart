// lib/models/user.dart

/// Represents a User object from the API response.
class User {
  /// Unique identifier for the user.
  final int? id;

  /// The name of the user.
  final String? name;

  /// The email address of the user.
  final String? email;

  /// The timestamp when the email was verified. Can be null.
  final DateTime? emailVerifiedAt;

  /// The timestamp when the user was created.
  final DateTime? createdAt;

  /// The timestamp when the user was last updated.
  final DateTime? updatedAt;

  /// Constructor for the User model.
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor to create a User object from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Converts this User object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
