// lib/models/servis_list_response.dart
import 'servis.dart'; // Import Servis model

/// Represents the response structure for listing multiple services.
class ServisListResponse {
  /// A message indicating the result of fetching the service data.
  final String? message;

  /// A list of Servis objects.
  final List<Servis>? data;

  /// Constructor for the ServisListResponse model.
  ServisListResponse({this.message, this.data});

  /// Factory constructor to create a ServisListResponse object from a JSON map.
  factory ServisListResponse.fromJson(Map<String, dynamic> json) {
    return ServisListResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Servis.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Converts this ServisListResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.map((e) => e.toJson()).toList()};
  }
}
