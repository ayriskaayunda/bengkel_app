// lib/models/servis_history_response.dart
import 'servis.dart'; // Import Servis model

/// Represents the response structure for fetching service history.
class ServisHistoryResponse {
  /// A message indicating the result of fetching the service history.
  final String? message;

  /// A list of Servis objects representing the history.
  final List<Servis>? data;

  /// Constructor for the ServisHistoryResponse model.
  ServisHistoryResponse({this.message, this.data});

  /// Factory constructor to create a ServisHistoryResponse object from a JSON map.
  factory ServisHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ServisHistoryResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Servis.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Converts this ServisHistoryResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.map((e) => e.toJson()).toList()};
  }
}
