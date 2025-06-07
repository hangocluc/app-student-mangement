import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/theme/app_color.dart';
import '../../../../../common/theme/app_typography.dart';
import '../../theme/app_spacing.dart';
import 'widget/tabbar_params.dart';

class AppListTabBarWidget extends StatefulWidget {
  final List<TabBarParams> listTabBar;
  final Function(String type) onTap;
  final Function(int index)? onTapIndex;
  final Color? unSelectColor;
  final int isSelected;

  const AppListTabBarWidget(
      {super.key,
      required this.onTap,
      required this.listTabBar,
      required this.isSelected,
      this.onTapIndex,
      this.unSelectColor});

  @override
  State<AppListTabBarWidget> createState() => _AppListTabBarWidgetState();
}

class _AppListTabBarWidgetState extends State<AppListTabBarWidget> {
  int isSelect = 0;

  @override
  void initState() {
    isSelect = widget.isSelected;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppListTabBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      setState(() {
        isSelect = widget.isSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: AppSpacing.spacing4),
          itemCount: widget.listTabBar.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isSelect = index;
                });
                widget
                    .onTap(widget.listTabBar.elementAt(index).type ?? '$index');
                if (widget.onTapIndex != null) {
                  widget.onTapIndex!(index);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(right: AppSpacing.spacing2),
                child: _itemTabBar(
                    title: widget.listTabBar[index].title ?? '',
                    isSelect: isSelect == index),
              ),
            );
          }),
    );
  }

  _itemTabBar({required String title, required bool isSelect}) {
    return Container(
      height: 36.h,
      padding: EdgeInsets.symmetric(
          vertical: isSelect ? 4.h : 6.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              isSelect ? AppColors.primary.primary200 : AppColors.white.white,
          width: isSelect ? 3.0 : 0,
        ),
        color: isSelect
            ? AppColors.primary.primary400
            : widget.unSelectColor ?? AppColors.other.ColorF8F9FA,
      ),
      child: Text(
        title,
        style: isSelect
            ? AppTypography()
                .bodySmallSemiBold
                .copyWith(color: AppColors.white.white)
            : AppTypography()
                .bodySmallSemiBold
                .copyWith(color: AppColors.theBlack.theBlack800),
      ),
    );
  }
}
