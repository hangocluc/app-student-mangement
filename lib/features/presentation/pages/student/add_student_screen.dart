import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/theme/app_color.dart';
import '../../../../../common/theme/app_spacing.dart';
import '../../../../../common/theme/app_typography.dart';
import '../../../../../common/widget/app_button/app_button.dart';
import '../../../../../common/widget/app_text/app_text.dart';
import '../../../../../common/widget/app_text_field/src/custom_text_field.dart';
import '../../../../../common/widget/app_text_field/src/custom_date_scroll_selection.dart';
import '../../../../../common/widget/app_text_field/src/components/date_model.dart';
import '../../../../../core/extension/src/context_extension.dart';
import '../../../data/models/student/student_model.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _classNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _classNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
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
    if (_formKey.currentState?.validate() ?? false) {
      // Create new student
      final newStudent = StudentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
        name: _nameController.text,
        studentId: _studentIdController.text,
        className: _classNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        dateOfBirth: _selectedDate.toString(),
      );

      // Return the new student to the previous screen
      Navigator.pop(context, newStudent);
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
              title: context.l10n.name,
              hintText: context.l10n.enterName,
              isRequired: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return context.l10n.pleaseEnterName;
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.spacing4.h),
            AppCustomTextField(
              controller: _studentIdController,
              title: context.l10n.studentId,
              hintText: context.l10n.enterStudentId,
              isRequired: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return context.l10n.pleaseEnterStudentId;
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.spacing4.h),
            AppCustomTextField(
              controller: _classNameController,
              title: context.l10n.className,
              hintText: context.l10n.enterClassName,
              isRequired: true,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return context.l10n.pleaseEnterClassName;
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.spacing4.h),
            AppCustomTextField(
              controller: _emailController,
              title: context.l10n.email,
              hintText: context.l10n.enterEmail,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isNotEmpty ?? false) {
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value!)) {
                    return context.l10n.pleaseEnterValidEmail;
                  }
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.spacing4.h),
            AppCustomTextField(
              controller: _phoneController,
              title: context.l10n.phone,
              hintText: context.l10n.enterPhone,
              textInputType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value?.isNotEmpty ?? false) {
                  if (value!.length < 10) {
                    return context.l10n.pleaseEnterValidPhone;
                  }
                }
                return null;
              },
            ),
            SizedBox(height: AppSpacing.spacing4.h),
            AppCustomTextField(
              controller: _addressController,
              title: context.l10n.address,
              hintText: context.l10n.enterAddress,
              maxLine: 3,
            ),
            SizedBox(height: AppSpacing.spacing4.h),
            CustomDateScrollSelection(
              title: context.l10n.selectDateOfBirth,
              titleBottomSheet: context.l10n.selectDateOfBirth,
              onChange: (date) {
                setState(() {
                  _selectedDate = DateTime(date.year, date.month, date.day);
                });
              },
              selectedValue: _selectedDate != null
                  ? DateModel(
                      year: _selectedDate!.year,
                      month: _selectedDate!.month,
                      day: _selectedDate!.day,
                    )
                  : null,
              isRequired: true,
              hintText: context.l10n.selectDateOfBirth,
            ),
            SizedBox(height: AppSpacing.spacing8.h),
            AppButton(
              onTap: _submitForm,
              padding:
                  const EdgeInsets.symmetric(vertical: AppSpacing.spacing3),
              title: context.l10n.save,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
