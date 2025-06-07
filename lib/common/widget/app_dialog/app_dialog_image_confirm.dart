import 'package:base_bloc_cubit/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../app_button/app_button.dart';
import '../app_icon/app_asset_image.dart';
import '../app_icon/app_network_image.dart';

class AppDialogImageConfirm extends StatelessWidget {
  final String? title;
  final String? image;
  final String? subTitle;
  final Function? onConfirm;
  final Function? onCancel;
  final String? titleButtonConfirm;
  final String? titleButtonCancel;
  final Widget? dialogWidget;
  final Widget? descWidget;
  final bool isShowIcClose;
  final Widget? widgetMoreInfo;
  final bool barrierDismissible;
  final Color? colorButtonConfirm;
  final Color? colorButtonCancel;
  final Color? colorButtonConfirmTitle;
  final Color? colorButtonCancelTitle;
  final TextStyle? styleButtonConfirm;
  final TextStyle? styleButtonCancel;
  final bool isDoubleButton;

  const AppDialogImageConfirm({
    super.key,
    this.title,
    this.image,
    this.subTitle,
    this.titleButtonCancel,
    this.titleButtonConfirm,
    this.onConfirm,
    this.dialogWidget,
    this.descWidget,
    this.widgetMoreInfo,
    this.barrierDismissible = true,
    this.isShowIcClose = false,
    this.colorButtonCancel,
    this.colorButtonConfirm,
    this.colorButtonCancelTitle,
    this.colorButtonConfirmTitle,
    this.styleButtonCancel,
    this.styleButtonConfirm,
    this.onCancel,
    this.isDoubleButton = true,
  });

  static showAppDialogImageConfirm(
    BuildContext context, {
    String? title,
    String? subTitle,
    String? image,
    String? titleButtonCancel,
    String? titleButtonConfirm,
    Function? onConfirm,
    Widget? dialogWidget,
    Widget? descWidget,
    bool? isShowIcClose,
    Widget? widgetMoreInfo,
    bool barrierDismissible = true,
    Color? colorButtonConfirm,
    Color? colorButtonCancel,
    Color? colorButtonConfirmTitle,
    Color? colorButtonCancelTitle,
    Function? onCancel,
    TextStyle? styleButtonConfirm,
    TextStyle? styleButtonCancel,
    bool isDoubleButton = true,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AppDialogImageConfirm(
          title: title,
          image: image,
          subTitle: subTitle,
          titleButtonCancel: titleButtonCancel,
          isShowIcClose: isShowIcClose ?? false,
          dialogWidget: dialogWidget,
          descWidget: descWidget,
          widgetMoreInfo: widgetMoreInfo,
          onConfirm: onConfirm,
          isDoubleButton: isDoubleButton,
          colorButtonConfirm: colorButtonConfirm,
          colorButtonCancel: colorButtonCancel,
          colorButtonConfirmTitle: colorButtonConfirmTitle,
          colorButtonCancelTitle: colorButtonCancelTitle,
          onCancel: onCancel,
          titleButtonConfirm: titleButtonConfirm,
          styleButtonCancel: styleButtonCancel,
          styleButtonConfirm: styleButtonConfirm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.spacing4),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(AppRadius.radius3),
              ),
              child: dialogWidget ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppSpacing.spacing4,
                          right: AppSpacing.spacing4,
                          top: AppSpacing.spacing6,
                          bottom: AppSpacing.spacing3,
                        ),
                        child: Text(
                          title ?? '',
                          textAlign: TextAlign.center,
                          style: AppTypography().heading5.copyWith(
                                color: AppColors.theBlack.theBlack900,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppSpacing.spacing4,
                          right: AppSpacing.spacing4,
                          bottom: AppSpacing.spacing3,
                        ),
                        child: descWidget ??
                            Text(
                              subTitle ?? '',
                              textAlign: TextAlign.center,
                              style: AppTypography().bodySmallMedium.copyWith(
                                    color: AppColors.theBlack.theBlack700,
                                  ),
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.spacing4,
                        ),
                        child: _checkNetworkImage(image),
                      ),
                      widgetMoreInfo ?? const SizedBox(),
                      if (isDoubleButton) ...[
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                height: 56.h,
                                radius: AppRadius.radius3.x,
                                buttonColor: colorButtonCancel ??
                                    AppColors.primary.primary400,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.spacing3,
                                ),
                                margin: const EdgeInsets.only(
                                    top: AppSpacing.spacing4,
                                    left: AppSpacing.spacing4,
                                    bottom: AppSpacing.spacing4),
                                onTap: () {
                                  Navigator.pop(context);
                                  if (onCancel != null) {
                                    onCancel!();
                                  }
                                },
                                title: titleButtonCancel ?? '',
                                titleStyle: styleButtonCancel ??
                                    AppTypography().bodyMediumSemiBold.copyWith(
                                          color: colorButtonCancelTitle ??
                                              AppColors.white.white,
                                        ),
                              ),
                            ),
                            Expanded(
                              child: AppButton(
                                height: 56.h,
                                radius: AppRadius.radius3.x,
                                buttonColor: colorButtonConfirm ??
                                    AppColors.primary.primary400,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.spacing3,
                                ),
                                margin: const EdgeInsets.only(
                                    left: AppSpacing.spacing2,
                                    top: AppSpacing.spacing4,
                                    right: AppSpacing.spacing4,
                                    bottom: AppSpacing.spacing4),
                                onTap: () {
                                  if (onConfirm != null) {
                                    onConfirm!();
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                title: titleButtonConfirm ?? '',
                                titleStyle: styleButtonConfirm ??
                                    AppTypography().bodyMediumSemiBold.copyWith(
                                          color: colorButtonConfirmTitle ??
                                              AppColors.white.white,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        AppButton(
                          height: 56.h,
                          radius: AppRadius.radius3.x,
                          buttonColor: colorButtonConfirm ??
                              AppColors.primary.primary400,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.spacing3,
                          ),
                          margin: const EdgeInsets.all(AppSpacing.spacing4),
                          onTap: () {
                            if (onConfirm != null) {
                              onConfirm!();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: titleButtonConfirm ?? '',
                          titleStyle: styleButtonConfirm ??
                              AppTypography().bodyMediumSemiBold.copyWith(
                                    color: colorButtonConfirmTitle ??
                                        AppColors.white.white,
                                  ),
                        ),
                      ]
                    ],
                  ),
            ),
            Visibility(
              visible: isShowIcClose,
              child: Positioned(
                right: 6,
                top: -10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppAssetImage(
                    path: appIcon.icCloseCircle.path,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  _checkNetworkImage(String? path) {
    Widget image;
    if (path?.isEmpty ?? true) {
      image = AppAssetImage(
        path: appIcon.icBadge.path,
        fit: BoxFit.contain,
      );
    } else if (path!.contains('http') || path.contains('https')) {
      image = AppNetworkImage(
        imageUrl: path,
        fit: BoxFit.contain,
      );
    } else {
      image = AppAssetImage(
        path: path,
        fit: BoxFit.contain,
      );
    }

    return SizedBox(
      width: 200.w,
      height: 200.w,
      child: image,
    );
  }
}
