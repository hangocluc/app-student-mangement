class ClassResponse {
  String? status;
  List<Class>? data;

  ClassResponse({this.status, this.data});

  ClassResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Class>[];
      json['data'].forEach((v) {
        data!.add(Class.fromJson(v));
      });
    }
  }
}

class Class {
  String? maLop;
  String? tenLop;
  String? maKhoa;
  String? tenKhoa;

  Class({this.maLop, this.tenLop, this.maKhoa, this.tenKhoa});

  Class.fromJson(Map<String, dynamic> json) {
    maLop = json['maLop'];
    tenLop = json['tenLop'];
    maKhoa = json['maKhoa'];
    tenKhoa = json['tenKhoa'];
  }
}
