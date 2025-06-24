// lib/models/update_servis_status_response.dart
import 'servis.dart'; // Import Servis model

/// Represents the response structure for updating a service status.
class UpdateServisStatusResponse {
  /// A message indicating the result of the status update.
  final String? message;

  /// The updated Servis object.
  final Servis? data;

  /// Constructor for the UpdateServisStatusResponse model.
  UpdateServisStatusResponse({this.message, this.data});

  /// Factory constructor to create an UpdateServisStatusResponse object from a JSON map.
  factory UpdateServisStatusResponse.fromJson(Map<String, dynamic> json) {
    return UpdateServisStatusResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? Servis.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this UpdateServisStatusResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
