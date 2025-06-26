class ServisStatusData {
  /// The status of the service (e.g., "Selesai").
  final String? status;

  /// Constructor for the ServisStatusData model.
  ServisStatusData({this.status});

  /// Factory constructor to create a ServisStatusData object from a JSON map.
  factory ServisStatusData.fromJson(Map<String, dynamic> json) {
    return ServisStatusData(status: json['status'] as String?);
  }

  /// Converts this ServisStatusData object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'status': status};
  }
}
