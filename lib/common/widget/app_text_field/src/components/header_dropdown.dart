import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../main.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../../app_icon/app_asset_image.dart';

class HeaderDropdown extends StatelessWidget {
  final String title;

  const HeaderDropdown({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing4,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1.h,
        color: AppColors.theBlack.theBlack50,
      ))),
      child: IntrinsicHeight(
        child: Column(
          children: [
            const SizedBox(
              height: AppSpacing.spacing2,
            ),
            Container(
              width: 64.w,
              height: 5.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColors.other.ColorCBD5E1,
              ),
            ),
            const SizedBox(
              height: AppSpacing.spacing6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTypography()
                      .bodyLargeSemiBold
                      .copyWith(color: AppColors.theBlack.theBlack900),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.spacing2),
                      child: AppAssetImage(path: appIcon.icClose.path)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
