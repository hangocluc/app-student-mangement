import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/generate/assets.gen.dart';
import '../../../../../common/theme/app_color.dart';
import '../../../../../common/theme/app_spacing.dart';
import '../../../../../common/theme/app_typography.dart';
import '../../../../../common/widget/app_button/app_button.dart';
import '../../../../../common/widget/app_text/app_text.dart';
import '../../../../../common/widget/app_text_field/src/custom_text_field.dart';
import '../../../../../core/extension/src/context_extension.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: context.l10n.forgotPassword,
          style: AppTypography().heading5,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing4.w,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 48.h),
                  // Logo
                  Center(
                    child: SvgPicture.asset(
                      Assets.icons.icUserCircle.path,
                      width: 120.w,
                      height: 120.w,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Title
                  AppText(
                    title: 'Reset your password',
                    style: AppTypography().heading5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    title:
                        'Please enter your old password and new password to reset.',
                    maxLines: 2,
                    style: AppTypography().bodyMediumRegular.copyWith(
                          color: AppColors.theBlack.theBlack500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  // Old Password field
                  AppCustomTextField(
                    title: 'Old Password',
                    hintText: 'Enter your old password',
                    controller: _oldPasswordController,
                    prefixIcon: Assets.icons.icLocked.path,
                    obscureText: _obscureOldPassword,
                    suffixIcon: _obscureOldPassword
                        ? Assets.icons.icEye.path
                        : Assets.icons.icHideEye.path,
                    onTapSuffixIcon: () {
                      setState(() {
                        _obscureOldPassword = !_obscureOldPassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  // New Password field
                  AppCustomTextField(
                    title: 'New Password',
                    hintText: 'Enter your new password',
                    controller: _newPasswordController,
                    prefixIcon: Assets.icons.icLocked.path,
                    obscureText: _obscureNewPassword,
                    suffixIcon: _obscureNewPassword
                        ? Assets.icons.icEye.path
                        : Assets.icons.icHideEye.path,
                    onTapSuffixIcon: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      if (value == _oldPasswordController.text) {
                        return 'New password must be different from old password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  // Reset Password button
                  AppButton(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // TODO: Implement password reset logic
                      }
                    },
                    title: 'Reset Password',
                    height: 48.h,
                    titleStyle: AppTypography().bodyMediumSemiBold.copyWith(
                          color: AppColors.white.white,
                        ),
                  ),
                  SizedBox(height: 16.h),
                  // Back to Login button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: AppText(
                      title: 'Back to Login',
                      style: AppTypography().bodyMediumMedium.copyWith(
                            color: AppColors.primary.primary500,
                          ),
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
