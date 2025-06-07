// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      id: json['id'] as String?,
      name: json['hoTen'] as String?,
      studentId: json['maSV'] as String?,
      className: json['maLop'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['ngaySinh'] as String?,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hoTen': instance.name,
      'maSV': instance.studentId,
      'maLop': instance.className,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'ngaySinh': instance.dateOfBirth,
      'avatar': instance.avatar,
      'gender': instance.gender,
    };
