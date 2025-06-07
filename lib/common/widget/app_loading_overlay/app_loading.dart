import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

class AppLoading extends StatelessWidget {
  factory AppLoading.centerLoading({double height = 24}) =>
      AppLoading(height: height);

  const AppLoading({super.key, this.height = 24});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing2),
        decoration: BoxDecoration(
          color: AppColors.theBlack.theBlack900,
          borderRadius: const BorderRadius.all(AppRadius.radius3),
        ),
        child: SizedBox(
          width: height,
          height: height,
          child: const CupertinoActivityIndicator(
            color: Colors.white,
            radius: 15,
          ),
        ),
      ),
    );
  }
}

Widget showLoading(bool isShowLoading) {
  if (isShowLoading) {
    return const AppLoading();
  }
  return const SizedBox();
}
