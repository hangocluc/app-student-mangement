import 'package:base_bloc_cubit/features/presentation/pages/student/add_student_screen.dart';
import 'package:flutter/material.dart';

import '../../../data/models/student/student_model.dart';
import '../../../presentation/pages/auth/forgot_password/forgot_password_page.dart';
import '../../../presentation/pages/auth/login/login_screen.dart';
import '../../../presentation/pages/student/edit_student_screen.dart';
import '../../../presentation/pages/student/student_list_screen.dart';
import 'not_found_page.dart';
import 'routes_name.dart';

class GenerateRoute {
  static Route<dynamic> getPageRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.root:
        return getPageRoute(const LoginScreen(), settings);
      case RouteName.home:
        return getPageRoute(const StudentListScreen(), settings);
      case RouteName.addStudent:
        return getPageRoute(const AddStudentScreen(), settings);
      case RouteName.forgotPassword:
        return getPageRoute(const ForgotPasswordPage(), settings);
      case RouteName.editStudent:
        final student = settings.arguments as StudentModel;
        return getPageRoute(EditStudentScreen(student: student), settings);
      // case RouteName.home:
      //   return getPageRoute(const HomePage(), settings);
      // case RouteName.registerVerificationEmail:
      //   final args = settings.arguments as RegisterVerificationEmailPageParams;
      //   return getPageRoute(
      //       RegisterVerificationEmailPage(args: args), settings);

      default:
        return getPageRoute(const NotFoundPage(), settings);
    }
  }
}
