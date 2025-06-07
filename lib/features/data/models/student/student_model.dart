import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StudentModel {
  @JsonKey(name: 'hoTen')
  String? name;
  @JsonKey(name: 'maSV')
  String? studentId;
  @JsonKey(name: 'tenLop')
  String? className;
  @JsonKey(name: 'maLop')
  String? classCode;
  @JsonKey(name: 'ngaySinh')
  String? dateOfBirth;
  @JsonKey(name: 'gioiTinh')
  String? gender;
  @JsonKey(name: 'tenKhoa')
  String? major;

  StudentModel({
    this.name,
    this.studentId,
    this.className,
    this.dateOfBirth,
    this.gender,
    this.classCode,
    this.major,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  DateTime? dob() {
    try {
      return DateTime.parse(dateOfBirth!);
    } catch (_) {
      return null;
    }
  }
}
