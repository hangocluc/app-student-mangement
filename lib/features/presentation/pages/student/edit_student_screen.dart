import 'package:base_bloc_cubit/features/data/models/student/student_model.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/student/add_student_controller.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/student/update_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/theme/app_radius.dart';
import '../../../../common/theme/app_spacing.dart';
import '../../../../common/theme/app_typography.dart';
import '../../../../common/widget/app_button/app_button.dart';
import '../../../../common/widget/app_text/app_text.dart';
import '../../../../common/widget/app_text_field/src/components/date_model.dart';
import '../../../../common/widget/app_text_field/src/custom_date_scroll_selection.dart';
import '../../../../common/widget/app_text_field/src/custom_text_field.dart';
import '../../../../core/extension/src/context_extension.dart';

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
  final _nameController = TextEditingController();
  final _classNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _selectedDate;
  late UpdateStudentController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(UpdateStudentController());
    _nameController.text = widget.student.name ?? '';
    if (widget.student.dob() != null) {
      _selectedDate = widget.student.dob();
    }
    controller.student = widget.student;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    Get.delete<UpdateStudentController>();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      controller.updateStudents();
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
                  AppCustomTextField(
                    controller: _nameController,
                    title: '${context.l10n.name} *',
                    hintText: context.l10n.enterName,
                    onChange: (value) {
                      controller.student.name = value?.trim() ?? '';
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return context.l10n.pleaseEnterName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSpacing.spacing4.h),
                  Text(
                    'Class *',
                    style: AppTypography().bodySmallRegular.copyWith(
                      color: AppColors.theBlack.theBlack900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Container(
                    height: 48,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.theBlack.theBlack200),
                      borderRadius: const BorderRadius.all(AppRadius.radius4),
                    ),
                    child: DropdownButton(
                      value: controller.student.classCode,
                      items: controller.classes.value
                          .map((e) => DropdownMenuItem(
                        value: e.maLop,
                        child: Text(e.tenLop ?? ''),
                      ))
                          .toList(),
                      onChanged: (maLop) {
                        controller.student.classCode = maLop ?? '';
                        setState(() {});
                      },
                      hint: const Text(
                        'Select class',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      isExpanded: true,
                      underline: const SizedBox(),
                    ),
                  )),
                  SizedBox(height: AppSpacing.spacing4.h),
                  Text(
                    'Gender *',
                    style: AppTypography().bodySmallRegular.copyWith(
                      color: AppColors.theBlack.theBlack900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 48,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.theBlack.theBlack200),
                      borderRadius: const BorderRadius.all(AppRadius.radius4),
                    ),
                    child: DropdownButton(
                      value: controller.student.gender ?? widget.student.gender,
                      items: ['Nam', 'Nữ']
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                      onChanged: (gender) {
                        controller.student.gender = gender ?? '';
                        setState(() {});
                      },
                      hint: const Text(
                        'Select gender',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      isExpanded: true,
                      underline: const SizedBox(),
                    ),
                  ),
                  SizedBox(height: AppSpacing.spacing4.h),
                  CustomDateScrollSelection(
                    title: '${context.l10n.selectDateOfBirth} *',
                    titleBottomSheet: context.l10n.selectDateOfBirth,
                    onChange: (date) {
                      setState(() {
                        _selectedDate = DateTime(date.year, date.month, date.day);
                      });
                      controller.student.dateOfBirth =
                          _selectedDate?.toIso8601String() ?? '';
                    },
                    selectedValue: _selectedDate != null
                        ? DateModel(
                      year: _selectedDate!.year,
                      month: _selectedDate!.month,
                      day: _selectedDate!.day,
                    )
                        : null,
                    hintText: context.l10n.selectDateOfBirth,
                  ),
                  SizedBox(height: AppSpacing.spacing8.h),
                  AppButton(
                    onTap: _onSave,
                    padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.spacing3),
                    titleStyle: AppTypography().bodyMediumSemiBold.copyWith(
                      color: AppColors.white.white,
                    ),
                    title: context.l10n.save,
                    width: double.infinity,
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
