import 'servis_status_data.dart'; // Import ServisStatusData model

/// Represents the response structure for fetching a single service's status.
class SingleServisStatusResponse {
  /// A message indicating the result of fetching the status.
  final String? message;

  /// The data containing the service status.
  final ServisStatusData? data;

  /// Constructor for the SingleServisStatusResponse model.
  SingleServisStatusResponse({this.message, this.data});

  /// Factory constructor to create a SingleServisStatusResponse object from a JSON map.
  factory SingleServisStatusResponse.fromJson(Map<String, dynamic> json) {
    return SingleServisStatusResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? ServisStatusData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this SingleServisStatusResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
