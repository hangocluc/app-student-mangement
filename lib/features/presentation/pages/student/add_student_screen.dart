import 'package:base_bloc_cubit/common/theme/app_color.dart';
import 'package:base_bloc_cubit/common/widget/app_toast/app_toast.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/student/add_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/theme/app_spacing.dart';
import '../../../../../common/theme/app_typography.dart';
import '../../../../../common/widget/app_button/app_button.dart';
import '../../../../../common/widget/app_text/app_text.dart';
import '../../../../../common/widget/app_text_field/src/components/date_model.dart';
import '../../../../../common/widget/app_text_field/src/custom_date_scroll_selection.dart';
import '../../../../../common/widget/app_text_field/src/custom_text_field.dart';
import '../../../../../core/extension/src/context_extension.dart';
import '../../../../common/theme/app_radius.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _classNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _selectedDate;
  late AddStudentController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddStudentController());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    Get.delete<AddStudentController>();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (controller.enoughField()) {
      controller.createStudent();
    } else {
      showToastError(context, 'Please enter require field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: context.l10n.addNewStudent,
          style: AppTypography().heading5,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(AppSpacing.spacing4.w),
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
                value: controller.student.gender,
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
              onTap: _submitForm,
              padding:
                  const EdgeInsets.symmetric(vertical: AppSpacing.spacing3),
              titleStyle: AppTypography().bodyMediumSemiBold.copyWith(
                color: AppColors.white.white,
              ),
              title: context.l10n.save,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
