// ignore: depend_on_referenced_packages
import 'package:base_bloc_cubit/features/data/models/class.dart';
import 'package:base_bloc_cubit/features/data/models/models.dart';
import 'package:base_bloc_cubit/features/data/models/student/student_model.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:retrofit/retrofit.dart';

import '../../../../../core/base/base.dart';
import 'api_path.dart';

part 'demo_service.g.dart';

@RestApi()
abstract class DemoService {
  factory DemoService(Dio dio, {String baseUrl}) = _DemoService;

  @GET(DemoApiPath.demo)
  Future<ApiResponse<DemoModel>> demo();

  @GET(DemoApiPath.studentRoute)
  Future<ApiResponse<List<StudentModel>>> getStudents();

  @DELETE('${DemoApiPath.studentRoute}/{maSV}')
  Future<ApiResponse> deleteStudent(@Path("maSV") String maSV);

  @POST(DemoApiPath.studentRoute)
  Future<ApiResponse> createStudent(
    @Field("hoTen") String hoTen,
    @Field("ngaySinh") String ngaySinh,
    @Field("gioiTinh") String gioiTinh,
    @Field("maLop") String maLop,
  );

  @PUT('${DemoApiPath.studentRoute}/{maSV}')
  Future<ApiResponse> updateStudents(
      @Field("hoTen") String hoTen,
      @Field("ngaySinh") String ngaySinh,
      @Field("gioiTinh") String gioiTinh,
      @Field("maLop") String maLop,
      @Path("maSV") String maSv,
  );

  @GET(DemoApiPath.classRoute)
  Future<ApiResponse<List<Class>>> getClasses();
}
