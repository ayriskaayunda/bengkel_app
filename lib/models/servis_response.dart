// lib/models/create_servis_response.dart
import 'servis.dart'; // Import Servis model

/// Represents the response structure for creating a new service.
class CreateServisResponse {
  /// A message indicating the result of the service creation.
  final String? message;

  /// The data of the newly created service.
  final Servis? data;

  /// Constructor for the CreateServisResponse model.
  CreateServisResponse({this.message, this.data});

  /// Factory constructor to create a CreateServisResponse object from a JSON map.
  factory CreateServisResponse.fromJson(Map<String, dynamic> json) {
    return CreateServisResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? Servis.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this CreateServisResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
