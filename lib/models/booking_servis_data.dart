// lib/models/booking_servis_data.dart

/// Represents the data for a service booking.
class BookingServisData {
  /// Unique identifier for the booking.
  final int? id;

  /// The ID of the user who made the booking.
  final int? userId;

  /// The date of the booking.
  final DateTime? bookingDate;

  /// The type of vehicle for the service.
  final String? vehicleType;

  /// A description of the service requested.
  final String? description;

  /// The timestamp when the booking was created.
  final DateTime? createdAt;

  /// The timestamp when the booking was last updated.
  final DateTime? updatedAt;

  /// Constructor for the BookingServisData model.
  BookingServisData({
    this.id,
    this.userId,
    this.bookingDate,
    this.vehicleType,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor to create a BookingServisData object from a JSON map.
  factory BookingServisData.fromJson(Map<String, dynamic> json) {
    return BookingServisData(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      bookingDate: json['booking_date'] != null
          ? DateTime.parse(json['booking_date'] as String)
          : null,
      vehicleType: json['vehicle_type'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Converts this BookingServisData object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'booking_date': bookingDate?.toIso8601String(),
      'vehicle_type': vehicleType,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
