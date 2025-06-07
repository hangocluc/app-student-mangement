import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StudentModel {
  String? id;
  @JsonKey(name: 'hoTen')
  String? name;
  @JsonKey(name: 'maSV')
  String? studentId;
  @JsonKey(name: 'maLop')
  String? className;
  String? email;
  String? phone;
  String? address;
  @JsonKey(name: 'ngaySinh')
  String? dateOfBirth;
  String? avatar;
  String? gender;

  StudentModel({
    this.id,
    this.name,
    this.studentId,
    this.className,
    this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.avatar,
    this.gender,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
