class ServisStatusData {
  final String? status;

  ServisStatusData({this.status});

  factory ServisStatusData.fromJson(Map<String, dynamic> json) {
    return ServisStatusData(status: json['status'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'status': status};
  }
}
//ini untuk menyimpan datau mengambil status dari suatu servis seperti menunggu,diproses,selesai,dan dibatalkan