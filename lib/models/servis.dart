// lib/models/servis.dart

/// Represents a service entry (servis) from the API.
class Servis {
  /// Unique identifier for the service.
  final int? id;

  /// The ID of the user associated with this service.
  final int? userId;

  /// The type of vehicle for the service.
  final String? vehicleType;

  /// The complaint or description of the service issue.
  final String? complaint;

  /// The current status of the service (e.g., "Menunggu", "Diproses", "Selesai").
  final String? status;

  /// The timestamp when the service was created.
  final DateTime? createdAt;

  /// The timestamp when the service was last updated.
  final DateTime? updatedAt;

  /// Constructor for the Servis model.
  Servis({
    this.id,
    this.userId,
    this.vehicleType,
    this.complaint,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor to create a Servis object from a JSON map.
  factory Servis.fromJson(Map<String, dynamic> json) {
    return Servis(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      vehicleType: json['vehicle_type'] as String?,
      complaint: json['complaint'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Converts this Servis object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'vehicle_type': vehicleType,
      'complaint': complaint,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
