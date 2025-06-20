import 'dart:async';

import 'package:base_bloc_cubit/common/widget/app_loading_overlay/app_loading_overlay.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/student/student_state.dart';
import 'package:base_bloc_cubit/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/theme/app_spacing.dart';
import '../../../../common/theme/app_typography.dart';
import '../../../../common/widget/app_button/app_button.dart';
import '../../../../common/widget/app_text/app_text.dart';
import '../../../../core/extension/src/context_extension.dart';
import '../../../app/routes/src/routes_name.dart';
import '../../cubits/student/student_cubit.dart';
import '../../cubits/student/student_state.dart';
import '../../../data/models/student/student_model.dart';
import '../../cubits/login/login_cubit.dart';
import '../auth/login/login_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final bool _isLoading = false;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final cubit = sl.get<StudentCubit>();

  List<StudentModel> studentsUI = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getStudents();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Timer? _debounce;
  final _debounceDuration = const Duration(milliseconds: 500);

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      cubit.getStudents(maSV: query);
    });
  }

  _listenCubit(BuildContext context, StudentState state) {
    switch (state) {
      case StudentStateInitial():
        dismissLoadingOverlay(context);
      case StudentStateLoading():
        showLoadingOverlay(context);
      case StudentStateError():
        dismissLoadingOverlay(context);
      case StudentStateSuccess():
        dismissLoadingOverlay(context);
        studentsUI = state.students;
        setState(() {});
      case DeleteStudentStateSuccess():
        dismissLoadingOverlay(context);
        setState(() {});
    }
  }

  Future<void> _deleteStudent(String id) async {
    cubit.deleteStudent(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.theBlack.theBlack100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search student code...',
                    hintStyle: AppTypography().bodyMediumRegular.copyWith(
                          color: AppColors.theBlack.theBlack400,
                        ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.theBlack.theBlack400,
                      size: 20.w,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: AppColors.theBlack.theBlack400,
                              size: 20.w,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                  ),
                  style: AppTypography().bodyMediumRegular,
                  onChanged: _onSearchChanged,
                  onSubmitted: (_) {
                    setState(() => _isSearching = false);
                  },
                ),
              )
            : AppText(
                title: context.l10n.studentList,
                style: AppTypography().heading5,
              ),
        actions: [
          if (!_isSearching)
            IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = true;
                  _searchController.clear();
                });
              },
              icon: Icon(
                Icons.search,
                color: AppColors.primary.primary500,
              ),
            ),
          if (_isSearching)
            TextButton(
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                });
              },
              child: AppText(
                title: 'Cancel',
                style: AppTypography().bodyMediumMedium.copyWith(
                      color: AppColors.primary.primary500,
                    ),
              ),
            ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.theBlack.theBlack500,
            ),
            onSelected: (value) {
              if (value == 'logout') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: AppText(
                      title: 'Logout',
                      style: AppTypography().heading5,
                    ),
                    content: AppText(
                      title: 'Are you sure you want to logout?',
                      style: AppTypography().bodyMediumRegular,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: AppText(
                          title: 'Cancel',
                          style: AppTypography().bodyMediumRegular.copyWith(
                                color: AppColors.primary.primary500,
                              ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _handleBackToLogin(context);
                        },
                        child: AppText(
                          title: 'Logout',
                          style: AppTypography().bodyMediumRegular.copyWith(
                                color: AppColors.red.red500,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 20.w,
                      color: AppColors.red.red500,
                    ),
                    SizedBox(width: 8.w),
                    AppText(
                      title: 'Logout',
                      style: AppTypography().bodyMediumRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocListener<StudentCubit, StudentState>(
          listener: (context, state) {
            _listenCubit(context, state);
          },
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : studentsUI.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 80.w,
                            color: AppColors.primary.primary300,
                          ),
                          SizedBox(height: 16.h),
                          AppText(
                            title: _isSearching
                                ? 'No students found matching your search'
                                : context.l10n.noStudentsFound,
                            style: AppTypography().bodyLargeRegular,
                          ),
                          SizedBox(height: 24.h),
                          if (!_isSearching)
                            AppButton(
                              onTap: () async {
                                final result = await Navigator.pushNamed(
                                    context, RouteName.addStudent);
                                if (result == true) {
                                  cubit.getStudents();
                                }
                              },
                              title: context.l10n.addNewStudent,
                              width: 200.w,
                            ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: cubit.getStudents,
                      child: ListView.builder(
                        padding: EdgeInsets.all(AppSpacing.spacing4.w),
                        itemCount: studentsUI.length,
                        itemBuilder: (context, index) {
                          final student = studentsUI[index];
                          return Card(
                            margin:
                                EdgeInsets.only(bottom: AppSpacing.spacing4.w),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.all(AppSpacing.spacing4.w),
                              leading: CircleAvatar(
                                radius: 24.r,
                                backgroundColor: AppColors.primary.primary100,
                                child: AppText(
                                  title: (student.name)
                                          ?.substring(0, 1)
                                          .toUpperCase() ??
                                      '',
                                  style: AppTypography().heading3.copyWith(
                                        color: AppColors.primary.primary500,
                                      ),
                                ),
                              ),
                              title: AppText(
                                title: student.name ?? '',
                                style: AppTypography().bodyLargeSemiBold,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4.h),
                                  AppText(
                                    title:
                                        '${context.l10n.studentId}: ${student.studentId}',
                                    style: AppTypography()
                                        .bodyMediumRegular
                                        .copyWith(
                                          color: AppColors.theBlack.theBlack500,
                                        ),
                                  ),
                                  SizedBox(height: 4.h),
                                  AppText(
                                    title:
                                        '${context.l10n.className}: ${student.className}',
                                    style: AppTypography()
                                        .bodyMediumRegular
                                        .copyWith(
                                          color: AppColors.theBlack.theBlack500,
                                        ),
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: AppColors.theBlack.theBlack500,
                                ),
                                onSelected: (value) async {
                                  switch (value) {
                                    case 'edit':
                                      final result = await Navigator.pushNamed(
                                        context,
                                        RouteName.editStudent,
                                        arguments: student,
                                      );
                                      if (result == true) {
                                        cubit.getStudents();
                                      }
                                      break;
                                    case 'delete':
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: AppText(
                                            title: context.l10n.deleteStudent,
                                            style: AppTypography().heading3,
                                          ),
                                          content: AppText(
                                            title: context
                                                .l10n.deleteStudentConfirm,
                                            style: AppTypography()
                                                .bodyMediumRegular,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: AppText(
                                                title: context.l10n.cancel,
                                                style: AppTypography()
                                                    .bodyMediumMedium,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                _deleteStudent(
                                                    student.studentId ?? '');
                                                Navigator.pop(context);
                                              },
                                              child: AppText(
                                                title: context.l10n.delete,
                                                style: AppTypography()
                                                    .bodyMediumMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primary.primary500,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      break;
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 20.w,
                                          color: AppColors.primary.primary500,
                                        ),
                                        SizedBox(width: 8.w),
                                        AppText(
                                          title: context.l10n.edit,
                                          style:
                                              AppTypography().bodyMediumRegular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 20.w,
                                          color: AppColors.red.red500,
                                        ),
                                        SizedBox(width: 8.w),
                                        AppText(
                                          title: context.l10n.delete,
                                          style:
                                              AppTypography().bodyMediumRegular,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, RouteName.addStudent);
          if (result == true) {
            cubit.getStudents();
          }
        },
        backgroundColor: AppColors.primary.primary500,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

_handleBackToLogin(BuildContext context) {
  //dismissLoadingOverlay(context);
  final loginCubit = sl.get<LoginCubit>();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => loginCubit,
        child: const LoginScreen(),
      ),
    ),
    (route) => false,
  );
  Future.delayed(const Duration(seconds: 2), () {});
}
