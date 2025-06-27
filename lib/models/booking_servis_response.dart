import 'booking_servis_data.dart';

class BookingServisResponse {
  final String? message;

  final BookingServisData? data;

  BookingServisResponse({this.message, this.data});

  factory BookingServisResponse.fromJson(Map<String, dynamic> json) {
    return BookingServisResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? BookingServisData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}

//model ini untuk menangkap message dan detail data dari hasil booking
