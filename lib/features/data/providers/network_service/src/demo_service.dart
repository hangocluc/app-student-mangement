// ignore: depend_on_referenced_packages
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

  @GET(DemoApiPath.getStudent)
  Future<ApiResponse<List<StudentModel>>> getStudents();

  @DELETE(DemoApiPath.deleteStudent)
  Future<ApiResponse> deleteStudent(@Path("maSV") String maSV);

  // @GET(DemoApiPath.notificationPath)
  // Future<ApiResponse<NotificationModel>> listNotification(
  //   @Query('genreId') String genreId,
  //   @Query('per_page') int perPage,
  //   @Query('page') int page,
  // );

  // @GET(NotificationApiPath.detailNotificationPath)
  // Future<ApiResponse<Notification>> detailNotification(
  //     @Path('articleId') String id);

  // @POST(NotificationApiPath.readNotificationPath)
  // Future<ApiResponse> readNotification(@Path('articleId') String id);

  // @POST(NotificationApiPath.getPointNotificationPath)
  // Future<ApiResponse> getPointNotification(@Path('articleId') String id);

  // @GET(NoticeApiPath.notices)
  // Future<ApiResponse> getNotices();

  // @POST(NoticeApiPath.noticeShowOff)
  // Future<ApiResponse> noticeShowOff(@Path('noticeId') String noticeId);
}
