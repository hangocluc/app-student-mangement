import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import '../../theme/app_color.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../utils/common_utils.dart';
import '../app_icon/app_asset_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;
  final Color? appBarColor;
  final Widget? flexibleWidget;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingFlexibleWidget;
  final Decoration? decoration;
  final bool isFlexibleWidget;
  final bool isShowIcon;
  final String? subTitle;
  final bool isCenterTitle;
  final Function? onBack;
  final bool isShowIconBack;
  final Widget? titleWidget;
  final bool isBackToHome;

  const CustomAppBar(
      {super.key,
      this.height,
      this.title,
      this.subTitle,
      this.actions,
      this.leading,
      this.backgroundColor = Colors.transparent,
      this.appBarColor,
      this.decoration,
      this.paddingFlexibleWidget,
      this.padding,
      this.flexibleWidget,
      this.isFlexibleWidget = false,
      this.isShowIcon = false,
      this.onBack,
      this.titleWidget,
      this.isCenterTitle = false,
      this.isShowIconBack = true,
      this.isBackToHome = true});

  @override
  Size get preferredSize => Size.fromHeight(height ?? 108.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: backgroundColor,
      padding: padding,
      child: isFlexibleWidget
          ? flexibleWidget ??
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: height ?? 188.h,
                decoration: BoxDecoration(
                  color: appBarColor ?? AppColors.other.ColorF8F9FA,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1C273114),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title ?? '',
                        style: AppTypography().heading3.copyWith(
                            color: AppColors.theBlack.theBlack950,
                            fontSize: 32),
                      ),
                      const SizedBox(
                        height: AppSpacing.spacing3,
                      ),
                      Text(
                        subTitle ?? '',
                        style: AppTypography().bodyLargeRegular.copyWith(
                            color: AppColors.theBlack.theBlack700,
                            fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
          : Container(
              height: height ?? 64.h + MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(
                  left: AppSpacing.spacing4,
                  top: MediaQuery.of(context).padding.top),
              decoration: decoration ??
                  BoxDecoration(
                    color: appBarColor ?? AppColors.other.ColorF8F9FA,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1C273114),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      isShowIconBack
                          ? GestureDetector(
                              onTap: () {
                                if (onBack != null) {
                                  onBack!();
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: leading ??
                                  Container(
                                    height: 44.w,
                                    width: 44.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.white.white,
                                      borderRadius: const BorderRadius.all(
                                          AppRadius.radius3),
                                    ),
                                    padding: EdgeInsets.all(12.w),
                                    child: AppAssetImage(
                                      path: appIcon.icClose.path,
                                    ),
                                  ),
                            )
                          : const SizedBox(),
                      Visibility(
                        visible: isCenterTitle ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: titleWidget ??
                              Text(
                                title ?? '',
                                style: AppTypography().heading5.copyWith(
                                      color: AppColors.theBlack.theBlack900,
                                    ),
                              ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isCenterTitle ? true : false,
                    child: Expanded(
                      child: Center(
                        child: titleWidget ??
                            Text(
                              title ?? 'Title',
                              style: AppTypography().heading5.copyWith(
                                    color: AppColors.theBlack.theBlack900,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...?actions,
                      Visibility(
                          visible: isBackToHome, child: backToHome(context)),
                      const SizedBox(
                        width: AppSpacing.spacing4,
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
