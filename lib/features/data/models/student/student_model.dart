import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StudentModel {
  final String? id;
  @JsonKey(name: 'hoTen')
  final String? name;
  @JsonKey(name: 'maSV')
  final String? studentId;
  @JsonKey(name: 'maLop')
  final String? className;
  final String? email;
  final String? phone;
  final String? address;
  @JsonKey(name: 'ngaySinh')
  final String? dateOfBirth;
  final String? avatar;

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
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
