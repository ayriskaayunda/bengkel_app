class Servis {
  final int? id; // id servis di database

  final String? userId; //id pengguna yang membuatt servis

  final String? vehicleType; // jenis kendaraan

  final String? complaint; // keluhan pengguna

  final String? status; // status servis

  final DateTime? createdAt; // tanggal saat servis dibuat

  final DateTime? updatedAt; // tanggal terakhir kali data servis di perbarui

  Servis({
    this.id,
    this.userId,
    this.vehicleType,
    this.complaint,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Servis.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      print('Key: $key, Value: $value, Type: ${value.runtimeType}');
    });

    return Servis(
      id: json['id'] as int?,
      userId: json['user_id']?.toString(),
      vehicleType: json['vehicle_type'] as String?,
      complaint: json['complaint'] as String?,
      status: json['status'] as String?,
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
      'vehicle_type': vehicleType,
      'complaint': complaint,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
//menyimpan dan mengelola data servis kendaraan , tampilkan list servis ,  tambah/update status.