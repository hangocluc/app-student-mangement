import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/theme/app_spacing.dart';
import '../../../../common/theme/app_typography.dart';
import '../../../../common/widget/app_button/app_button.dart';
import '../../../../common/widget/app_text/app_text.dart';
import '../../../../common/widget/app_text_field/src/custom_text_field.dart';
import '../../../../core/extension/src/context_extension.dart';
import '../../../data/models/student/student_model.dart';

class EditStudentScreen extends StatefulWidget {
  final StudentModel student;

  const EditStudentScreen({
    super.key,
    required this.student,
  });

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _studentIdController;
  late final TextEditingController _classNameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _studentIdController =
        TextEditingController(text: widget.student.studentId);
    _classNameController =
        TextEditingController(text: widget.student.className);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _classNameController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement save logic
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: context.l10n.edit,
          style: AppTypography().heading5,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.spacing4.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  // Name field
                  AppCustomTextField(
                    title: context.l10n.name,
                    hintText: context.l10n.enterName,
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.pleaseEnterName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Student ID field
                  AppCustomTextField(
                    title: context.l10n.studentId,
                    hintText: context.l10n.enterStudentId,
                    controller: _studentIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.pleaseEnterStudentId;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Class field
                  AppCustomTextField(
                    title: context.l10n.className,
                    hintText: context.l10n.enterClassName,
                    controller: _classNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.pleaseEnterClassName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),
                  // Save button
                  AppButton(
                    onTap: _onSave,
                    title: context.l10n.save,
                    height: 48.h,
                    titleStyle: AppTypography().bodyMediumSemiBold.copyWith(
                          color: AppColors.white.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
