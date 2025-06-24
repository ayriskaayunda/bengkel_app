// lib/models/delete_servis_response.dart

/// Represents the response structure for deleting a service.
class DeleteServisResponse {
  /// A message indicating the result of the deletion.
  final String? message;

  /// Data field, which is expected to be null on successful deletion.
  final dynamic data; // Use dynamic as it can be null

  /// Constructor for the DeleteServisResponse model.
  DeleteServisResponse({this.message, this.data});

  /// Factory constructor to create a DeleteServisResponse object from a JSON map.
  factory DeleteServisResponse.fromJson(Map<String, dynamic> json) {
    return DeleteServisResponse(
      message: json['message'] as String?,
      data: json['data'], // Data can be null
    );
  }

  /// Converts this DeleteServisResponse object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data};
  }
}
