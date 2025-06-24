// lib/models/booking_servis_response.dart
import 'booking_servis_data.dart'; // Import BookingServisData model

/// Represents the response structure for creating a service booking.
class BookingServisResponse {
  /// A message indicating the result of the booking operation.
  final String? message;

  /// The data of the created service booking.
  final BookingServisData? data;

  /// Constructor for the BookingServisResponse model.
  BookingServisResponse({this.message, this.data});

  /// Factory constructor to create a BookingServisResponse object from a JSON map.
  factory BookingServisResponse.fromJson(Map<String, dynamic> json) {
    return BookingServisResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? BookingServisData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this BookingServisResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
