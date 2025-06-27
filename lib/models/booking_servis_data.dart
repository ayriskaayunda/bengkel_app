class BookingServisData {
  final int? id;

  final int? userId;

  final DateTime? bookingDate;

  final String? vehicleType;

  final String? description;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  BookingServisData({
    this.id,
    this.userId,
    this.bookingDate,
    this.vehicleType,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

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
