import 'package:base_bloc_cubit/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/generate/assets.gen.dart';
import '../../../../../common/theme/app_color.dart';
import '../../../../../common/theme/app_spacing.dart';
import '../../../../../common/theme/app_typography.dart';
import '../../../../../common/widget/app_button/app_button.dart';
import '../../../../../common/widget/app_loading_overlay/app_loading_overlay.dart';
import '../../../../../common/widget/app_text/app_text.dart';
import '../../../../../common/widget/app_text_field/src/custom_text_field.dart';
import '../../../../../common/widget/app_toast/app_toast.dart';
import '../../../../../core/extension/src/context_extension.dart';
import '../../../../app/routes/src/routes_name.dart';
import '../../../cubits/login/login_cubit.dart';
import '../../../cubits/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final _emailErrorText = ValueNotifier<String?>(null);
  final _passwordErrorText = ValueNotifier<String?>(null);
  final loginCubit = sl.get<LoginCubit>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailErrorText.dispose();
    _passwordErrorText.dispose();
    super.dispose();
  }

  bool _validateForm() {
    bool isValid = true;

    if (_emailController.text.isEmpty) {
      _emailErrorText.value = context.l10n.pleaseEnterUserName;
      isValid = false;
    } else {
      _emailErrorText.value = null;
    }

    if (_passwordController.text.isEmpty) {
      _passwordErrorText.value = context.l10n.pleaseEnterPassword;
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      _passwordErrorText.value = context.l10n.passwordMinLength;
      isValid = false;
    } else {
      _passwordErrorText.value = null;
    }

    return isValid;
  }

  _listenCubit(BuildContext context, LoginState state) {
    switch (state) {
      case LoginStateInitial():
        dismissLoadingOverlay(context);
      case LoginStateLoading():
        showLoadingOverlay(context);
      case LoginStateError():
        dismissLoadingOverlay(context);
        showToastError(context, state.message);
      case LoginStateSuccess():
        dismissLoadingOverlay(context);
        setState(() {});
        Navigator.popAndPushNamed(context, RouteName.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            _listenCubit(context, state);
          },
          child: Scaffold(
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
                          title: context.l10n.welcomeBack,
                          style: AppTypography().heading1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        AppText(
                          title: context.l10n.pleaseSignIn,
                          style: AppTypography().bodyMediumRegular.copyWith(
                                color: AppColors.theBlack.theBlack500,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32.h),
                        // Email field
                        AppCustomTextField(
                          title: context.l10n.userName,
                          hintText: context.l10n.enterUserName,
                          controller: _emailController,
                          prefixIcon: Assets.icons.icMail.path,
                          errorText: _emailErrorText,
                        ),
                        SizedBox(height: 16.h),
                        // Password field
                        AppCustomTextField(
                          title: context.l10n.password,
                          hintText: context.l10n.enterPassword,
                          controller: _passwordController,
                          prefixIcon: Assets.icons.icLocked.path,
                          obscureText: _obscurePassword,
                          suffixIcon: _obscurePassword
                              ? Assets.icons.icEye.path
                              : Assets.icons.icHideEye.path,
                          onTapSuffixIcon: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          errorText: _passwordErrorText,
                        ),
                        SizedBox(height: 24.h),
                        // Login button
                        AppButton(
                          onTap: () {
                            if (_validateForm()) {
                              loginCubit.login(
                                  username: _emailController.text,
                                  password: _passwordController.text);
                            }
                          },
                          title: context.l10n.signIn,
                          height: 48.h,
                          titleStyle:
                              AppTypography().bodyMediumSemiBold.copyWith(
                                    color: AppColors.white.white,
                                  ),
                        ),
                        SizedBox(height: 16.h),
                        // Forgot password
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteName.forgotPassword);
                          },
                          child: AppText(
                            title: context.l10n.forgotPassword,
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
          )),
    );
  }
}
