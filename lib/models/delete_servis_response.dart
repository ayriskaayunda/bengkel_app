class DeleteServisResponse {
  final String? message;

  final dynamic data;

  DeleteServisResponse({this.message, this.data});

  factory DeleteServisResponse.fromJson(Map<String, dynamic> json) {
    return DeleteServisResponse(
      message: json['message'] as String?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data};
  }
}
//model ini untuk menangani respon dari API ketika user menghapus data servis  
//untuk menghapus riwayat servis dan juga membatalkan pemesanan