// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      name: json['hoTen'] as String?,
      studentId: json['maSV'] as String?,
      className: json['tenLop'] as String?,
      dateOfBirth: json['ngaySinh'] as String?,
      gender: json['gioiTinh'] as String?,
      classCode: json['maLop'] as String?,
      major: json['tenKhoa'] as String?,
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'hoTen': instance.name,
      'maSV': instance.studentId,
      'tenLop': instance.className,
      'maLop': instance.classCode,
      'ngaySinh': instance.dateOfBirth,
      'gioiTinh': instance.gender,
      'tenKhoa': instance.major,
    };
